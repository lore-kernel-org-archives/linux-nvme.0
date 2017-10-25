From: ckulkarnilinux@gmail.com (Chaitanya Kulkarni)
Date: Tue, 24 Oct 2017 18:30:52 -0700
Subject: [PATCH V2 35/46] nvmftests-tests: add a test to run IOs parallely
 with dd
In-Reply-To: <1508895063-6280-1-git-send-email-ckulkarnilinux@gmail.com>
References: <1508895063-6280-1-git-send-email-ckulkarnilinux@gmail.com>
Message-ID: <1508895063-6280-36-git-send-email-ckulkarnilinux@gmail.com>

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

This adds a new test to run IOs on all the controller
and its namespaces parallely from host.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 .../nvmftests/tests/test_nvmf_parallel_io.py       | 65 ++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 tools/testing/selftests/nvmftests/tests/test_nvmf_parallel_io.py

diff --git a/tools/testing/selftests/nvmftests/tests/test_nvmf_parallel_io.py b/tools/testing/selftests/nvmftests/tests/test_nvmf_parallel_io.py
new file mode 100644
index 0000000..1b28e44
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/tests/test_nvmf_parallel_io.py
@@ -0,0 +1,65 @@
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
+NVMF test parallel IOs on all controllers :-
+
+    1. From the config file create Target.
+    2. From the config file create host and connect to target.
+    3. Run parallel IOs on all available controller(s) and its namespace(s).
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
+class TestNVMFParallelIO(NVMFTest):
+
+    """ Represents Parallel Subsystem IO testcase """
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
+        super(TestNVMFParallelIO, self).common_setup()
+
+    def tearDown(self):
+        """ Post section of testcase """
+        super(TestNVMFParallelIO, self).common_tear_down()
+        self.loopdev.delete()
+
+    def test_parallel_io(self):
+        """ Testcase main """
+        print("Now Running " + self.__class__.__name__)
+        ret = self.host_subsys.run_ios_parallel(self.dd_read)
+        assert_equal(ret, True, "ERROR : running IOs failed.")
+        ret = self.host_subsys.run_ios_parallel(self.dd_write)
+        assert_equal(ret, True, "ERROR : running IOs failed.")
-- 
1.8.3.1
