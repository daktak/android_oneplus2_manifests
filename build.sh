#!/bin/bash 
#repo sync --force-broken --force-sync --no-clone-bundle --quiet
. build/envsetup.sh
export PATH=/home/daktak/.gentoo/java-config-2/current-user-vm/bin:$PATH
#. build/envsetup.sh
export USE_CCACHE=1
prebuilts/misc/linux-x86/ccache/ccache -M 20G
export ANDROID_CCACHE_SIZE="20G"
export ANDROID_CCACHE_DIR="/pub/aosp/android/.ccache"
#breakfast oneplus2
croot
#mka framework-res -j2
#mka org.cyanogenmod.platform -j2
#mka org.cyanogenmod.platform-res -j2
#mkdir /pub/aosp/out/target/common/obj/APPS/GmsCore_intermediates -p
#mkdir /pub/aosp/out/target/common/obj/APPS/FakeStore_intermediates -p
#mkdir /pub/aosp/out/target/common/obj/APPS/GfsProxy_intermediates -p
#cd vendor/cmsdk
#mma -j1
#cd ../..
#mka -j1
brunch oneplus2
