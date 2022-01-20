#!/usr/bin/dumb-init /bin/bash

# Run commands as pack user, unless env is set
if [ -z "${RUN_AS_ROOT}" ]; then
  pushd /home/pack
  set -- gosu pack ${@}
fi

exec ${@}
