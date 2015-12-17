#!/bin/bash

. ./lib/util.sh
. ./lib/pkg_environment.sh

mkdir -p ${SOURCEDIR}/archive/

su - ${SITE} -c "cmk -P pack ${NAME}"

mv ${OMDBASE}/${SITE}/${NAME}-*.mkp ${SOURCEDIR}/archive/