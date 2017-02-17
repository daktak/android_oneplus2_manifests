wget "https://github.com/android/platform_frameworks_base/compare/master...SubstratumResources:n-mr1-oms7.diff" -O .repo/local_manifests/enabled/oms-frameworks_base.patch
wget "https://github.com/SubstratumResources/platform_frameworks_native/compare/n-mr1-oms7.diff" -O .repo/local_manifests/enabled/oms-frameworks_native.patch
wget "https://github.com/SubstratumResources/platform_system_sepolicy/compare/n-mr1-oms7.diff" -O .repo/local_manifests/enabled/oms-system_sepolicy.patch
sed -i.bak 's/--- a\//--- frameworks\/base\//g' .repo/local_manifests/enabled/oms-frameworks_base.patch
sed -i.bak 's/--- a\//--- frameworks\/native\//g' .repo/local_manifests/enabled/oms-frameworks_native.patch
sed -i.bak 's/--- a\//--- system\/sepolicy\//g' .repo/local_manifests/enabled/oms-system_sepolicy.patch
sed -i.bak 's/+++ b\//+++ frameworks\/base\//g' .repo/local_manifests/enabled/oms-frameworks_base.patch
sed -i.bak 's/+++ b\//+++ frameworks\/native\//g' .repo/local_manifests/enabled/oms-frameworks_native.patch
sed -i.bak 's/+++ b\//+++ system\/sepolicy\//g' .repo/local_manifests/enabled/oms-system_sepolicy.patch

