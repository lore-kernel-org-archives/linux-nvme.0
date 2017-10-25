From: ckulkarnilinux@gmail.com (Chaitanya Kulkarni)
Date: Tue, 24 Oct 2017 18:30:21 -0700
Subject: [PATCH V2 04/46] nvmftests-utils: add log package
In-Reply-To: <1508895063-6280-1-git-send-email-ckulkarnilinux@gmail.com>
References: <1508895063-6280-1-git-send-email-ckulkarnilinux@gmail.com>
Message-ID: <1508895063-6280-5-git-send-email-ckulkarnilinux@gmail.com>

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

This adds support to configure logging for the framework.
The new class uses log-level to configure the component
specific logging. Core framework and tests will use
this class to configure the logging.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 .../selftests/nvmftests/utils/log/__init__.py      | 20 ++++++++
 tools/testing/selftests/nvmftests/utils/log/log.py | 58 ++++++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100644 tools/testing/selftests/nvmftests/utils/log/__init__.py
 create mode 100644 tools/testing/selftests/nvmftests/utils/log/log.py

diff --git a/tools/testing/selftests/nvmftests/utils/log/__init__.py b/tools/testing/selftests/nvmftests/utils/log/__init__.py
new file mode 100644
index 0000000..adf0b7b
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/utils/log/__init__.py
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
+from .log import Log
diff --git a/tools/testing/selftests/nvmftests/utils/log/log.py b/tools/testing/selftests/nvmftests/utils/log/log.py
new file mode 100644
index 0000000..cd6ad66
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/utils/log/log.py
@@ -0,0 +1,58 @@
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
+""" Represents Testcaes Logging setup.
+"""
+import json
+import logging
+
+
+class Log(object):
+
+    """
+    Represents a console logger setup helper for a module.
+        - Attributes :
+    """
+
+    @staticmethod
+    def get_logger(name, element):
+        """ Returns the log level from config file.
+            - Args :
+                - element : NVMe Over Fabrics subsystem element.
+            - Returns :
+                - Valid Log level on success, None otherwise.
+        """
+        logger = None
+        with open('config/nvmftests.json') as cfg_file:
+            cfg = json.load(cfg_file)
+            logger = logging.getLogger(name)
+            if cfg['log'][element] == "NOTSET":
+                logger.setLevel(logging.DEBUG)
+            elif cfg['log'][element] == "DEBUG":
+                logger.setLevel(logging.DEBUG)
+            elif cfg['log'][element] == "INFO":
+                logger.setLevel(logging.INFO)
+            elif cfg['log'][element] == "WARNING":
+                logger.setLevel(logging.WARNING)
+            elif cfg['log'][element] == "ERROR":
+                logger.setLevel(logging.ERROR)
+            elif cfg['log'][element] == "CRITICAL":
+                logger.setLevel(logging.CRITICAL)
+
+        return logger
-- 
1.8.3.1
