From: ckulkarnilinux@gmail.com (Chaitanya Kulkarni)
Date: Tue, 24 Oct 2017 18:30:49 -0700
Subject: [PATCH V2 32/46] nvmftests-tests: add a test for identify namespace
In-Reply-To: <1508895063-6280-1-git-send-email-ckulkarnilinux@gmail.com>
References: <1508895063-6280-1-git-send-email-ckulkarnilinux@gmail.com>
Message-ID: <1508895063-6280-33-git-send-email-ckulkarnilinux@gmail.com>

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

This adds a new test to execute identify namespace command
from host.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 .../selftests/nvmftests/tests/test_nvmf_id_ns.py   | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 tools/testing/selftests/nvmftests/tests/test_nvmf_id_ns.py

diff --git a/tools/testing/selftests/nvmftests/tests/test_nvmf_id_ns.py b/tools/testing/selftests/nvmftests/tests/test_nvmf_id_ns.py
new file mode 100644
index 0000000..365bcad
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/tests/test_nvmf_id_ns.py
@@ -0,0 +1,63 @@
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
+NVMF test id-ns on each namespace :-
+
+    1. From the config file create Target.
+    2. From the config file create host and connect to target.
+    3. Execute id-ns.
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
+class TestNVMFIdentifyNamespace(NVMFTest):
+
+    """ Represents Identify Namespace Test testcase """
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
+        super(TestNVMFIdentifyNamespace, self).common_setup()
+
+    def tearDown(self):
+        """ Post section of testcase """
+        super(TestNVMFIdentifyNamespace, self).common_tear_down()
+        self.loopdev.delete()
+
+    def test_identify_namespace(self):
+        """ Testcase main """
+        print("Now Running " + self.__class__.__name__)
+        ret = self.host_subsys.id_ns()
+        assert_equal(ret, True, "ERROR : id ns failed.")
-- 
1.8.3.1
