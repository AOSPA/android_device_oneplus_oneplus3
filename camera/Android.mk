LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := op3_cam.c
LOCAL_MODULE := libop3_cam
LOCAL_MODULE_TAGS := optional
LOCAL_32_BIT_ONLY := true
LOCAL_SHARED_LIBRARIES := libgui

include $(BUILD_SHARED_LIBRARY)
