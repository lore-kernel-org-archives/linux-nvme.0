From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue,  4 Sep 2018 12:32:54 -0700
Subject: [PATCH V2 blktests 02/12] nvme: add NVMeOF DSM discard test for
 file-ns
In-Reply-To: <20180904193304.13350-1-chaitanya.kulkarni@wdc.com>
References: <20180904193304.13350-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180904193304.13350-3-chaitanya.kulkarni@wdc.com>

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 tests/nvme/020     | 72 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/020.out |  6 ++++
 2 files changed, 78 insertions(+)
 create mode 100755 tests/nvme/020
 create mode 100644 tests/nvme/020.out

diff --git a/tests/nvme/020 b/tests/nvme/020
new file mode 100755
index 0000000..fcf68df
--- /dev/null
+++ b/tests/nvme/020
@@ -0,0 +1,72 @@
+#!/bin/bash
+# Test NVMe DSM Discard command on NVMeOF with a file-backed ns.
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
+DESCRIPTION="test NVMe DSM Discard command on NVMeOF file-backed ns"
+QUICK=1
+
+requires() {
+	_have_program nvme && _have_module nvme-loop && _have_configfs \
+		_have_module nvmet
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
+	local nblk_range="10,10,10,10,10,10,10,10,10,10"
+	local sblk_range="100,200,300,400,500,600,700,800,900,1000"
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
+	nvme dsm "/dev/${nvmedev}" -n 1 -d -s "${sblk_range}" -b "${nblk_range}"
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
+	echo "Test complete"
+}
diff --git a/tests/nvme/020.out b/tests/nvme/020.out
new file mode 100644
index 0000000..113c177
--- /dev/null
+++ b/tests/nvme/020.out
@@ -0,0 +1,6 @@
+Running nvme/020
+91fdba0d-f87b-4c25-b80f-db7be1418b9e
+uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
+NVMe DSM: success
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.17.0
