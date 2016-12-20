#!/bin/bash
make clobber && make clean
if [ $? -ne 0]; then
  exit 1
fi
for n in `grep + .repo/local_manifests/enabled/device.patch | grep -v ++ | grep -v PRODUCT | grep -v @@ | grep -v device.mk | grep -v wpa | awk '{print $2}'`; do mkdir out/target/common/obj/APPS/${n}_intermediates -p; done
#curl --create-dirs -L -o .repo/local_manifests/roomservice.xml -O -L https://raw.githubusercontent.com/Seraph08/oneplus2_manifests/master/cm-14.0.xml
startday=`date +%Y%m%d`
.repo/local_manifests/stash.sh
repo sync --force-sync
if [ $? -ne 0 ]; then
  exit 1
fi
#repo sync --force-broken --force-sync --no-clone-bundle --quiet
.repo/local_manifests/patch.sh
rm frameworks/base/core/res/res/values/*.orig
rm device/oneplus/oneplus2/*.orig

.repo/local_manifests/build.sh
if [ $? -ne 0 ]; then
  exit 1
fi

filename=out/target/product/oneplus2/cm-14.1-*-UNOFFICIAL-oneplus2.zip
newfile=~/roms/cm-14.1-${startday}-microg-oneplus2.zip
mv ${filename} ${newfile}
MSG=`tail -2 build.log`
androidpn.py -t "CM 14.1 BUILD" -m "${MSG}"
pass=`cat .repo/local_manifests/afhpassword`
#.repo/local_manifests/put.ex ${pass} uploads.androidfilehost.com daktak ${newfile}
lftp sftp://daktak:${pass}@uploads.androidfilehost.com  -e "put ${newfile}; bye"
