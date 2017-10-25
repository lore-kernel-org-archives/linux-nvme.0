From: ckulkarnilinux@gmail.com (Chaitanya Kulkarni)
Date: Tue, 24 Oct 2017 18:30:57 -0700
Subject: [PATCH V2 40/46] nvmftests-tests: add a test to scan target subsys/ns
In-Reply-To: <1508895063-6280-1-git-send-email-ckulkarnilinux@gmail.com>
References: <1508895063-6280-1-git-send-email-ckulkarnilinux@gmail.com>
Message-ID: <1508895063-6280-41-git-send-email-ckulkarnilinux@gmail.com>

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

This adds a new test to scan all the target subsys and ns.
This can be used as a template where scanning of target subsystems
is needed while the test is in progress.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 .../nvmftests/tests/test_nvmf_scan_target.py       | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 tools/testing/selftests/nvmftests/tests/test_nvmf_scan_target.py

diff --git a/tools/testing/selftests/nvmftests/tests/test_nvmf_scan_target.py b/tools/testing/selftests/nvmftests/tests/test_nvmf_scan_target.py
new file mode 100644
index 0000000..b65e737
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/tests/test_nvmf_scan_target.py
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
+NVMF scan Target :-
+
+    1. From the config file create Target.
+    2. From the config file create host and connect to target.
+    3. Scan target subsystem.
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
+class TestNVMFScanTarget(NVMFTest):
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
+        super(TestNVMFScanTarget, self).common_setup()
+
+    def tearDown(self):
+        """ Post section of testcase """
+        super(TestNVMFScanTarget, self).common_tear_down()
+        self.loopdev.delete()
+
+    def test_scan_target(self):
+        """ Testcase main """
+        print("Now Running " + self.__class__.__name__)
+        success = True
+        for target_subsys in iter(self.target_subsys):
+            try:
+                print("Target Controller " + target_subsys.nqn)
+                for target_ns in iter(target_subsys):
+                    try:
+                        print(" Target NS " + target_ns.ns_path)
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
