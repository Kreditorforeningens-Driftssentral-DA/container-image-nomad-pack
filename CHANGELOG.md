# CHANGELOG

## February 25, 2022
  * Added openssh-client to image (for authenticating w/private pack-registries).
  * Added github.com/bitbucket.org/gitlab.com to ssh "known_hosts" during build.

## February 21, 2022
  * Updated download-url to use 'https://releases.hashicorp.com/nomad-pack/'

## February 11, 2022
  * New nomad-pack release: [v0.0.1-techpreview2](https://github.com/hashicorp/nomad-pack/blob/main/CHANGELOG.md#001-techpreview2-february-07-2022). NOTE: 'v0.0.1-techpreview1' binary no longer downloadable.

## January 27, 2022
  * Added github action for github-registry build/push.

## January 21, 2022
  * Added github workflow example to README

## January 20, 2022
  * Manual triggered pipelines for initial image-builds to docker-hub.
  * Changed pipeline to build on monthly schedule instead of release/tag (tags from build-matrix instead).
  * Added alpine container.
  * Removed extra packages from debian to reduce size.
  * Initial release/build.
