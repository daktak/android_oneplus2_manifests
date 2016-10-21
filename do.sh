#!/bin/bash
make clobber
mkdir /pub/aosp/out/target/common/obj/APPS/GmsCore_intermediates -p
mkdir /pub/aosp/out/target/common/obj/APPS/FakeStore_intermediates -p
mkdir /pub/aosp/out/target/common/obj/APPS/GsfProxy_intermediates -p


curl --create-dirs -L -o .repo/local_manifests/roomservice.xml -O -L https://raw.githubusercontent.com/Seraph08/oneplus2_manifests/master/cm-14.0.xml
startday=`date +%Y%m%d`
.repo/local_manifests/stash.sh
repo sync --force-sync
#repo sync --force-broken --force-sync --no-clone-bundle --quiet
.repo/local_manifests/patch.sh
rm frameworks/base/core/res/res/values/*.orig
rm device/oneplus/oneplus2/*.orig
.repo/local_manifests/build.sh
#endday=`date +%Y%m%d`

filename=out/target/product/oneplus2/cm-14.0-${startday}-UNOFFICIAL-oneplus2.zip
mv ${filename} ~/cm-14.0-${startday}-microg-oneplus2.zip

