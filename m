From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue,  4 Sep 2018 12:33:00 -0700
Subject: [PATCH V2 blktests 08/12] nvme: add NVMeOF ns-desc test for file-ns
In-Reply-To: <20180904193304.13350-1-chaitanya.kulkarni@wdc.com>
References: <20180904193304.13350-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180904193304.13350-9-chaitanya.kulkarni@wdc.com>

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 tests/nvme/026     | 77 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/026.out |  5 +++
 2 files changed, 82 insertions(+)
 create mode 100755 tests/nvme/026
 create mode 100644 tests/nvme/026.out

diff --git a/tests/nvme/026 b/tests/nvme/026
new file mode 100755
index 0000000..38ef38a
--- /dev/null
+++ b/tests/nvme/026
@@ -0,0 +1,77 @@
+#!/bin/bash
+# Test NVMe ns-descs command on NVMeOF with a file-backed ns.
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
+. tests/nvme/rc
+
+DESCRIPTION="test NVMe ns-descs command on NVMeOF file-backed ns"
+QUICK=1
+
+requires() {
+	_have_program nvme && _have_module nvme-loop && _have_module loop && \
+		_have_module nvmet && _have_configfs
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	modprobe nvmet
+	modprobe nvme-loop
+
+	local port
+	local nvmedev
+	local file_path="$TMPDIR/img"
+	local subsys_name="blktests-subsystem-1"
+
+	truncate -s 1G "${file_path}"
+
+	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
+		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+	port="$(_create_nvmet_port "loop")"
+	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+
+	nvme connect -t loop -n "${subsys_name}"
+
+	nvmedev="$(_find_nvme_loop_dev)"
+	cat "/sys/block/${nvmedev}n1/uuid"
+	cat "/sys/block/${nvmedev}n1/wwid"
+
+	nvme ns-descs "/dev/${nvmedev}" -n 1 > /dev/null 2>&1
+
+	rc=$?
+
+	nvme disconnect -n "${subsys_name}"
+
+	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
+	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_port "${port}"
+
+	rm -f "${file_path}"
+
+	modprobe -r nvme-loop
+	modprobe -r nvmet
+
+	if [ $rc -ne 0 ]; then
+		echo "Test Failed"
+	else
+		echo "Test complete"
+	fi
+}
diff --git a/tests/nvme/026.out b/tests/nvme/026.out
new file mode 100644
index 0000000..dcee481
--- /dev/null
+++ b/tests/nvme/026.out
@@ -0,0 +1,5 @@
+Running nvme/026
+91fdba0d-f87b-4c25-b80f-db7be1418b9e
+uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.17.0
