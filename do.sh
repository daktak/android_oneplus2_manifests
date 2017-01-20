#!/bin/bash
dev=$1
if [ -z ${dev} ]; then
  dev=oneplus2
fi
if [ -z $2 ]; then
  make clobber && make clean
  if [ $? -ne 0 ]; then
    exit 1
  fi
fi
for n in `grep + .repo/local_manifests/enabled/device-${dev}.patch | grep -v ++ | grep -v PRODUCT | grep -v @@ | grep -v device.mk | grep -v wpa | awk '{print $2}'`; do mkdir out/target/common/obj/APPS/${n}_intermediates -p; done
startday=`date +%Y%m%d`
if [ -z $2 ]; then
  .repo/local_manifests/stash.sh
  repo sync --force-sync -c
  if [ $? -ne 0 ]; then
    .repo/local_manifests/patch.sh
    exit 1
  fi
  .repo/local_manifests/patch.sh
fi
#repo sync --force-broken --force-sync --no-clone-bundle --quiet
rm frameworks/base/core/res/res/values/*.orig
rm device/oneplus/${dev}/*.orig
patch -r - -p0 < .repo/local_manifests/enabled/${dev}/afh.patch
rm packages/apps/afh_downloader/app/src/main/res/values/donottranslate.xml.orig

.repo/local_manifests/build.sh ${dev} 
if [ $? -ne 0 ]; then
  patch -r - -p0 -R < .repo/local_manifests/enabled/${dev}/afh.patch
  exit 1
fi
patch -r - -p0 -R < .repo/local_manifests/enabled/${dev}/afh.patch

filename=out/target/product/${dev}/lineage-14.1-*-UNOFFICIAL-${dev}.zip
newfile=~/roms/lineage-14.1-${startday}-microg-${dev}.zip
filen="${newfile##*/}"
mv ${filename} ${newfile}
MSG=`tail -2 build.log`
androidpn.py -t "Linaeage 14.1 BUILD" -m "${filen} \
${MSG}"
#ftppass=`cat .repo/local_manifest/ftppassword`
pass=`cat .repo/local_manifests/afhpassword`
#lftp ftp://daktak:${ftppass}@192.168.1.92:12345 -e "cd roms; put lineage-14.1-20161223-microg-${dev}.zip;  bye"
lftp sftp://daktak:${pass}@uploads.androidfilehost.com  -e "put ${newfile}; bye" && androidpn.py -t "Lineage 14.1 Upload" -m "${newfile}" &
exit 0
