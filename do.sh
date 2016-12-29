#!/bin/bash
dev=oneplus2
make clobber && make clean
if [ $? -ne 0 ]; then
  exit 1
fi
for n in `grep + .repo/local_manifests/enabled/device.patch | grep -v ++ | grep -v PRODUCT | grep -v @@ | grep -v device.mk | grep -v wpa | awk '{print $2}'`; do mkdir out/target/common/obj/APPS/${n}_intermediates -p; done
startday=`date +%Y%m%d`
.repo/local_manifests/stash.sh
repo sync --force-sync -c
if [ $? -ne 0 ]; then
  exit 1
fi
#repo sync --force-broken --force-sync --no-clone-bundle --quiet
.repo/local_manifests/patch.sh
rm frameworks/base/core/res/res/values/*.orig
rm device/oneplus/oneplus2/*.orig
rm device/oneplus/oneplus3/*.orig

.repo/local_manifests/build.sh oneplus2
if [ $? -ne 0 ]; then
  exit 1
fi

filename=out/target/product/${dev}/lineage-14.1-*-UNOFFICIAL-${dev}.zip
newfile=~/roms/lineage-14.1-${startday}-microg-${dev}.zip
mv ${filename} ${newfile}
MSG=`tail -2 build.log`
androidpn.py -t "OP2 CM 14.1 BUILD" -m "${MSG}"
#ftppass=`cat .repo/local_manifest/ftppassword`
pass=`cat .repo/local_manifests/afhpassword`
#lftp ftp://daktak:${ftppass}@192.168.1.92:12345 -e "cd roms; put lineage-14.1-20161223-microg-${dev}.zip;  bye"
lftp sftp://daktak:${pass}@uploads.androidfilehost.com  -e "put ${newfile}; bye"
exit 0

# rm out/target/product/oneplus2/ -rf
# rm ../.ccache/* -rf
# dev=oneplus3
# patch -r - -p0 -R < .repo/local_manifests/enabled/afh.patch
# patch -r - -p0 < .repo/local_manifests/enabled/op3/afh.patch
# .repo/local_manifests/build.sh ${dev}
# if [ $? -ne 0 ]; then
#   exit 1
# fi
# newfile=~/roms/lineage-14.1-${startday}-microg-${dev}.zip
# filename=out/target/product/${dev}/lineage-14.1-*-UNOFFICIAL-${dev}.zip
# mv ${filename} ${newfile}
# MSG=`tail -2 build.log`
# androidpn.py -t "OP3 CM 14.1 BUILD" -m "${MSG}"
# lftp sftp://daktak:${pass}@uploads.androidfilehost.com  -e "put ${newfile}; bye"
# patch -r - -p0 -R < .repo/local_manifests/enabled/op3/afh.patch
# patch -r - -p0 < .repo/local_manifests/enabled/afh.patch

