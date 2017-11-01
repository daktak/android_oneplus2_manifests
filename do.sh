#!/bin/bash
dev=$1
if [ -z ${dev} ]; then
  dev=oneplus5
fi
. build/envsetup.sh
#breakfast omni_oneplus5-userdebug
breakfast ${dev}
if [ -z $2 ]; then
  make clobber && make clean
  if [ $? -ne 0 ]; then
	  echo "make clobber & clean failed"
    exit 1
  fi
fi
for n in `grep + .repo/local_manifests/enabled/device-${dev}.patch | grep -v ++ | grep -v PRODUCT | grep -v @@ | grep -v device.mk | grep -v wpa | awk '{print $2}'`; do mkdir out/target/common/obj/APPS/${n}_intermediates -p; done
startday=`date +%Y%m%d`
if [ -z $2 ]; then
  .repo/local_manifests/stash.sh
  repo forall -c "git reset --hard" -j48
  repo forall -c "git clean -fd" -j48
  repo sync --force-sync -cdf -j48

  #repo forall -vc "git reset --hard"
  #repo sync --force-sync -c
  if [ $? -ne 0 ]; then
    .repo/local_manifests/patch.sh
    echo "sync failed"
    exit 1
  fi
  .repo/local_manifests/patch.sh
  cd device/oneplus/oneplus5
  git fetch https://gerrit.omnirom.org/android_device_oneplus_oneplus5 refs/changes/68/26268/7 && git cherry-pick FETCH_HEAD
  cd ../../..
  cd vendor/omni
  git fetch https://gerrit.omnirom.org/android_vendor_omni refs/changes/08/26208/1 && git cherry-pick FETCH_HEAD
  cd ../..
fi
#repo sync --force-broken --force-sync --no-clone-bundle --quiet
rm frameworks/base/core/res/res/values/*.orig
rm device/oneplus/${dev}/*.orig
#patch -r - -p0 < .repo/local_manifests/enabled/${dev}/afh.patch
#rm packages/apps/afh_downloader/app/src/main/res/values/donottranslate.xml.orig

#.repo/local_manifests/build.sh ${dev} 
brunch ${dev} > build.log
#if [ $? -ne 0 ]; then
#  patch -r - -p0 -R < .repo/local_manifests/enabled/${dev}/afh.patch
#  echo "build failed"
#  exit 1
#fi
#patch -r - -p0 -R < .repo/local_manifests/enabled/${dev}/afh.patch

#filename=out/target/product/${dev}/lineage-14.1-*-UNOFFICIAL-${dev}.zip
filename=/home/user/android/system/out/target/product/${dev}/omni-8.0.0-*-${dev}-HOMEMADE.zip
newfile=~/roms/omni-8.0.0-${startday}-microg-${dev}-HOMEMADE.zip
#filen="${newfile##*/}"
mv ${filename} ${newfile}
#MSG=`tail -2 build.log`
#androidpn.py -t "Linaeage 14.1 BUILD" -m "${filen} \
#${MSG}"
ftppass=`cat .repo/local_manifest/ftppassword`
pass=`cat .repo/local_manifests/afhpassword`
#lftp ftp://daktak:${ftppass}@192.168.43:12345 -e "cd roms; put ${newfile};  bye"
lftp sftp://daktak:${pass}@uploads.androidfilehost.com  -e "put ${newfile}; bye"
exit 0
