$(call inherit-product, device/oneplus/oneplus3/base.mk)

PRODUCT_BRAND := oneplus
PRODUCT_AAPT_CONFIG += hdpi mdpi

ifndef PRODUCT_MANUFACTURER
PRODUCT_MANUFACTURER := QUALCOMM
endif

PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.extension_library=libqti-perfd-client.so \
    persist.radio.apm_sim_not_pwdn=1 \
    persist.radio.sib16_support=1 \
    persist.radio.custom_ecc=1
