# container-image-nomad-pack
[![Build (Docker)](https://github.com/Kreditorforeningens-Driftssentral-DA/container-image-nomad-pack/actions/workflows/docker-build.yml/badge.svg)](https://github.com/Kreditorforeningens-Driftssentral-DA/container-image-nomad-pack/actions/workflows/docker-build.yml)

The official image is missing requirement git, which makes it more or less useless.

- Source on [GitHub](https://github.com/Kreditorforeningens-Driftssentral-DA/container-image-nomad-pack).
- Pull image from [Docker Hub](https://hub.docker.com/repository/docker/kdsda/nomad-pack).
- Pull image from [GitHub](https://github.com/Kreditorforeningens-Driftssentral-DA/container-image-nomad-pack/pkgs/container/container-image-nomad-pack).
- HashiCorp Nomad-Pack source on [GitHub](https://github.com/hashicorp/nomad-pack).
- HashiCorp Nomad-Pack official image on [Docker Hub](https://hub.docker.com/r/hashicorp/nomad-pack).

NOTE: The binary itself is only ~30MB; if you are using nomad-pack in a pipeline, it might be better to
download the binary on the runner itself (runners have git installed by default).

# IMAGES

Monthly builds. Use "<YEAR.WEEK>" tag for pinning image version.

| IMAGE | SIZE | SIZE (uncompressed) |
| :-- | :-: | :-: |
| ALPINE | ~20MB | ~50MB |
| DEBIAN | ~70MB | ~190MB |


#### ENVIRONMENT VARIABLES

| VARIABLE | DEFAULT | DESCRIPTION |
| :-- | :-: | :-- |
| NOMAD_ADDR | http://127.0.0.1:4646  | Target Nomad API-server |
| NOMAD_TOKEN | (Unset) | Nomad token to pass for authentication |


## EXAMPLES

#### Using docker cli

```bash
# Default (print version)
docker run --rm -it kdsda/nomad-pack:alpine-0.0.1-techpreview2

# List packs from public registry
docker run --rm -it -e NOMAD_ADDR=https://example.nomad.com:4646 kdsda/nomad-pack:alpine-0.0.1-techpreview1 nomad-pack registry list

# Render job from public registry
docker run --rm -it -e NOMAD_ADDR=https://example.nomad.com:4646 kdsda/nomad-pack:alpine-0.0.1-techpreview1 nomad-pack render traefik
```


#### Using private pack-registries
```bash
# Auth: HTTP
nomad-pack registry add example https://github.com/<github-user>/nomad-pack-private-registry --target=hello_world_private
```

```bash
# Auth: SSH-agent
ssh-keyscan -H github.com >> ~/.ssh/known_hosts
eval "$(ssh-agent -s)"
ssh-add .ssh/<private-key>
nomad-pack registry add example git@github.com:<github-user>/nomad-pack-private-registry.git --target=hello_world_private
```

```bash
# Auth: SSH config (no agent)
#
# File: ~/.ssh/config
# Host github.com
#   Hostname github.com
#   User git
#   IdentityFile ~/.ssh/deploykey
ssh-keyscan -H github.com >> ~/.ssh/known_hosts
nomad-pack registry add example git@github.com:<github-user>/nomad-pack-private-registry.git --target=hello_world_private
```

```bash
# Using pack
nomad-pack render hello_world_private --registry=example
```

#### Using with GitHub Workflow
```yml
# GitHub Workflow
---
name: CICD

on:
  workflow_dispatch:

jobs:
  
  example:
    runs-on: ubuntu-latest
    container:
      image: kdsda/nomad-pack:alpine-0.0.1-techpreview1
    steps:
    -
      uses: actions/checkout@v2
      with:
        fetch-depth: 1
    -
      name: local-nomad-pack
      run: |
        nomad-pack version
        nomad-pack render <local-pack>
    -
      name: public-nomad-pack
      run: |
        nomad-pack version
        nomad-pack render nginx
```