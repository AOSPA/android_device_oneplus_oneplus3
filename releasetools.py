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

image_partitions = {
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
   'adspso.bin'        : 'dsp',
   'lksecapp.mbn'      : 'lksecapp'
}

def FullOTA_InstallEnd(info):
  info.script.Print("Writing recommended firmware...")
  for k, v in image_partitions.iteritems():
    try:
      img_file = info.input_zip.read("firmware/" + k)
      InstallImage(k, img_file, v, info)
    except KeyError:
      print "warning: no " + k + " image in input target_files; not flashing " + k


def IncrementalOTA_InstallEnd(info):
  for k, v in image_partitions.iteritems():
    try:
      source_file = info.source_zip.read("firmware/" + k)
      target_file = info.target_zip.read("firmware/" + k)
      if source_file != target_file:
        InstallImage(k, target_file, v, info)
      else:
        print k + " image unchanged; skipping"
    except KeyError:
      print "warning: " + k + " image missing from target; aborting: " + k
