From: ckulkarnilinux@gmail.com (Chaitanya Kulkarni)
Date: Tue, 24 Oct 2017 18:30:20 -0700
Subject: [PATCH V2 03/46] nvmftests-utils: add shell command package
In-Reply-To: <1508895063-6280-1-git-send-email-ckulkarnilinux@gmail.com>
References: <1508895063-6280-1-git-send-email-ckulkarnilinux@gmail.com>
Message-ID: <1508895063-6280-4-git-send-email-ckulkarnilinux@gmail.com>

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

This adds a new class which is a wrapper to execute
a shell command and support for the shell package.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 .../selftests/nvmftests/utils/shell/__init__.py    | 20 +++++++++
 .../testing/selftests/nvmftests/utils/shell/cmd.py | 47 ++++++++++++++++++++++
 2 files changed, 67 insertions(+)
 create mode 100644 tools/testing/selftests/nvmftests/utils/shell/__init__.py
 create mode 100644 tools/testing/selftests/nvmftests/utils/shell/cmd.py

diff --git a/tools/testing/selftests/nvmftests/utils/shell/__init__.py b/tools/testing/selftests/nvmftests/utils/shell/__init__.py
new file mode 100644
index 0000000..7ddf843
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/utils/shell/__init__.py
@@ -0,0 +1,20 @@
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
+from .cmd import Cmd
diff --git a/tools/testing/selftests/nvmftests/utils/shell/cmd.py b/tools/testing/selftests/nvmftests/utils/shell/cmd.py
new file mode 100644
index 0000000..4a1a645
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/utils/shell/cmd.py
@@ -0,0 +1,47 @@
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
+""" Represents Shell Command execution.
+"""
+import subprocess
+
+
+class Cmd(object):
+
+    """
+    Represents a shell command execution.
+        - Attributes :
+    """
+
+    @staticmethod
+    def exec_cmd(cmd):
+        """ Wrapper for executing a shell command.
+            - Args :
+                - cmd : command to execute.
+            - Returns :
+                - True if cmd returns 0, False otherwise.
+        """
+        proc = None
+        try:
+            proc = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
+        except Exception as err:
+            print(str(err))
+            return False
+
+        return True if proc.wait() == 0 else False
-- 
1.8.3.1
