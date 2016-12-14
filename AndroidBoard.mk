# Copyright (C) 2016 Paranoid Android
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

# Set the firmware path in the environment
target_firmware_path := $(ANDROID_BUILD_TOP)/vendor/oneplus/oneplus3/firmware_images/

# Oneplus 3
# static_nvbk file
$(call add-firmware-file,$(target_firmware_path)/static_nvbk.bin-op3)
# Radio fusion file
$(call add-firmware-file,$(target_firmware_path)/NON-HLOS.bin-op3)
# Bluetooth file
$(call add-firmware-file,$(target_firmware_path)/BTFM.bin-op3)
# rpm image
$(call add-firmware-file,$(target_firmware_path)/rpm.mbn-op3)
# pmic file
$(call add-firmware-file,$(target_firmware_path)/pmic.elf-op3)
# tz version image
$(call add-firmware-file,$(target_firmware_path)/tz.mbn-op3)
# hyp image
$(call add-firmware-file,$(target_firmware_path)/hyp.mbn-op3)
# adspso file
$(call add-firmware-file,$(target_firmware_path)/adspso.bin-op3)
# cmnlib image
$(call add-firmware-file,$(target_firmware_path)/cmnlib.mbn-op3)
# cmnlib64 image
$(call add-firmware-file,$(target_firmware_path)/cmnlib64.mbn-op3)
# devcfg image
$(call add-firmware-file,$(target_firmware_path)/devcfg.mbn-op3)
# keymaster image
$(call add-firmware-file,$(target_firmware_path)/keymaster.mbn-op3)
# xbl file
$(call add-firmware-file,$(target_firmware_path)/xbl.elf-op3)
# bootloader image
$(call add-firmware-file,$(target_firmware_path)/emmc_appsboot.mbn-op3)
# lksecapp image
$(call add-firmware-file,$(target_firmware_path)/lksecapp.mbn-op3)

# Oneplus 3T
# static_nvbk file
$(call add-firmware-file,$(target_firmware_path)/static_nvbk.bin-op3t)
# Radio fusion file
$(call add-firmware-file,$(target_firmware_path)/NON-HLOS.bin-op3t)
# Bluetooth file
$(call add-firmware-file,$(target_firmware_path)/BTFM.bin-op3t)
# rpm image
$(call add-firmware-file,$(target_firmware_path)/rpm.mbn-op3t)
# pmic file
$(call add-firmware-file,$(target_firmware_path)/pmic.elf-op3t)
# tz version image
$(call add-firmware-file,$(target_firmware_path)/tz.mbn-op3t)
# hyp image
$(call add-firmware-file,$(target_firmware_path)/hyp.mbn-op3t)
# adspso file
$(call add-firmware-file,$(target_firmware_path)/adspso.bin-op3t)
# cmnlib image
$(call add-firmware-file,$(target_firmware_path)/cmnlib.mbn-op3t)
# cmnlib64 image
$(call add-firmware-file,$(target_firmware_path)/cmnlib64.mbn-op3t)
# devcfg image
$(call add-firmware-file,$(target_firmware_path)/devcfg.mbn-op3t)
# keymaster image
$(call add-firmware-file,$(target_firmware_path)/keymaster.mbn-op3t)
# xbl file
$(call add-firmware-file,$(target_firmware_path)/xbl.elf-op3t)
# bootloader image
$(call add-firmware-file,$(target_firmware_path)/emmc_appsboot.mbn-op3t)

# Unset local variable
target_firmware_path :=
