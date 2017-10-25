From: ckulkarnilinux@gmail.com (Chaitanya Kulkarni)
Date: Tue, 24 Oct 2017 18:30:24 -0700
Subject: [PATCH V2 07/46] nvmftests-utils: add misc package
In-Reply-To: <1508895063-6280-1-git-send-email-ckulkarnilinux@gmail.com>
References: <1508895063-6280-1-git-send-email-ckulkarnilinux@gmail.com>
Message-ID: <1508895063-6280-8-git-send-email-ckulkarnilinux@gmail.com>

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

This adds support for misc package. In current implementation
it has different device types which are used on the
NVMe Over Fabrics target namespace. These classes will be
used at the time of target initialization.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 .../selftests/nvmftests/utils/misc/__init__.py     |  23 +++++
 .../nvmftests/utils/misc/generic_blk_dev.py        |  58 +++++++++++
 .../selftests/nvmftests/utils/misc/loopback.py     | 103 +++++++++++++++++++
 .../selftests/nvmftests/utils/misc/nvme_pci.py     | 114 +++++++++++++++++++++
 4 files changed, 298 insertions(+)
 create mode 100644 tools/testing/selftests/nvmftests/utils/misc/__init__.py
 create mode 100644 tools/testing/selftests/nvmftests/utils/misc/generic_blk_dev.py
 create mode 100644 tools/testing/selftests/nvmftests/utils/misc/loopback.py
 create mode 100644 tools/testing/selftests/nvmftests/utils/misc/nvme_pci.py

diff --git a/tools/testing/selftests/nvmftests/utils/misc/__init__.py b/tools/testing/selftests/nvmftests/utils/misc/__init__.py
new file mode 100644
index 0000000..07806e7
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/utils/misc/__init__.py
@@ -0,0 +1,23 @@
+# Copyright (c) 2016-2017 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
+#
+
+from .loopback import Loopback
+from .generic_blk_dev import GenBlk
+from .nvme_pci import NVMePCIeBlk
diff --git a/tools/testing/selftests/nvmftests/utils/misc/generic_blk_dev.py b/tools/testing/selftests/nvmftests/utils/misc/generic_blk_dev.py
new file mode 100644
index 0000000..b818cea
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/utils/misc/generic_blk_dev.py
@@ -0,0 +1,58 @@
+# Copyright (c) 2016-2017 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
+#
+""" Represents generic block device.
+"""
+
+import os
+import stat
+import logging
+
+from utils.log import Log
+
+
+class GenBlk(object):
+    """
+    Represents Generic BLK block devices.
+
+        - Attributes:
+            - nr_devices : max block devices.
+            - dev_list : list of block devices.
+    """
+    def __init__(self, nr_devices):
+        self.nr_devices = str(nr_devices)
+        self.dev_list = []
+        self.logger = Log.get_logger(__name__, 'gen_blk')
+        self.logger.setLevel(logging.DEBUG)
+
+    def init(self, dev_list):
+        """ Create and initialize Generic Block Device.
+            - Args :
+                - dev_list : list of block devices.
+            - Returns :
+                - True on success, False on failure.
+        """
+        for i in range(0, int(self.nr_devices)):
+            self.logger.info(dev_list[i])
+            if stat.S_ISBLK(os.stat(dev_list[i]).st_mode) is False:
+                self.logger.error("block device not found " + dev_list[i])
+                return False
+            self.dev_list.append(dev_list[i])
+        self.logger.info(self.dev_list)
+        return True
diff --git a/tools/testing/selftests/nvmftests/utils/misc/loopback.py b/tools/testing/selftests/nvmftests/utils/misc/loopback.py
new file mode 100644
index 0000000..04817f5
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/utils/misc/loopback.py
@@ -0,0 +1,103 @@
+# Copyright (c) 2016-2017 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
+#
+""" Represents Loopback block devices.
+"""
+
+import os
+import logging
+
+from utils.shell import Cmd
+from utils.log import Log
+
+
+class Loopback(object):
+    """
+    Represents Loopback driver block devices.
+
+        - Attributes:
+            - path : path to create backend files.
+            - dev_size : device file size.
+            - block size : block size to create file.
+            - max_loop : max loop devices.
+            - dev_list : list of loop back files.
+    """
+    def __init__(self, path, dev_size, block_size, max_loop):
+        self.path = path
+        self.dev_size = dev_size
+        self.block_size = block_size
+        self.max_loop = max_loop
+        self.dev_list = []
+        self.logger = Log.get_logger(__name__, 'loopback')
+        self.logger.setLevel(logging.DEBUG)
+
+        Cmd.exec_cmd("losetup -D")
+        Cmd.exec_cmd("modprobe -qr loop")
+        Cmd.exec_cmd("modprobe loop max_loop=" + str(max_loop))
+
+    def init(self):
+        """ Create and initialize Loopback.
+            - Args :
+                - None.
+            - Returns :
+                - True on success, False on failure.
+        """
+        if self.dev_size == 0 or self.block_size == 0:
+            self.logger.err("invalid device size or block size")
+            return False
+
+        count = self.dev_size / self.block_size
+
+        for i in range(0, self.max_loop):
+            file_path = self.path + "/test" + str(i)
+            cmd = "dd if=/dev/zero of=" + file_path + \
+                " count=" + str(count) + " bs=" + str(self.block_size)
+            self.logger.info(cmd)
+            ret = Cmd.exec_cmd(cmd)
+            if ret is False:
+                self.logger.error("lookback file creation " + self.dev_list[i])
+                self.delete()
+                return False
+            dev = "/dev/loop" + str(i)
+            cmd = "losetup " + dev + " " + file_path
+            self.logger.info(cmd)
+            if Cmd.exec_cmd(cmd) is False:
+                self.logger.error(cmd + " failed.")
+                return False
+
+            self.dev_list.append(dev)
+        return True
+
+    def delete(self):
+        """ Delete this Loopback.
+            - Args :
+                - None.
+            -Returns :
+                - True on success, False on failure.
+        """
+        loop_cnt = 0
+        for i in self.dev_list:
+            cmd = "losetup -d /dev/loop" + str(loop_cnt)
+            self.logger.info(cmd)
+            Cmd.exec_cmd(cmd)
+            file_path = self.path + "/test" + str(loop_cnt)
+            os.remove(file_path)
+            loop_cnt += 1
+
+        return Cmd.exec_cmd("modprobe -qr loop")
diff --git a/tools/testing/selftests/nvmftests/utils/misc/nvme_pci.py b/tools/testing/selftests/nvmftests/utils/misc/nvme_pci.py
new file mode 100644
index 0000000..f8a4b78
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/utils/misc/nvme_pci.py
@@ -0,0 +1,114 @@
+# Copyright (c) 2016-2017 Western Digital Corporation or its affiliates.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+# MA  02110-1301, USA.
+#
+#   Author: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
+#
+""" Represents NVMe PCIe block device.
+"""
+import os
+import re
+import sys
+import time
+from natsort import natsorted
+
+sys.path.append('../../')
+from utils.shell import Cmd
+from utils.log import Log
+
+
+class NVMePCIeBlk(object):
+    """
+    Represents NVMe PCIe block devices.
+
+        - Attributes :
+            - nr_devices : number of block devices.
+            - ctrl_list : NVMe PCIe controller list.
+            - dev_list : list of devices.
+    """
+    def __init__(self):
+        self.nr_devices = None
+        self.ctrl_list = []
+        self.dev_list = []
+        self.logger = Log.get_logger(__name__, 'nvme_pci')
+
+        Cmd.exec_cmd("modprobe -r nvme")
+        Cmd.exec_cmd("modprobe nvme")
+        # allow devices to appear in /dev/
+        time.sleep(1)
+
+    def is_pci_ctrl(self, ctrl):
+        """ Validate underlaying device belongs to pci subsystem.
+            - Args :
+                - None.
+            - Returns :
+                - True if device is belongs to PCIe subsystem, False otherwise.
+        """
+        cmd = "find /sys/devices -name " + ctrl + " | grep -i pci"
+        return Cmd.exec_cmd(cmd)
+
+    def init(self):
+        """ Build the list of NVMe PCIe controllers.
+            - Args :
+                - None.
+            - Returns :
+                - True on success, False on failure.
+        """
+        time.sleep(1)
+        ctrl = "XXX "
+        try:
+            dev_list = os.listdir("/dev/")
+        except Exception, err:
+            self.logger.error(str(err) + ".")
+            return False
+        dev_list = natsorted(dev_list, key=lambda y: y.lower())
+        pat = re.compile("^nvme[0-9]+$")
+        for line in dev_list:
+            line = line.strip('\n')
+            if pat.match(line):
+                ctrl = line
+                ctrl_dev = "/dev/" + ctrl
+                if self.is_pci_ctrl(ctrl) is True:
+                    self.logger.info("found NVMe PCIe Controller " + ctrl_dev)
+                    self.ctrl_list.append(ctrl_dev)
+                else:
+                    self.logger.info(ctrl_dev + " is not pci ctrl.")
+
+        # find namespace(s) associated with ctrl
+        try:
+            dir_list = os.listdir("/dev/")
+        except Exception, err:
+            self.logger.error(str(err))
+            return False
+        pat = re.compile("^" + ctrl + "+n[0-9]+$")
+        for line in dir_list:
+            line = line.strip('\n')
+            if pat.match(line):
+                self.logger.info("Generated namespace name /dev/" + line + ".")
+                self.dev_list.append("/dev/" + line)
+
+        self.logger.info(self.ctrl_list)
+        self.logger.info(self.dev_list)
+        return True
+
+    def delete(self):
+        """ Remove the nvme module.
+            - Args :
+                - None.
+            -Returns :
+                - True on success, False on failure.
+        """
+        return Cmd.exec_cmd("modprobe -qr nvme")
-- 
1.8.3.1
