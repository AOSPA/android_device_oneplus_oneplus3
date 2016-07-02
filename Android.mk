#Create symbolic links
$(shell mkdir -p $(TARGET_OUT_ETC)/firmware/wlan/qca_cld; \
        ln -sf /system/etc/wifi/WCNSS_qcom_cfg.ini \
        $(TARGET_OUT_ETC)/firmware/wlan/qca_cld/WCNSS_qcom_cfg.ini; \
        ln -sf /dev/block/bootdevice/by-name/msadp \
        $(TARGET_OUT_ETC)/firmware/msadp )

include $(all-subdir-makefiles)
