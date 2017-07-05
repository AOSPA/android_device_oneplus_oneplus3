#!/system/bin/sh
# Copyright (c) 2012-2013, 2016, The Linux Foundation. All rights reserved.
# Copyright (c) 2017, The Paranoid Android Project.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

# Setup the platform variables reading from sysfs.
if [ -f /sys/devices/soc0/hw_platform ]; then
    soc_hwplatform=`cat /sys/devices/soc0/hw_platform` 2> /dev/null
else
    soc_hwplatform=`cat /sys/devices/system/soc/soc0/hw_platform` 2> /dev/null
fi
if [ -f /sys/devices/soc0/soc_id ]; then
    soc_hwid=`cat /sys/devices/soc0/soc_id` 2> /dev/null
else
    soc_hwid=`cat /sys/devices/system/soc/soc0/id` 2> /dev/null
fi
if [ -f /sys/devices/soc0/platform_version ]; then
    soc_hwver=`cat /sys/devices/soc0/platform_version` 2> /dev/null
else
    soc_hwver=`cat /sys/devices/system/soc/soc0/platform_version` 2> /dev/null
fi
if [ -f /sys/class/graphics/fb0/virtual_size ]; then
    res=`cat /sys/class/graphics/fb0/virtual_size` 2> /dev/null
    fb_width=${res%,*}
fi

# Message the kmsg device to indicate this script has run.
echo "[Qcom] Running early-boot script..." | tee /dev/kmsg

# Print some information regarding the hardware nodes.
echo "[Qcom] SoC: $soc_hwplatform" | tee /dev/kmsg
echo "[Qcom] HwID: $soc_hwid" | tee /dev/kmsg
echo "[Qcom] SoC ver: $soc_hwver" | tee /dev/kmsg
echo "[Qcom] Width: $fb_width" | tee /dev/kmsg

# Common function to setup sysfs permissions.
function set_perms() {
    chown -h $2 $1
    chmod $3 $1
}

# Setup display framebuffer nodes and permissions.
setprop debug.gralloc.gfx_ubwc_disable 1
file=/sys/class/graphics/fb0/mdp/caps
if [ -f "$file" ]
then
    cat $file | while read line; do
        case "$line" in
            *"ubwc"*)
                setprop debug.gralloc.enable_fb_ubwc 1
                setprop debug.gralloc.gfx_ubwc_disable 0
        esac
    done
fi

file=/sys/class/graphics/fb0
if [ -d "$file" ]
then
    set_perms $file/idle_time system.graphics 0664
    set_perms $file/dynamic_fps system.graphics 0664
    set_perms $file/dyn_pu system.graphics 0664
    set_perms $file/modes system.graphics 0664
    set_perms $file/mode system.graphics 0664
    set_perms $file/msm_cmd_autorefresh_en system.graphics 0664
fi

for fb_cnt in 0 1 2 3
do
    file=/sys/class/graphics/fb$fb_cnt/lineptr_value
    if [ -f "$file" ]; then
        set_perms $file system.graphics 0664
    fi
done

# Setup the available GPU frequencies to system property.
if [ -f /sys/class/kgsl/kgsl-3d0/gpu_available_frequencies ]; then
    gpu_freq=`cat /sys/class/kgsl/kgsl-3d0/gpu_available_frequencies` 2> /dev/null
    setprop ro.gpu.available_frequencies "$gpu_freq"
fi
