#!/bin/bash

# Project Name - handles Jenkins workspace paths
if [ $(basename $SOURCEDIR) == "workspace" ]; then
  export NAME=$(basename $(dirname ${SOURCEDIR}) |  sed 's/check_mk-//g')
else
  export NAME=$( echo $(basename ${SOURCEDIR}) | sed 's/check_mk-//g' )
fi

# Gets the version from Git tags or just uses date-time
if [[ $(git status 2>/dev/null) ]]; then
  VERSION=$(git describe --tags | sed 's/-/./g')
else
  VERSION="v99.$(date +'%Y%m%d.%H%M%S')"
fi
export VERSION

# Gets the package title and description from the title inside the check man page, if present
MANFILE=${SOURCEDIR}/docs/${NAME}
if [ -f ${MANFILE} ]; then
  TITLE="$(grep title ${MANFILE}  | awk -F': ' '{print $NF}')"
  DESCRIPTION="$(cat ${MANFILE} | perl -e 'while (<>) { print if /^description:\s+$/i .. /^item:\s+$/ }' | grep -v ':')"
else # or uses the project's NAME
  TITLE=${NAME}
  DESCRIPTION=${NAME}
fi
export TITLE DESCRIPTION

# Package Descriptor Variables
export AUTHOR="MIS Monitoring Desk"
export CMK_MIN_VERSION="1.2.6p1"

# Determine which version of CMK is available
export CMK_PKG_VERSION="1.2.6p12"

export DESCRIPTION="Package Descr"
export URL="http://mxplgitas01.mbdom.mbgroup.ad/Monitoring/check_mk-${NAME}"

# Now populate files arrays: this is needed for custom package descriptors
pushd ${SOURCEDIR}/agents > /dev/null
export AGENTS=$(find . -type f|xargs|sed 's/ /,/g; s/\.\///g')
popd > /dev/null

pushd ${SOURCEDIR}/docs > /dev/null
export CHECKMAN=$(find . -type f|xargs|sed 's/ /,/g;s/\.\///g')
popd > /dev/null

pushd ${SOURCEDIR}/checks > /dev/null
export CHECKS=$(find . -type f|xargs|sed 's/ /,/g;s/\.\///g')
popd > /dev/null

pushd ${SOURCEDIR}/templates > /dev/null
export PNP_TEMPLATES=$(find . -type f|xargs|sed 's/ /,/g;s/\.\///g')
popd > /dev/null

pushd ${SOURCEDIR}/web > /dev/null
WEB=$(find . -type f| grep -E  'config|dashboard|icons|pages|perfometer|sidebar|views|visuals|wato' | xargs | sed 's/ /,/g;s/\.\///g')
WEB=$(find . -type d| grep -vE 'config|dashboard|icons|pages|perfometer|sidebar|views|visuals|wato|plugins$|\.$' | xargs |  sed 's/ /,/g;s/\.\///g')
export WEB
popd > /dev/null

