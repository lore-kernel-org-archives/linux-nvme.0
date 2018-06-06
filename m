From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue,  5 Jun 2018 20:52:01 -0400
Subject: [PATCH 03/12] blktests: add NVMeOF bdev-ns target creation test
In-Reply-To: <20180606005210.4197-1-chaitanya.kulkarni@wdc.com>
References: <20180606005210.4197-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180606005210.4197-4-chaitanya.kulkarni@wdc.com>

This adds a new unit test to create NVMeOF target with block-device
backed namespace.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 tests/nvme/007     | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/007.out |  2 ++
 2 files changed, 64 insertions(+)
 create mode 100755 tests/nvme/007
 create mode 100644 tests/nvme/007.out

diff --git a/tests/nvme/007 b/tests/nvme/007
new file mode 100755
index 0000000..af9e71a
--- /dev/null
+++ b/tests/nvme/007
@@ -0,0 +1,62 @@
+#!/bin/bash
+# Test NVMeOF target creation with a block device backed ns.
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
+DESCRIPTION="unit tests for creating target with a block device ns"
+QUICK=1
+
+requires() {
+	_have_program nvme && _have_module nvme-loop && _have_module loop && \
+		_have_configfs
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local port
+	local loop_dev
+	local subsys_name="blktests-subsystem-1"
+
+	modprobe nvmet
+	modprobe nvme-loop
+
+	truncate -s 1G "$TMPDIR/img"
+
+	loop_dev="$(losetup -f --show "$TMPDIR/img")"
+
+	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
+		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+	port="$(_create_nvmet_port "loop")"
+	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+
+	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
+	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_port "${port}"
+
+	losetup -d "$loop_dev"
+
+	rm "$TMPDIR/img"
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
2.9.5
