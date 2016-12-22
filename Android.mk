ifeq ($(TARGET_DEVICE),oneplus3)

#Create symbolic links
$(shell mkdir -p $(TARGET_OUT)/etc/firmware/wcd9320; \
    ln -sf /data/misc/audio/wcd9320_anc.bin \
	    $(TARGET_OUT)/etc/firmware/wcd9320/wcd9320_anc.bin; \
    ln -sf /data/misc/audio/wcd9320_mad_audio.bin \
	    $(TARGET_OUT_ETC)/firmware/wcd9320/wcd9320_mad_audio.bin;  \
    ln -sf /data/misc/audio/mbhc.bin \
	    $(TARGET_OUT_ETC)/firmware/wcd9320/wcd9320_mbhc.bin)

$(shell mkdir -p $(TARGET_OUT)/etc/firmware; \
    ln -sf /dev/block/bootdevice/by-name/msadp \
	    $(TARGET_OUT)/etc/firmware/msadp)

RFS_MSM_ADSP_SYMLINKS := $(TARGET_OUT)/rfs/msm/adsp/
$(RFS_MSM_ADSP_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating RFS MSM ADSP folder structure: $@"
	@rm -rf $@/*
	@mkdir -p $(dir $@)/readonly
	$(hide) ln -sf /data/tombstones/lpass $@/ramdumps
	$(hide) ln -sf /persist/rfs/msm/adsp $@/readwrite
	$(hide) ln -sf /persist/rfs/shared $@/shared
	$(hide) ln -sf /persist/hlos_rfs/shared $@/hlos
	$(hide) ln -sf /firmware $@/readonly/firmware

RFS_MSM_MPSS_SYMLINKS := $(TARGET_OUT)/rfs/msm/mpss/
$(RFS_MSM_MPSS_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating RFS MSM MPSS folder structure: $@"
	@rm -rf $@/*
	@mkdir -p $(dir $@)/readonly
	$(hide) ln -sf /data/tombstones/modem $@/ramdumps
	$(hide) ln -sf /persist/rfs/msm/mpss $@/readwrite
	$(hide) ln -sf /persist/rfs/shared $@/shared
	$(hide) ln -sf /persist/hlos_rfs/shared $@/hlos
	$(hide) ln -sf /firmware $@/readonly/firmware

ALL_DEFAULT_INSTALLED_MODULES += $(RFS_MSM_ADSP_SYMLINKS) $(RFS_MSM_MPSS_SYMLINKS)

# Read WiFi MAC Address from persist partition
$(shell mkdir -p $(TARGET_OUT_ETC)/firmware/wlan/qca_cld ; \
	ln -sf /persist/wlan_mac.bin $(TARGET_OUT_ETC)/firmware/wlan/qca_cld/wlan_mac.bin)

include $(call all-subdir-makefiles)

endif
