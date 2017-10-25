From: ckulkarnilinux@gmail.com (Chaitanya Kulkarni)
Date: Tue, 24 Oct 2017 18:30:38 -0700
Subject: [PATCH V2 21/46] nvmftests-tests: add support for test logger
In-Reply-To: <1508895063-6280-1-git-send-email-ckulkarnilinux@gmail.com>
References: <1508895063-6280-1-git-send-email-ckulkarnilinux@gmail.com>
Message-ID: <1508895063-6280-22-git-send-email-ckulkarnilinux@gmail.com>

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

This adds support to store hierarchical logs for each execution.
Each test will use its unique class name under which this will
store all the logs.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 .../selftests/nvmftests/tests/nvmf_test_logger.py  | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 tools/testing/selftests/nvmftests/tests/nvmf_test_logger.py

diff --git a/tools/testing/selftests/nvmftests/tests/nvmf_test_logger.py b/tools/testing/selftests/nvmftests/tests/nvmf_test_logger.py
new file mode 100644
index 0000000..16230f8
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/tests/nvmf_test_logger.py
@@ -0,0 +1,50 @@
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
+"""Logger for NVMe Test Framwwork.
+"""
+import sys
+
+
+class NVMFLogger(object):
+    """ Represents Logger for NVMe Testframework.  """
+    def __init__(self, log_file_path):
+        """ Logger setup.
+            - Args :
+                - log_file_path : path to store the log.
+        """
+        self.terminal = sys.stdout
+        self.log = open(log_file_path, "w")
+
+    def write(self, log_message):
+        """ Logger write.
+            - Args :
+                - log_message : string to write in the log file.
+            - Returns:
+                - None.
+        """
+        self.terminal.write(log_message)
+        self.log.write(log_message)
+
+    def flush(self):
+        """ This flush method is needed for python 3 compatibility.
+            this handles the flush command by doing nothing.
+            you might want to specify some extra behavior here.
+        """
+        pass
-- 
1.8.3.1
