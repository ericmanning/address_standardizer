#!/usr/bin/env bash

. $(dirname $0)/winnie_common.sh
cd ${WORKSPACE}
make
make install
cp *.dll ${PGPATHEDB}/lib/
cp data/*.sql ${PGPATHEDB}/share/extension/
cp *.control ${PGPATHEDB}/share/extension/
make installcheck
