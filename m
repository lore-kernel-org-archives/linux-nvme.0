From: ckulkarnilinux@gmail.com (Chaitanya Kulkarni)
Date: Tue, 24 Oct 2017 18:30:25 -0700
Subject: [PATCH V2 08/46] nvmftests: add utils package
In-Reply-To: <1508895063-6280-1-git-send-email-ckulkarnilinux@gmail.com>
References: <1508895063-6280-1-git-send-email-ckulkarnilinux@gmail.com>
Message-ID: <1508895063-6280-9-git-send-email-ckulkarnilinux@gmail.com>

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 .../testing/selftests/nvmftests/utils/__init__.py  | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 tools/testing/selftests/nvmftests/utils/__init__.py

diff --git a/tools/testing/selftests/nvmftests/utils/__init__.py b/tools/testing/selftests/nvmftests/utils/__init__.py
new file mode 100644
index 0000000..232b5a5
--- /dev/null
+++ b/tools/testing/selftests/nvmftests/utils/__init__.py
@@ -0,0 +1,32 @@
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
+from .fs import FileSystem
+from .fs import Ext4FS
+
+from .shell import cmd
+
+from .diskio import dd
+from .diskio import fio
+
+from .misc import Loopback
+from .misc import GenBlk
+from .misc import NVMePCIeBlk
+
+from .log import Log
-- 
1.8.3.1
