DEVICE_PACKAGE_OVERLAYS := device/oneplus/oneplus3/overlay
TARGET_USES_NQ_NFC := true
TARGET_ENABLE_QC_AV_ENHANCEMENTS := true

# copy customized media_profiles and media_codecs xmls for oneplus3
PRODUCT_COPY_FILES += $(LOCAL_PATH)/media/media_profiles.xml:system/etc/media_profiles.xml \
                      $(LOCAL_PATH)/media/media_codecs.xml:system/etc/media_codecs.xml \
                      $(LOCAL_PATH)/media/media_codecs_performance.xml:system/etc/media_codecs_performance.xml

$(call inherit-product, device/oneplus/oneplus3/common64.mk)
$(call inherit-product, vendor/oneplus/oneplus3/oneplus3-vendor.mk)
include $(TOPDIR)hardware/qcom/audio/configs/msm8996/msm8996.mk

#Android EGL implementation
PRODUCT_PACKAGES += libGLES_android

# Audio
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.qc.sdk.audio.fluencetype=fluence

PRODUCT_PACKAGES += \
    audiod \
    audio.r_submix.default \
    libqcompostprocbundle \
    libqcomvisualizer \
    libqcomvoiceprocessing

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/mixer_paths_tasha.xml:system/etc/mixer_paths_tasha.xml \
    $(LOCAL_PATH)/audio/audio_platform_info.xml:system/etc/audio_platform_info.xml

# WLAN driver configuration files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/wifi/WCNSS_cfg.dat:system/etc/firmware/wlan/qca_cld/WCNSS_cfg.dat \
    $(LOCAL_PATH)/wifi/WCNSS_qcom_cfg.ini:system/etc/firmware/wlan/qca_cld/WCNSS_qcom_cfg.ini \
    $(LOCAL_PATH)/wifi/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf \
    $(LOCAL_PATH)/wifi/p2p_supplicant_overlay.conf:system/etc/wifi/p2p_supplicant_overlay.conf \
    $(LOCAL_PATH)/wifi/hostapd.conf:system/etc/hostapd/hostapd_default.conf \
    $(LOCAL_PATH)/wifi/hostapd.accept:system/etc/hostapd/hostapd.accept \
    $(LOCAL_PATH)/wifi/hostapd.deny:system/etc/hostapd/hostapd.deny

PRODUCT_PACKAGES += \
    hostapd \
    libwpa_client \
    wpa_supplicant \
    wpa_supplicant.conf

# MIDI feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.midi.xml:system/etc/permissions/android.software.midi.xml

#ANT+ stack
PRODUCT_PACKAGES += \
    AntHalService \
    libantradio \
    antradio_app \
    libvolumelistener

# Vr
PRODUCT_PACKAGES += vr.msm8996

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.vr.high_performance.xml:system/etc/permissions/android.hardware.vr.high_performance.xml

# Sensors
PRODUCT_PACKAGES += sensors.msm8996

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:system/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:system/etc/permissions/android.hardware.sensor.stepdetector.xml

#FEATURE_OPENGLES_EXTENSION_PACK support string config file
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:system/etc/permissions/android.hardware.opengles.aep.xml

# MSM IRQ Balancer configuration file
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/msm_irqbalance.conf:system/vendor/etc/msm_irqbalance.conf

# Thermal
PRODUCT_PACKAGES += thermal.msm8996

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/nfc/libnfc-brcm.conf:system/etc/libnfc-brcm.conf \
    $(LOCAL_PATH)/nfc/libnfc-nxp.conf:system/etc/libnfc-nxp.conf \
    $(LOCAL_PATH)/nfc/nfcee_access.xml:system/etc/nfcee_access.xml

# Media
PRODUCT_PACKAGES += \
    libdivxdrmdecrypt \
    libOmxVidcCommon \
    libstagefright_soft_flacenc

# QC AV Enhancements
PRODUCT_PACKAGES += \
    libdashplayer \
    libqcmediaplayer \
    qcmediaplayer \
    libextmedia_jni

# SmartcardService, SIM1,SIM2,eSE1 not including eSE2,SD1 as default
ADDITIONAL_BUILD_PROPERTIES += persist.nfc.smartcard.config=SIM1,SIM2,eSE1

# QPerformance
PRODUCT_BOOT_JARS += QPerformance

# Camera
PRODUCT_PACKAGES += \
    libop3_cam \
    libopencv_calib3d \
    libopencv_flann \
    libopencv_imgproc \
    libopencv_photo \
    libopencv_stitching \
    libopencv_video \
    libopencv_core \
    libopencv_highgui \
    libopencv_ml \
    libopencv_rsobjdetect \
    libopencv_superres \
    libopencv_videostab \
    libopencv_features2d \
    libopencv_imgcodecs \
    libopencv_objdetect \
    libopencv_shape \
    libopencv_videoio

PRODUCT_PROPERTY_OVERRIDES += \
    camera.disable_zsl_mode=1

PRODUCT_AAPT_CONFIG += xlarge large
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

#Android fingerprint daemon implementation
PRODUCT_PACKAGES += fingerprintd

PRODUCT_PACKAGES += power.msm8996

PRODUCT_PACKAGES += lights.qcom

PRODUCT_CHARACTERISTICS := nosdcard

# GPS
PRODUCT_BOOT_JARS += com.android.location.provider

PRODUCT_PACKAGES += gps.msm8996

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/gps/etc/flp.conf:system/etc/flp.conf \
    $(LOCAL_PATH)/gps/etc/gps.conf:system/etc/gps.conf \
    $(LOCAL_PATH)/gps/etc/izat.conf:system/etc/izat.conf \
    $(LOCAL_PATH)/gps/etc/lowi.conf:system/etc/lowi.conf \
    $(LOCAL_PATH)/gps/etc/sap.conf:system/etc/sap.conf \
    $(LOCAL_PATH)/gps/etc/xtwifi.conf:system/etc/xtwifi.conf

# Tools
PRODUCT_PACKAGES += \
    libtinyxml2 \
    libjson

# Doze mode
PRODUCT_PACKAGES += OneplusDoze

# FOSS
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/display/FOSSConfig.xml:system/etc/FOSSConfig.xml

# Keylayouts
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/keylayout/fpc1020.kl:system/usr/keylayout/fpc1020.kl \
    $(LOCAL_PATH)/keylayout/synaptics.kl:system/usr/keylayout/synaptics.kl
