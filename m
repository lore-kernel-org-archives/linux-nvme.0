From: ckulkarnilinux@gmail.com (Chaitanya Kulkarni)
Date: Tue, 24 Oct 2017 18:30:23 -0700
Subject: [PATCH V2 06/46] nvmftests-utils: add fs package
In-Reply-To: <1508895063-6280-1-git-send-email-ckulkarnilinux@gmail.com>
References: <1508895063-6280-1-git-send-email-ckulkarnilinux@gmail.com>
Message-ID: <1508895063-6280-7-git-send-email-ckulkarnilinux@gmail.com>

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

This adds wrapper classes for handling different
file system related operations. In current implementation
it has a support for ext4 file system.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 .../selftests/nvmftests/utils/fs/__init__.py       |  21 ++++
 .../testing/selftests/nvmftests/utils/fs/ext4fs.py | 108 ++++++++++++++++++
 .../selftests/nvmftests/utils/fs/filesystem.py     | 122 +++++++++++++++++++++
 3 files changed, 251 insertions(+)
 create mode 100644 tools/testing/selftests/nvmftests/utils/fs/__init__.py
 create mode 100644 tools/testing/selftests/nvmftests/utils/fs/ext4fs.py
 create mode 100644 tools/testing/selftests/nvmftests/utils/fs/filesystem.py

diff --git a/tools/testing/selftests/nvmftests/utils/fs/__init__.py b/tools/testing/selftests/nvmftests/utils/fs/__init__.py
new file mode 100644
index 0000000..e83f580
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/utils/fs/__init__.py
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
+from .filesystem import FileSystem
+from .ext4fs import Ext4FS
diff --git a/tools/testing/selftests/nvmftests/utils/fs/ext4fs.py b/tools/testing/selftests/nvmftests/utils/fs/ext4fs.py
new file mode 100644
index 0000000..e0a5146
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/utils/fs/ext4fs.py
@@ -0,0 +1,108 @@
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
+""" Represents Ext4 File system.
+"""
+import os
+import logging
+
+from .filesystem import FileSystem
+from utils.shell import Cmd
+
+
+class Ext4FS(FileSystem):
+    """
+    Represents Ext4 File System management interface.
+
+        - Attributes :
+    """
+    def __init__(self, dev_path, mount_path=None):
+        super(Ext4FS, self).__init__("ext4", dev_path, mount_path)
+        self.logger = logging.getLogger(__name__)
+        self.log_format = '%(asctime)s %(name)-12s %(levelname)-8s %(message)s'
+        self.log_format += '%(filename)20s %(funcName)20s %(lineno)4d'
+        self.log_format += '%(pathname)s'
+        self.formatter = logging.Formatter(self.log_format)
+        self.logger.setLevel(logging.WARNING)
+
+    def get_mount_path(self):
+        """ Accessor for file system mountpath.
+            - Args :
+                - None.
+            - Returns :
+                - File system mountpath.
+        """
+        return super(Ext4FS, self).get_mount_path()
+
+    def mkfs(self):
+        """ Execute mkfs on target deivce.
+            - Args :
+                - None.
+            - Returns :
+                - True on success, False on failure.
+        """
+        if super(Ext4FS, self).mkfs() is False:
+            return False
+
+        if Cmd.exec_cmd("mkfs.ext4 " + self.dev_path) is False:
+            self.logger.error("mkfs failed")
+            return False
+
+        self.logger.info("mkfs successful!!!")
+        return True
+
+    def mount(self):
+        """ Mount Target device on the mount path.
+            - Args :
+                - None.
+            - Returns :
+                - True on success, False on failure.
+        """
+        if super(Ext4FS, self).mount() is False:
+            return False
+        return Cmd.exec_cmd("mount " + self.dev_path + " " + self.mount_path)
+
+    def is_mounted(self):
+        """ Check if mount_path is mounted.
+            - Args :
+                - None.
+            - Returns :
+                - True on success, False on failure.
+        """
+        return Cmd.exec_cmd("mountpoint -q " + self.mount_path)
+
+    def umount(self):
+        """ Unmount target device from mount path.
+            - Args :
+                - None.
+            - Returns :
+                - True on success, False on failure.
+        """
+        if super(Ext4FS, self).umount() is False:
+            return False
+
+        ret = True
+        Cmd.exec_cmd("umount " + self.mount_path)
+        try:
+            os.rmdir(self.mount_path)
+        except Exception as err:
+            self.logger.info(str(err))
+            ret = False
+
+        return ret
diff --git a/tools/testing/selftests/nvmftests/utils/fs/filesystem.py b/tools/testing/selftests/nvmftests/utils/fs/filesystem.py
new file mode 100644
index 0000000..cedb9e9
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/utils/fs/filesystem.py
@@ -0,0 +1,122 @@
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
+""" Represents File System Base class.
+"""
+import os
+import stat
+import logging
+
+
+from utils.shell import Cmd
+
+
+class FileSystem(object):
+    """
+    Represents file system management interface.
+
+        - Attributes :
+            - fs_name : file system name.
+            - dev_path : target device.
+            - mount_path : path to mount target device.
+    """
+    def __init__(self, fs_name, dev_path, mount_path=None):
+        self.fs_name = fs_name
+        self.dev_path = dev_path
+        self.mount_path = mount_path
+        if self.mount_path is None:
+            self.mount_path = "/mnt/" + self.dev_path.split('/')[-1]
+
+        self.logger = logging.getLogger(__name__)
+        self.log_format = '%(asctime)s %(name)-12s %(levelname)-8s %(message)s'
+        self.log_format += '%(filename)20s %(funcName)20s %(lineno)4d'
+        self.log_format += '%(pathname)s'
+        self.formatter = logging.Formatter(self.log_format)
+        self.logger.setLevel(logging.WARNING)
+
+    def mkfs(self):
+        """ Check preconditions for the mkfs operation, subclass should
+            implement actual mkfs.
+            - Args :
+                - None.
+            - Returns :
+                - True on success, False on failure.
+        """
+        if not os.path.exists(self.dev_path):
+            self.logger.info("ERROR : device path %s is not present.",
+                             self.dev_path)
+            return False
+
+        if not stat.S_ISBLK(os.stat(self.dev_path).st_mode):
+            self.logger.info("ERRO : block device expected for mkfs.")
+            return False
+
+        if self.is_mounted() is True:
+            self.logger.info("ERROR : device is already mounted.")
+            return False
+
+        return True
+
+    def mount(self):
+        """ Check preconditions for the mount operation.
+            - Args :
+                - None.
+            - Returns :
+                - True on success, False on failure.
+        """
+        if not os.path.exists(self.mount_path):
+            try:
+                os.makedirs(self.mount_path)
+            except Exception as err:
+                self.logger.info(str(err))
+                return False
+
+        return True
+
+    def get_mount_path(self):
+        """ Accessor for file system mountpath.
+            - Args :
+                - None.
+            - Returns :
+                - File system mountpath.
+        """
+        # TODO : add mount check here
+        return self.mount_path
+
+    def umount(self):
+        """ Check preconditions for the umount operation.
+            - Args :
+                - None.
+            - Returns :
+                - True on success, False on failure.
+        """
+        if not self.is_mounted():
+            self.logger.info("fs is not mounted")
+            return False
+
+        return True
+
+    def is_mounted(self):
+        """ Check if mount_path is mounted.
+            - Args :
+                - None.
+            - Returns :
+                - True on success, False on failure.
+        """
+        return Cmd.exec_cmd("mountpoint -q " + self.mount_path)
-- 
1.8.3.1
