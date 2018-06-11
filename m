From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 11 Jun 2018 05:15:43 -0400
Subject: [PATCH V2 03/14] blktests: add NVMeOF file-ns target creation test
In-Reply-To: <20180611091554.19639-1-chaitanya.kulkarni@wdc.com>
References: <20180611091554.19639-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180611091554.19639-4-chaitanya.kulkarni@wdc.com>

This adds a new unit test to create NVMeOF target with file
backed namespace.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 tests/nvme/007     | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/007.out |  2 ++
 2 files changed, 62 insertions(+)
 create mode 100755 tests/nvme/007
 create mode 100644 tests/nvme/007.out

diff --git a/tests/nvme/007 b/tests/nvme/007
new file mode 100755
index 0000000..74eed0d
--- /dev/null
+++ b/tests/nvme/007
@@ -0,0 +1,60 @@
+#!/bin/bash
+# Test NVMeOF target creation with a file backed ns.
+# Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
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
+DESCRIPTION="unit tests for creating target with a file backed ns"
+QUICK=1
+
+requires() {
+	_have_program nvme && _have_module nvme-loop && _have_module nvmet && \
+		_have_configfs
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local port
+	local file_path
+	local subsys_name="blktests-subsystem-1"
+
+	modprobe nvmet
+	modprobe nvme-loop
+
+	file_path="${TMPDIR}/img"
+
+	truncate -s 1G "${file_path}"
+
+	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
+		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+	port="$(_create_nvmet_port "loop")"
+	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+
+	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
+	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_port "${port}"
+
+	rm "${file_path}"
+
+	modprobe -r nvme-loop
+	modprobe -r nvmet
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/007.out b/tests/nvme/007.out
new file mode 100644
index 0000000..fdb3472
--- /dev/null
+++ b/tests/nvme/007.out
@@ -0,0 +1,2 @@
+Running nvme/007
+Test complete
-- 
2.17.0
