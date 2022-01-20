# https://docs.docker.com/engine/reference/builder/
# https://docs.docker.com/compose/compose-file/compose-file-v3/
# https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible

ARG IMAGE_NAME="debian"
ARG IMAGE_VERSION="stable-slim"

# ===============================================
# PRE-IMAGE: Download external resources
# ===============================================

FROM ${IMAGE_NAME}:${IMAGE_VERSION} AS pre

ARG NOMAD_PACK_BASEURL="https://github.com/hashicorp/nomad-pack/releases/download/nightly"
ARG NOMAD_PACK_VERSION="0.0.1-techpreview1"
ARG NOMAD_PACK_ARCH="linux_amd64"

RUN set -ex \
  && echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
  && apt-get update \
  && apt-get -qqy install --no-install-recommends apt-utils > /dev/null 2>&1 \
  && apt-get -qqy install --no-install-recommends ca-certificates curl unzip \
  && apt-get autoclean \
  && mkdir -p /srv/exports \
  && curl -fsSL -o /tmp/archive.zip "${NOMAD_PACK_BASEURL}/nomad-pack_${NOMAD_PACK_VERSION}_${NOMAD_PACK_ARCH}.zip" \
  && unzip /tmp/archive.zip -d /srv/exports


# ===============================================
# BUILD RUNTIME IMAGE
# ===============================================

FROM ${IMAGE_NAME}:${IMAGE_VERSION}

ENV NOMAD_ADDR="http://127.0.0.1:4646"
ENV NOMAD_TOKEN=

# INSTALL APT-PACKAGES
RUN set -ex \
  && echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
  && apt-get update \
  && apt-get -qqy install --no-install-recommends apt-utils vim.tiny > /dev/null 2>&1 \
  && apt-get -qqy install --no-install-recommends dumb-init gosu ca-certificates git \
  && apt-get autoclean

# CREATE NON-PRIVILEGED USER
RUN set -ex \
  && addgroup pack \
  && adduser --quiet \
     --ingroup pack \
     --gecos "Nomad-Pack User" \
     --disabled-password pack

COPY --from=pre ["/srv/exports/nomad-pack", "/usr/local/bin/"]

COPY --chmod="755" ["docker-entrypoint.sh", "/usr/local/bin/"]
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["nomad-pack","--version"]
