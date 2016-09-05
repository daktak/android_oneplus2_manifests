#!/bin/bash
#alias gradle=~/.gradle/wrapper/dists/gradle-2.12-all/4ng70i0k4ou37vg5et2lk2qc7s/gradle-2.12/bin/gradle
cd /pub/cm13
source build/envsetup.sh
export USE_CCACHE=1
prebuilts/misc/linux-x86/ccache/ccache -M 50G
export ANDROID_CCACHE_SIZE="50G"
export ANDROID_CCACHE_DIR="/pub/cm13/android/.ccache"
#gms patch
cd frameworks/base
git stash
cd ../..
#add apps
cd device/oneplus/oneplus2
git stash
cd ../../..
#fdroid
cd packages/apps/FDroid
git stash
cd ../../..
#un
cd packages/apps/unifiedNlpBackend
git stash
cd ../../..
#nomi
cd packages/apps/NominatemBackend
git stash
cd ../../..
#localgsm
cd packages/apps/LocalGSMBackend
git stash
cd ../../..
#tasks
#cd packages/apps/Tasks
#git stash
#cd ../../..
#davd
#cd packages/apps/DAVDroid
#git stash 
#cd ../../..
#Ichnea
cd packages/apps/IchnaeaLnpBackend 
git stash
cd ../../..
curl --create-dirs -L -o .repo/local_manifests/roomservice.xml -O -L https://raw.githubusercontent.com/Seraph08/oneplus2_manifests/master/cm-13.0.xml
repo sync --force-sync
patch -p0 < .repo/local_manifests/android_frameworks_base-M.patch
patch -p0 < .repo/local_manifests/device.mk.patch
patch -p0 < .repo/local_manifests/fdroid.patch
cp .repo/local_manifests/unifiedNlpBackend.mk packages/apps/unifiedNlpBackend/Android.mk
chmod a+x packages/apps/unifiedNlpBackend/gradlew
cp .repo/local_manifests/NominatemBackend.mk packages/apps/NominatemBackend/Android.mk
chmod a+x packages/apps/NominatemBackend/gradlew
cp .repo/local_manifests/LocalGSMBackend.mk packages/apps/LocalGSMBackend/Android.mk
cp .repo/local_manifests/IchnaeaLnp.mk packages/apps/IchnaeaLnpBackend/Android.mk
#cp .repo/local_manifests/DAVDroid.mk packages/apps/DAVDroid/Android.mk
#cp .repo/local_manifests/Tasks.mk packages/apps/Tasks/Android.mk
cp .repo/local_manifests/yahoo.mk vendor/cmsdk/samples/weatherproviderservice/YahooWeatherProvider/Android.mk
touch /pub/cm13/out/target/product/oneplus2/obj/ETC/file_contexts_intermediates/file_contexts
croot
brunch oneplus2 > build.log
#update
mv out/target/product/oneplus2/*.zip* /pub/syncthing/daktak/videos
