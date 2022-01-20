# container-image-nomad-pack
Official image is missing requirement git, which makes it useless.

- Download image from [Docker Hub](https://hub.docker.com/repository/docker/kdsda/nomad-pack).
- Source on [GitHub](https://github.com/Kreditorforeningens-Driftssentral-DA/container-image-nomad-pack).
- Nomad Pack source on [GitHub](https://github.com/hashicorp/nomad-pack).
- Official image on [Docker Hub](https://hub.docker.com/r/hashicorp/nomad-pack).

NOTE: The binary itself is only ~30MB, but this image is ~200MB uncompressed (due to git).
If you are using nomad-pack in a pipeline, it might be better to download the binary
on the runner itself (runners have git installed by default).


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
