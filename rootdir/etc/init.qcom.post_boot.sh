#!/system/bin/sh
# Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
# Copyright (c) 2016, Paranoid Android
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

        # disable thermal bcl hotplug to switch governor
        echo 0 > /sys/module/msm_thermal/core_control/enabled
        echo -n disable > /sys/devices/soc/soc:qcom,bcl/mode
        bcl_hotplug_mask=`cat /sys/devices/soc/soc:qcom,bcl/hotplug_mask`
        echo 0 > /sys/devices/soc/soc:qcom,bcl/hotplug_mask
        bcl_soc_hotplug_mask=`cat /sys/devices/soc/soc:qcom,bcl/hotplug_soc_mask`
        echo 0 > /sys/devices/soc/soc:qcom,bcl/hotplug_soc_mask
        echo -n enable > /sys/devices/soc/soc:qcom,bcl/mode

        echo "18432,23040,27648,51256,110296,200640" > /sys/module/lowmemorykiller/parameters/minfree
        # configure governor settings for little cluster
        echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
        echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
        echo 19000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
        echo 90 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
        echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
        echo 960000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
        echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
        echo 80 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
        echo 19000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
        echo 79000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis
        echo 300000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
        echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/ignore_hispeed_on_notif
        echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/enable_prediction
        # online CPU2
        echo 1 > /sys/devices/system/cpu/cpu2/online
        # configure governor settings for big cluster
        echo "interactive" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
        echo 1 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/use_sched_load
        echo 1 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/use_migration_notif
        echo "19000 1400000:39000 1700000:19000 2100000:79000" > /sys/devices/system/cpu/cpu2/cpufreq/interactive/above_hispeed_delay
        echo 90 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/go_hispeed_load
        echo 20000 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/timer_rate
        echo 1248000 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/hispeed_freq
        echo 1 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/io_is_busy
        echo "85 1500000:90 1800000:70 2100000:95" > /sys/devices/system/cpu/cpu2/cpufreq/interactive/target_loads
        echo 19000 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/min_sample_time
        echo 79000 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/max_freq_hysteresis
        echo 300000 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
        echo 1 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/ignore_hispeed_on_notif
        echo 1 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/enable_prediction
        # re-enable thermal and BCL hotplug
        echo 1 > /sys/module/msm_thermal/core_control/enabled
        echo -n disable > /sys/devices/soc/soc:qcom,bcl/mode
        echo $bcl_hotplug_mask > /sys/devices/soc/soc:qcom,bcl/hotplug_mask
        echo $bcl_soc_hotplug_mask > /sys/devices/soc/soc:qcom,bcl/hotplug_soc_mask
        echo -n enable > /sys/devices/soc/soc:qcom,bcl/mode
        # input boost configuration
        echo "0:1324800 2:1324800" > /sys/module/cpu_boost/parameters/input_boost_freq
        echo 40 > /sys/module/cpu_boost/parameters/input_boost_ms
        # Setting b.L scheduler parameters
        echo 0 > /proc/sys/kernel/sched_boost
        echo 1 > /proc/sys/kernel/sched_migration_fixup
        echo 45 > /proc/sys/kernel/sched_downmigrate
        echo 45 > /proc/sys/kernel/sched_upmigrate
        echo 400000 > /proc/sys/kernel/sched_freq_inc_notify
        echo 400000 > /proc/sys/kernel/sched_freq_dec_notify
        echo 3 > /proc/sys/kernel/sched_spill_nr_run
        echo 65 > /proc/sys/kernel/sched_init_task_load
        echo 12 > /proc/sys/kernel/sched_upmigrate_min_nice
        # Enable bus-dcvs
        for cpubw in /sys/class/devfreq/*qcom,cpubw*
        do
            echo "bw_hwmon" > $cpubw/governor
            echo 50 > $cpubw/polling_interval
            echo 1525 > $cpubw/min_freq
            echo "1525 5195 11863 13763" > $cpubw/bw_hwmon/mbps_zones
            echo 4 > $cpubw/bw_hwmon/sample_ms
            echo 34 > $cpubw/bw_hwmon/io_percent
            echo 20 > $cpubw/bw_hwmon/hist_memory
            echo 10 > $cpubw/bw_hwmon/hyst_length
            echo 0 > $cpubw/bw_hwmon/low_power_ceil_mbps
            echo 34 > $cpubw/bw_hwmon/low_power_io_percent
            echo 20 > $cpubw/bw_hwmon/low_power_delay
            echo 0 > $cpubw/bw_hwmon/guard_band_mbps
            echo 250 > $cpubw/bw_hwmon/up_scale
            echo 1600 > $cpubw/bw_hwmon/idle_mbps
        done

        for memlat in /sys/class/devfreq/*qcom,memlat-cpu*
        do
            echo "mem_latency" > $memlat/governor
            echo 10 > $memlat/polling_interval
        done
        echo "cpufreq" > /sys/class/devfreq/soc:qcom,mincpubw/governor

	soc_revision=`cat /sys/devices/soc0/revision`
	if [ "$soc_revision" == "2.0" ]; then
		#Disable suspend for v1.0 and v2.0
		echo pwr_dbg > /sys/power/wake_lock
	elif [ "$soc_revision" == "2.1" ]; then
		# Enable C4.D4.E4.M3 LPM modes
		# Disable D3 state
		echo 0 > /sys/module/lpm_levels/system/pwr/pwr-l2-gdhs/idle_enabled
		echo 0 > /sys/module/lpm_levels/system/perf/perf-l2-gdhs/idle_enabled
		# Disable DEF-FPC mode
		echo N > /sys/module/lpm_levels/system/pwr/cpu0/fpc-def/idle_enabled
		echo N > /sys/module/lpm_levels/system/pwr/cpu1/fpc-def/idle_enabled
		echo N > /sys/module/lpm_levels/system/perf/cpu2/fpc-def/idle_enabled
		echo N > /sys/module/lpm_levels/system/perf/cpu3/fpc-def/idle_enabled
	else
		# Enable all LPMs by default
		# This will enable C4, D4, D3, E4 and M3 LPMs
		echo N > /sys/module/lpm_levels/parameters/sleep_disabled
	fi
	echo N > /sys/module/lpm_levels/parameters/sleep_disabled

        echo 6 > /sys/class/kgsl/kgsl-3d0/default_pwrlevel

        # Reset the read_ahead_kb to 512
        echo 512 > /sys/block/dm-0/queue/read_ahead_kb
        echo 512 > /sys/block/sda/queue/read_ahead_kb
        echo 512 > /sys/block/sde/queue/read_ahead_kb

        sleep 20

        # switch to CFQ
        echo "cfq" > /sys/block/sda/queue/scheduler
        echo "cfq" > /sys/block/sde/queue/scheduler
        echo "cfq" > /sys/block/dm-0/queue/scheduler

        # Starting io prefetcher service
        start iop

        rm /data/system/perfd/default_values
        setprop ro.min_freq_0 307200
        setprop ro.min_freq_4 307200
        start perfd