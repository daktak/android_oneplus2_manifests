#!/bin/bash 
#repo sync --force-broken --force-sync --no-clone-bundle --quiet
. build/envsetup.sh
export PATH=/home/daktak/.gentoo/java-config-2/current-user-vm/bin:$PATH
#. build/envsetup.sh
export USE_CCACHE=1
prebuilts/misc/linux-x86/ccache/ccache -M 2G
export ANDROID_CCACHE_SIZE="2G"
export ANDROID_CCACHE_DIR="/pub/aosp/android/.ccache"
breakfast oneplus2
croot
#make org.cyanogenmod.platform -j1
mka org.cyanogenmod.platform-res -j1
#cd vendors/cmsdk
#mma -j1
#cd ../..
#mka -j1
brunch oneplus2
