# Common code for all winnie scripts
#
# TODO: add more shared code, I guess
#

set -e

export PROJECTS=/projects
# Don't convert paths
# See https://trac.osgeo.org/postgis/ticket/5436#comment:5
export MSYS2_ARG_CONV_EXCL=/config/tags
#jenkins configs
#export PG_VER=18
#export OS_BUILD=64
#export GCC_TYPE=
#export PGPORT=5455


#export GCC_TYPE=
#if no override is set - use these values
#otherwise use the ones jenkins passes thru
if  [[ "${PCRE2_VER}" == '' ]] ; then
  export PCRE2_VER=10.42
fi;

export PCRE2_PATH=${PROJECTS}/pcre2/rel-pcre2-${PCRE2_VER}w${OS_BUILD}${GCC_TYPE}


export LZ4_PATH=${PROJECTS}/lz4/rel-lz4-${LZ4_VER}w${OS_BUILD}${GCC_TYPE}
echo ${PATH}

PATH="/mingw64/bin:/usr/local/bin:/usr/bin:/bin:/c/Windows/System32:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"

export PROJECTS=/projects
export MINGPROJECTS=/projects


if [ "$OS_BUILD" == "64" ] ; then
	export MINGHOST=x86_64-w64-mingw32
else
	export MINGHOST=i686-w64-mingw32
fi;


#export WORKSPACE=`pwd`
export WORKSPACE=${SOURCE_FOLDER}
echo Workspace is: $WORKSPACE

echo PATH BEFORE: $PATH

export PGUSER=postgres
#export GEOS_VER=3.4.0dev
#export GDAL_VER=1.9.1
export PGPATH=${PROJECTS}/postgresql/rel/pg${PG_VER}w${OS_BUILD}${GCC_TYPE}
export PGPATHEDB=${PROJECTS}/postgresql/rel/pg${PG_VER}w${OS_BUILD}${GCC_TYPE}edb

export PATH="${PGPATH}/bin:${PGPATH}/lib:${PATH}"
CPPFLAGS="-I${PGPATH}/include"

#add lz4
export PATH="${LZ4_PATH}/bin:${LZ4_PATH}/lib:${PATH}"

#add pcre2
export PATH="${PCRE2_PATH}/bin:${PATH}"

export SHLIB_LINK="-static-libstdc++ -lstdc++ -Wl,-Bdynamic -lm"

CPPFLAGS="-I${PGPATH}/include"


#
# To set the version,from control file if not passed in
#
if  [[ "${AS_VER}" == '' ]] ; then
	export AS_VER=$(shell grep default address_standardizer.control | cut -f2 -d'=' | tr -d "' ")
fi;

echo "PATH AFTER: $PATH"
