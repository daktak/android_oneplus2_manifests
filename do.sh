#!/bin/bash
curl --create-dirs -L -o .repo/local_manifests/roomservice.xml -O -L https://raw.githubusercontent.com/Seraph08/oneplus2_manifests/master/cm-14.0.xml
startday=`date +%Y%m%d`
.repo/local_manifests/stash.sh
repo sync --force-broken --force-sync --no-clone-bundle --quiet
.repo/local_manifests/patch.sh
rm frameworks/base/core/res/res/values/*.orig
.repo/local_manifests/build.sh
#endday=`date +%Y%m%d`

filename="/out/target/product/oneplus2/cm-14.0-${startday}-UNOFFICIAL-oneplus2.zip"
mv "${filename}" ~/cm-14.0-${startday}-microg-oneplus2.zip"

