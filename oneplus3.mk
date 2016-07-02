DEVICE_PACKAGE_OVERLAYS := device/oneplus/oneplus3/overlay
BOARD_HAVE_QCOM_FM := true
TARGET_USES_NQ_NFC := false

#QTIC flag
-include $(QCPATH)/common/config/qtic-config.mk

# copy customized media_profiles and media_codecs xmls for oneplus3
PRODUCT_COPY_FILES += device/oneplus/oneplus3/media/media_profiles.xml:system/etc/media_profiles.xml \
                      device/oneplus/oneplus3/media/media_codecs.xml:system/etc/media_codecs.xml \
                      device/oneplus/oneplus3/media/media_codecs_performance.xml:system/etc/media_codecs_performance.xml

$(call inherit-product, device/oneplus/oneplus3/common64.mk)

PRODUCT_NAME := oneplus3
PRODUCT_DEVICE := oneplus3
PRODUCT_BRAND := Android
PRODUCT_MODEL := MSM8996 for arm64

PRODUCT_BOOT_JARS += tcmiface

ifneq ($(strip $(QCPATH)),)
PRODUCT_BOOT_JARS += WfdCommon
PRODUCT_BOOT_JARS += com.qti.dpmframework
PRODUCT_BOOT_JARS += dpmapi
PRODUCT_BOOT_JARS += com.qti.location.sdk
PRODUCT_BOOT_JARS += oem-services
endif

ifeq ($(strip $(BOARD_HAVE_QCOM_FM)),true)
PRODUCT_BOOT_JARS += qcom.fmradio
endif #BOARD_HAVE_QCOM_FM
PRODUCT_BOOT_JARS += qcmediaplayer

#Android EGL implementation
PRODUCT_PACKAGES += libGLES_android

# Audio configuration file
PRODUCT_COPY_FILES += \
    device/oneplus/oneplus3/audio_policy.conf:system/etc/audio_policy.conf

PRODUCT_COPY_FILES += \
    device/oneplus/oneplus3/audio/audio_output_policy.conf:system/vendor/etc/audio_output_policy.conf \
    device/oneplus/oneplus3/audio/audio_effects.conf:system/vendor/etc/audio_effects.conf \
    device/oneplus/oneplus3/audio/mixer_paths.xml:system/etc/mixer_paths.xml \
    device/oneplus/oneplus3/audio/mixer_paths_tasha.xml:system/etc/mixer_paths_tasha.xml \
    device/oneplus/oneplus3/audio/aanc_tuning_mixer.txt:system/etc/aanc_tuning_mixer.txt \
    device/oneplus/oneplus3/audio/sound_trigger_mixer_paths.xml:system/etc/sound_trigger_mixer_paths.xml \
    device/oneplus/oneplus3/audio/sound_trigger_mixer_paths_wcd9330.xml:system/etc/sound_trigger_mixer_paths_wcd9330.xml \
    device/oneplus/oneplus3/audio/sound_trigger_platform_info.xml:system/etc/sound_trigger_platform_info.xml \
    device/oneplus/oneplus3/audio/audio_platform_info.xml:system/etc/audio_platform_info.xml \
    device/oneplus/oneplus3/listen_platform_info.xml:system/etc/listen_platform_info.xml

# WLAN driver configuration files
PRODUCT_COPY_FILES += \
    device/oneplus/oneplus3/wifi/WCNSS_cfg.dat:system/etc/firmware/wlan/qca_cld/WCNSS_cfg.dat \
    device/oneplus/oneplus3/wifi/WCNSS_qcom_cfg.ini:system/etc/wifi/WCNSS_qcom_cfg.ini \
    device/oneplus/oneplus3/wifi/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf \
    device/oneplus/oneplus3/wifi/p2p_supplicant_overlay.conf:system/etc/wifi/p2p_supplicant_overlay.conf \
    device/oneplus/oneplus3/wifi/hostapd_default.conf:system/etc/hostapd/hostapd_default.conf \
    device/oneplus/oneplus3/wifi/hostapd.accept:system/etc/hostapd/hostapd.accept \
    device/oneplus/oneplus3/wifi/hostapd.deny:system/etc/hostapd/hostapd.deny

# MIDI feature
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.midi.xml:system/etc/permissions/android.software.midi.xml

#ANT+ stack
PRODUCT_PACKAGES += \
    AntHalService \
    libantradio \
    antradio_app \
    libvolumelistener

# Sensor HAL conf file
PRODUCT_COPY_FILES += \
    device/oneplus/oneplus3/sensors/hals.conf:system/etc/sensors/hals.conf

# Sensor features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:system/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:system/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.sensor.ambient_temperature.xml:system/etc/permissions/android.hardware.sensor.ambient_temperature.xml \
    frameworks/native/data/etc/android.hardware.sensor.relative_humidity.xml:system/etc/permissions/android.hardware.sensor.relative_humidity.xml \
    frameworks/native/data/etc/android.hardware.sensor.hifi_sensors.xml:system/etc/permissions/android.hardware.sensor.hifi_sensors.xml

PRODUCT_SUPPORTS_VERITY := true
PRODUCT_SYSTEM_VERITY_PARTITION := /dev/block/bootdevice/by-name/system

#FEATURE_OPENGLES_EXTENSION_PACK support string config file
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.opengles.aep.xml:system/etc/permissions/android.hardware.opengles.aep.xml

# MSM IRQ Balancer configuration file
PRODUCT_COPY_FILES += \
    device/oneplus/oneplus3/msm_irqbalance.conf:system/vendor/etc/msm_irqbalance.conf

# NFC
PRODUCT_PACKAGES += \
    com.android.nfc_extras \
    com.nxp.nfc.nq \
    NQNfcNci \
    nfc_nci.nqx.default \
    Tag

PRODUCT_COPY_FILES += \
    device/oneplus/oneplus3/nfc/libnfc-brcm.conf:system/etc/libnfc-brcm.conf \
    device/oneplus/oneplus3/nfc/libnfc-nxp.conf:system/etc/libnfc-nxp.conf \
    device/oneplus/oneplus3/nfc/nfcee_access.xml:system/etc/nfcee_access.xml

PRODUCT_COPY_FILES += \
    packages/apps/Nfc/migrate_nfc.txt:system/etc/updatecmds/migrate_nfc.txt \
    frameworks/native/data/etc/com.nxp.mifare.xml:system/etc/permissions/com.nxp.mifare.xml \
    frameworks/native/data/etc/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
    frameworks/native/data/etc/android.hardware.nfc.hce.xml:system/etc/permissions/android.hardware.nfc.hce.xml

# SmartcardService, SIM1,SIM2,eSE1 not including eSE2,SD1 as default
ADDITIONAL_BUILD_PROPERTIES += persist.nfc.smartcard.config=SIM1,SIM2,eSE1
endif # TARGET_USES_NQ_NFC

# Reduce client buffer size for fast audio output tracks
PRODUCT_PROPERTY_OVERRIDES += \
    af.fast_track_multiplier=1

# Low latency audio buffer size in frames
PRODUCT_PROPERTY_OVERRIDES += \
    audio_hal.period_size=192

PRODUCT_PROPERTY_OVERRIDES += \
    camera.disable_zsl_mode=1

PRODUCT_AAPT_CONFIG += xlarge large

#Android fingerprint daemon implementation
PRODUCT_PACKAGES += \
    fingerprintd

#for android_filesystem_config.h
PRODUCT_PACKAGES += \
    fs_config_files

PRODUCT_PACKAGES += power.msm8996

PRODUCT_PACKAGES += lights.qcom

# GPS
PRODUCT_PACKAGES += \
    gps.msm8996 \
    flp.conf \
    gps.conf \
    izat.conf \
    lowi.conf \
    sap.conf \
    xtwifi.conf
