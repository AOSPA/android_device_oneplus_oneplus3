#
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

import common
import re
import sha

def FullOTA_Assertions(info):
  print "FullOTA_Assertions not implemented"

def IncrementalOTA_Assertions(info):
  print "IncrementalOTA_Assertions not implemented"

def InstallImage(img_name, img_file, partition, info):
  common.ZipWriteStr(info.output_zip, "firmware/" + img_name, img_file)
  info.script.AppendExtra(('package_extract_file("' + "firmware/" + img_name + '", "/dev/block/bootdevice/by-name/' + partition + '");'))

image_partitions_common = {
   'emmc_appsboot.mbn' : 'aboot',
   'NON-HLOS.bin'      : 'modem',
   'static_nvbk.bin'   : 'oem_stanvbk',
   'rpm.mbn'           : 'rpm',
   'pmic.elf'          : 'pmic',
   'tz.mbn'            : 'tz',
   'hyp.mbn'           : 'hyp',
   'BTFM.bin'          : 'bluetooth',
   'cmnlib.mbn'        : 'cmnlib',
   'cmnlib64.mbn'      : 'cmnlib64',
   'devcfg.mbn'        : 'devcfg',
   'keymaster.mbn'     : 'keymaster',
   'xbl.elf'           : 'xbl',
   'adspso.bin'        : 'dsp'
}

image_partitions_op3 = {
   'lksecapp.mbn'      : 'lksecapp'
}

image_partitions_op3t = {
}

def FullOTA_InstallEnd(info):
  info.script.Print("Writing recommended firmware...")

  image_partitions_op3.update(image_partitions_common);
  image_partitions_op3t.update(image_partitions_common);

  info.script.AppendExtra('if getprop("ro.product.device") == "oneplus3" then')
  for k, v in image_partitions_op3.iteritems():
    try:
      img_file = info.input_zip.read("firmware/" + k + "-op3")
      InstallImage(k + "-op3", img_file, v, info)
    except KeyError:
      print "warning: no " + k + " image in input target_files; not flashing " + k

  info.script.AppendExtra('endif;')

  info.script.AppendExtra('if getprop("ro.product.device") == "oneplus3t" then')
  for k, v in image_partitions_op3t.iteritems():
    try:
      img_file = info.input_zip.read("firmware/" + k + "-op3t")
      InstallImage(k + "-op3t", img_file, v, info)
    except KeyError:
      print "warning: no " + k + " image in input target_files; not flashing " + k

  info.script.AppendExtra('endif;')

def IncrementalOTA_InstallEnd(info):
    info.script.Print("Firmware flashing extension is not supported on incremental builds.")
