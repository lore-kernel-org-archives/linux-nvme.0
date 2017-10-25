From: ckulkarnilinux@gmail.com (Chaitanya Kulkarni)
Date: Tue, 24 Oct 2017 18:30:35 -0700
Subject: [PATCH V2 18/46] nvmftests-nvmf: add host package
In-Reply-To: <1508895063-6280-1-git-send-email-ckulkarnilinux@gmail.com>
References: <1508895063-6280-1-git-send-email-ckulkarnilinux@gmail.com>
Message-ID: <1508895063-6280-19-git-send-email-ckulkarnilinux@gmail.com>

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

This adds a support for host package. In current implementation
host package supports ns, subsystem and configuration
management in loop mode.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 .../selftests/nvmftests/nvmf/host/__init__.py      | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 tools/testing/selftests/nvmftests/nvmf/host/__init__.py

diff --git a/tools/testing/selftests/nvmftests/nvmf/host/__init__.py b/tools/testing/selftests/nvmftests/nvmf/host/__init__.py
new file mode 100644
index 0000000..10a2e4ee
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/nvmf/host/__init__.py
@@ -0,0 +1,23 @@
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
+from .host import NVMFHost
+from .host_subsystem import NVMFHostController
+from .host_ns import NVMFHostNamespace
-- 
1.8.3.1
