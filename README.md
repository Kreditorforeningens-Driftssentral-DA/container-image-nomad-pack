# container-image-nomad-pack
[![Build and Push (Public)](https://github.com/Kreditorforeningens-Driftssentral-DA/container-image-nomad-pack/actions/workflows/docker-public.yml/badge.svg)](https://github.com/Kreditorforeningens-Driftssentral-DA/container-image-nomad-pack/actions/workflows/docker-public.yml)

The official image is missing requirement git, which makes it more or less useless.

- Download image from [Docker Hub](https://hub.docker.com/repository/docker/kdsda/nomad-pack).
- Source on [GitHub](https://github.com/Kreditorforeningens-Driftssentral-DA/container-image-nomad-pack).
- Nomad-Pack source on [GitHub](https://github.com/hashicorp/nomad-pack).
- hashiCorp official image on [Docker Hub](https://hub.docker.com/r/hashicorp/nomad-pack).

NOTE: The binary itself is only ~30MB; if you are using nomad-pack in a pipeline, it might be better to
download the binary on the runner itself (runners have git installed by default).

# IMAGES

Monthly builds. Use "<YEAR.WEEK>" tag for pinning image version.

| IMAGE | SIZE (uncompressed) |
| :-- | :-: |
| ALPINE | ~50MB |
| DEBIAN | ~190MB |


#### ENVIRONMENT VARIABLES

| VARIABLE | DEFAULT | DESCRIPTION |
| :-- | :-: | :-- |
| NOMAD_ADDR | http://127.0.0.1:4646  | Target Nomad API-server |
| NOMAD_TOKEN | (Unset) | Nomad token to pass for authentication |


## EXAMPLES

```bash
# Default (print version)
docker run --rm -it kdsda/nomad-pack:0.0.1

# List packs from public regstry
docker run --rm -it -e NOMAD_ADDR=https://example.nomad.com:4646 kdsda/nomad-pack:0.0.1 nomad-pack registry list
```