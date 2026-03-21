#!/usr/bin/env bash
### this script is used to zip up the compiled binaries
## PostgreSQL, OS_BUILD denote the last build to be packaged
## and are passed in by the jenkins job process
###

. $(dirname $0)/winnie_common.sh
cd ${WORKSPACE}

export REL_PGVER=${PG_VER//./} #strip the period


export RELDIR=${PROJECTS}/address_standardizer/builds/${AS_VER}
export RELVERDIR=address_standardizer-pg${REL_PGVER}-binaries-${AS_VER}w${OS_BUILD}${GCC_TYPE}

outdir="${RELDIR}/${RELVERDIR}"
package="${RELDIR}/${RELVERDIR}.zip"
verfile="${RELDIR}/${RELVERDIR}/version.txt"
rm -rf $outdir
rm -f $package
mkdir -p $outdir
mkdir -p $outdir/share/extension
mkdir $outdir/bin
mkdir $outdir/lib

cp /c/ming${OS_BUILD}${GCC_TYPE}/mingw${OS_BUILD}/bin/libstdc++-6.dll $outdir/bin
cp /c/ming${OS_BUILD}${GCC_TYPE}/mingw${OS_BUILD}/bin/libgcc*.dll $outdir/bin

echo "ADDRESS_STANDARDIZER: ${AS_VER} https://github.com/postgis/address_standardizer" > $verfile

strip *.dll


cp -r *.control ${outdir}/share/extension
cp -r *.dll ${outdir}/lib/
cp -r README.md ${outdir}/
cp -r ${PCRE2_PATH}/bin/*.dll ${outdir}/bin/


cd ${RELDIR}
zip -r $package ${RELVERDIR}
md5sum $package > ${package}.md5

cp $package ${PROJECTS}/postgis/win_web/download/windows/pg${REL_PGVER}/buildbot
cp ${package}.md5 ${PROJECTS}/postgis/win_web/download/windows/pg${REL_PGVER}/buildbot

