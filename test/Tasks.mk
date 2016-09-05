LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := OpenTasks
LOCAL_MODULE_TAGS := optional
LOCAL_PACKAGE_NAME := OpenTasks

opentasks_root  := $(LOCAL_PATH)
opentasks_dir   := app
opentasks_out   := $(OUT_DIR)/target/common/obj/APPS/$(LOCAL_MODULE)_intermediates
opentasks_build := $(opentasks_root)/$(opentasks_dir)/build
opentasks_apk   := build/outputs/apk/OpenTasks-release-unsigned.apk

$(opentasks_root)/$(opentasks_dir)/$(opentasks_apk):
	rm -Rf $(opentasks_build)
	mkdir -p $(opentasks_out)
	mkdir -p $(opentasks_build)
	ln -sf $(opentasks_out) $(opentasks_build)
	cd $(opentasks_root) && JAVA_TOOL_OPTIONS="$(JAVA_TOOL_OPTIONS) -Dfile.encoding=UTF8" ./gradlew assembleRelease

LOCAL_CERTIFICATE := platform
LOCAL_SRC_FILES := $(opentasks_dir)/$(opentasks_apk)
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)

include $(BUILD_PREBUILT)
