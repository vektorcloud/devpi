#!/bin/sh
set -ex

initialize=0

[[ -f $DEVPI_SERVERDIR/.serverversion ]] || { initialize=1; devpi-server --init; }

devpi-server --start --host 0.0.0.0 --port 3141

if [[ $initialize = yes ]]; then
  devpi use http://localhost:3141
  devpi login root --password=''
  devpi user -m root password="${DEVPI_PASSWORD}"
  devpi index -y -c dev pypi_whitelist='*' volatile='True'
fi

tail -f $DEVPI_SERVERDIR/.xproc/devpi-server/xprocess.log
