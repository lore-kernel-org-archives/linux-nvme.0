From: ckulkarnilinux@gmail.com (Chaitanya Kulkarni)
Date: Tue, 24 Oct 2017 18:30:19 -0700
Subject: [PATCH V2 02/46] nvmftests-utils: add utility class to define
 constants
In-Reply-To: <1508895063-6280-1-git-send-email-ckulkarnilinux@gmail.com>
References: <1508895063-6280-1-git-send-email-ckulkarnilinux@gmail.com>
Message-ID: <1508895063-6280-3-git-send-email-ckulkarnilinux@gmail.com>

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

The new directory utils holds utility classes required
for the framework/tests.

This adds a new class to store all the constants/literals
which are used in the core test framework and tests.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 .../selftests/nvmftests/utils/const/__init__.py    | 21 +++++++++
 .../selftests/nvmftests/utils/const/const.py       | 50 ++++++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 tools/testing/selftests/nvmftests/utils/const/__init__.py
 create mode 100644 tools/testing/selftests/nvmftests/utils/const/const.py

diff --git a/tools/testing/selftests/nvmftests/utils/const/__init__.py b/tools/testing/selftests/nvmftests/utils/const/__init__.py
new file mode 100644
index 0000000..4623af3
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/utils/const/__init__.py
@@ -0,0 +1,21 @@
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
+from .const import Const
diff --git a/tools/testing/selftests/nvmftests/utils/const/const.py b/tools/testing/selftests/nvmftests/utils/const/const.py
new file mode 100644
index 0000000..128b031
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/utils/const/const.py
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
+""" Represents General Constants used in the framework.
+"""
+
+
+class Const:
+
+    """
+    Represents a host.
+        - Attributes :
+            General constants for testcases.
+    """
+
+    XXX = "XXX"
+    ONE_KB = 1024
+    ONE_MB = ONE_KB * ONE_KB
+    ONE_GB = ONE_MB * ONE_KB
+
+    KB = "KB"
+    MB = "MB"
+    GB = "GB"
+
+    EXT4 = "ext4"
+
+    CTRL_BLK_FILE_NAME = 2
+    SMART_LOG_VALUE = 1
+    ALLOW_HOST_VALUE = 0
+
+    SYSFS_DEFAULT_MOUNT_PATH = "/sys/kernel/config/"
+    SYSFS_NVMET = "/nvmet/"
+    SYSFS_NVMET_SUBSYS = SYSFS_NVMET + "/subsystems/"
+    SYSFS_NVMET_SUBSYS_NS = "/namespaces/"
-- 
1.8.3.1
