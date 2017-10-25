From: ckulkarnilinux@gmail.com (Chaitanya Kulkarni)
Date: Tue, 24 Oct 2017 18:30:43 -0700
Subject: [PATCH V2 26/46] nvmftests-tests: add a test for NVMe PCIe target ns
In-Reply-To: <1508895063-6280-1-git-send-email-ckulkarnilinux@gmail.com>
References: <1508895063-6280-1-git-send-email-ckulkarnilinux@gmail.com>
Message-ID: <1508895063-6280-27-git-send-email-ckulkarnilinux@gmail.com>

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

This adds a new test to create and delete host with NVMe
PCIe block device on the target side.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 .../nvmftests/tests/test_nvmf_create_pci_target.py | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 tools/testing/selftests/nvmftests/tests/test_nvmf_create_pci_target.py

diff --git a/tools/testing/selftests/nvmftests/tests/test_nvmf_create_pci_target.py b/tools/testing/selftests/nvmftests/tests/test_nvmf_create_pci_target.py
new file mode 100644
index 0000000..f1a8a5f
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/tests/test_nvmf_create_pci_target.py
@@ -0,0 +1,70 @@
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
+NVMF Create/Delete Host with PCIe device on target namespace :-
+
+    1. From the config file create Target.
+    2. From the config file create host and connect to target.
+    3. Delete Host.
+    4. Delete Target.
+"""
+
+
+import sys
+from nose.tools import assert_equal
+sys.path.append("../")
+from utils.misc.nvme_pci import NVMePCIeBlk
+from nvmf_test import NVMFTest
+from nvmf.target import NVMFTarget
+from nvmf.host import NVMFHost
+
+
+class TestNVMFCreatePCIeTarget(NVMFTest):
+
+    """ Represents Host Creation testcase """
+
+    def __init__(self):
+        NVMFTest.__init__(self)
+        self.host_subsys = None
+        self.target_subsys = None
+        self.setup_log_dir(self.__class__.__name__)
+
+    def setUp(self):
+        """ Pre section of testcase """
+        self.nvme_pci = NVMePCIeBlk()
+        self.nvme_pci.init()
+        self.build_target_config(self.nvme_pci.dev_list)
+        self.target_subsys = NVMFTarget(self.target_type)
+        ret = self.target_subsys.config(self.target_config_file)
+        assert_equal(ret, True, "ERROR : target config failed")
+        self.host_subsys = NVMFHost(self.target_type)
+
+    def tearDown(self):
+        """ Post section of testcase """
+        self.host_subsys.delete()
+        self.target_subsys.delete()
+        self.nvme_pci.delete()
+
+    def test_create_pci_target(self):
+        """ Testcase main """
+        print("Now Running " + self.__class__.__name__)
+        ret = self.host_subsys.config(self.target_config_file)
+        assert_equal(ret, True, "ERROR : host config failed")
+        raw_input("Press enter to continue ...")
-- 
1.8.3.1
