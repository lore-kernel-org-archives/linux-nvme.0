From: ckulkarnilinux@gmail.com (Chaitanya Kulkarni)
Date: Tue, 24 Oct 2017 18:30:22 -0700
Subject: [PATCH V2 05/46] nvmftests-utils: add diskio package
In-Reply-To: <1508895063-6280-1-git-send-email-ckulkarnilinux@gmail.com>
References: <1508895063-6280-1-git-send-email-ckulkarnilinux@gmail.com>
Message-ID: <1508895063-6280-6-git-send-email-ckulkarnilinux@gmail.com>

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

This adds wrapper classes for different I/O utilities.
In current implementation it uses dd(1) and
fio wrapper. These classes will be used by host side tests
to generate I/O workload on host namespace.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 .../selftests/nvmftests/utils/diskio/__init__.py   | 21 ++++++
 .../testing/selftests/nvmftests/utils/diskio/dd.py | 50 +++++++++++++++
 .../selftests/nvmftests/utils/diskio/fio.py        | 74 ++++++++++++++++++++++
 3 files changed, 145 insertions(+)
 create mode 100644 tools/testing/selftests/nvmftests/utils/diskio/__init__.py
 create mode 100644 tools/testing/selftests/nvmftests/utils/diskio/dd.py
 create mode 100644 tools/testing/selftests/nvmftests/utils/diskio/fio.py

diff --git a/tools/testing/selftests/nvmftests/utils/diskio/__init__.py b/tools/testing/selftests/nvmftests/utils/diskio/__init__.py
new file mode 100644
index 0000000..52babcf
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/utils/diskio/__init__.py
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
+from .dd import DD
+from .fio import FIO
diff --git a/tools/testing/selftests/nvmftests/utils/diskio/dd.py b/tools/testing/selftests/nvmftests/utils/diskio/dd.py
new file mode 100644
index 0000000..ad71a8b
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/utils/diskio/dd.py
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
+""" Represents dd(1) wrapper
+"""
+
+import subprocess
+
+
+class DD(object):
+
+    """
+    Represents dd command wrapper.
+    """
+
+    @staticmethod
+    def run_io(iocfg):
+        """ Executes dd command based on the config argument.
+            - Args :
+                - IO Configuration for dd command.
+            - Returns :
+                - True on success, False on failure.
+        """
+        cmd = "dd if=" + iocfg['IF'] + " of=" + iocfg['OF'] + \
+            " bs=" + iocfg['BS'] + " count=" + iocfg['COUNT'] + \
+            " > /tmp/op 2>&1"
+
+        proc = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
+        ret = True
+        rc = proc.wait()
+        if rc != iocfg['RC']:
+            ret = False
+
+        return ret
diff --git a/tools/testing/selftests/nvmftests/utils/diskio/fio.py b/tools/testing/selftests/nvmftests/utils/diskio/fio.py
new file mode 100644
index 0000000..fbc95e9f
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/utils/diskio/fio.py
@@ -0,0 +1,74 @@
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
+""" Represents FIO wrapper
+"""
+
+import subprocess
+
+
+class FIO(object):
+
+    """
+    Represents fio command wrapper.
+    """
+
+    @staticmethod
+    def run_io(iocfg):
+        """ Executes fio command based on the config argument.
+            - Args :
+                - IO Configuration for fio command.
+            - Returns :
+                - True on success, False on failure.
+        """
+        cmd = "fio "
+        cmd += " --group_reporting=" + iocfg['group_reporting']
+        cmd += " --rw=" + iocfg['rw']
+        cmd += " --bs=" + iocfg['bs']
+        cmd += " --numjobs=" + iocfg['numjobs']
+        cmd += " --iodepth=" + iocfg['iodepth']
+        cmd += " --runtime=" + iocfg['runtime']
+        cmd += " --loops=" + iocfg['loop']
+        cmd += " --ioengine=" + iocfg['ioengine']
+        cmd += " --direct=" + iocfg['direct']
+        cmd += " --invalidate=" + iocfg['invalidate']
+        cmd += " --randrepeat=" + iocfg['randrepeat']
+        cmd += " --time_based "
+        cmd += " --norandommap"
+        cmd += " --exitall"
+        cmd += " --size=" + iocfg['size']
+        if 'filename' in iocfg:
+            cmd += " --filename=" + iocfg['filename']
+            cmd += " --output=" + iocfg['filename'].split('/')[-1] + "_fio.log"
+        else:
+            cmd += " --directory=" + iocfg['directory']
+            cmd += " --output=" + iocfg['directory'].split('/')[-2] + \
+                   "_fio.log"
+        cmd += " --name=" + iocfg['name']
+        ret = True
+        proc = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
+        rc = proc.wait()
+        """
+            some testcases expect fio to fail which is success for the
+            testcase so we test against RC value before deciding success and
+            failure of fio execution
+        """
+        if rc != iocfg['RC']:
+            ret = False
+        return ret
-- 
1.8.3.1
