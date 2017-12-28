LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_C_INCLUDES := \
    frameworks/av/include

LOCAL_SRC_FILES := \
    CameraParameters.cpp

LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)
LOCAL_MODULE := libcamera_parameters_ext
LOCAL_MODULE_TAGS := optional

include $(BUILD_STATIC_LIBRARY)
