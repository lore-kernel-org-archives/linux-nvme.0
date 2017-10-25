From: ckulkarnilinux@gmail.com (Chaitanya Kulkarni)
Date: Tue, 24 Oct 2017 18:30:56 -0700
Subject: [PATCH V2 39/46] nvmftests-tests: add a test to scan host ctrls and ns
In-Reply-To: <1508895063-6280-1-git-send-email-ckulkarnilinux@gmail.com>
References: <1508895063-6280-1-git-send-email-ckulkarnilinux@gmail.com>
Message-ID: <1508895063-6280-40-git-send-email-ckulkarnilinux@gmail.com>

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

This adds a new test to scan all the host ctrls and ns.
This can be used as a template in future tests where scanning
of the host subsystem is needed. e.g. adding a new ns after
connecting to the target and verifying that newly added ns
on target is appearing on the host in a timely manner.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 .../nvmftests/tests/test_nvmf_scan_host.py         | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 tools/testing/selftests/nvmftests/tests/test_nvmf_scan_host.py

diff --git a/tools/testing/selftests/nvmftests/tests/test_nvmf_scan_host.py b/tools/testing/selftests/nvmftests/tests/test_nvmf_scan_host.py
new file mode 100644
index 0000000..6ffd309
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/tests/test_nvmf_scan_host.py
@@ -0,0 +1,76 @@
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
+"""
+NVMF scan host :-
+
+    1. From the config file create Target.
+    2. From the config file create host and connect to target.
+    3. Scan host subsystem.
+    4. Delete Host.
+    5. Delete Target.
+"""
+
+
+import sys
+from nose.tools import assert_equal
+sys.path.append("../")
+from utils.misc.loopback import Loopback
+from nvmf_test import NVMFTest
+
+
+class TestNVMFScanHost(NVMFTest):
+
+    """ Represents host controller scan testcase """
+
+    def __init__(self):
+        NVMFTest.__init__(self)
+        self.setup_log_dir(self.__class__.__name__)
+
+    def setUp(self):
+        """ Pre section of testcase """
+        self.loopdev = Loopback(self.mount_path, self.data_size,
+                                self.block_size, self.nr_dev)
+        self.loopdev.init()
+        self.build_target_config(self.loopdev.dev_list)
+        super(TestNVMFScanHost, self).common_setup()
+
+    def tearDown(self):
+        """ Post section of testcase """
+        super(TestNVMFScanHost, self).common_tear_down()
+        self.loopdev.delete()
+
+    def test_scan_host(self):
+        """ Testcase main """
+        print("Now Running " + self.__class__.__name__)
+        success = True
+        for host_subsys in iter(self.host_subsys):
+            try:
+                print("Host Controller " + host_subsys.ctrl_dev)
+                for host_ns in iter(host_subsys):
+                    try:
+                        print(" Host NS " + host_ns.ns_dev)
+                    except StopIteration:
+                        success = False
+                        break
+            except StopIteration:
+                success = False
+                break
+
+        assert_equal(success, True, "ERROR : failed to scan host")
-- 
1.8.3.1
