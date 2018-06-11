From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 11 Jun 2018 05:15:47 -0400
Subject: [PATCH V2 07/14] blktests: add NVMeoF data verification test for
 bdev-ns
In-Reply-To: <20180611091554.19639-1-chaitanya.kulkarni@wdc.com>
References: <20180611091554.19639-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180611091554.19639-8-chaitanya.kulkarni@wdc.com>

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 tests/nvme/010     | 76 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/010.out |  5 +++
 2 files changed, 81 insertions(+)
 create mode 100755 tests/nvme/010
 create mode 100644 tests/nvme/010.out

diff --git a/tests/nvme/010 b/tests/nvme/010
new file mode 100755
index 0000000..4224ea6
--- /dev/null
+++ b/tests/nvme/010
@@ -0,0 +1,76 @@
+#!/bin/bash
+# This is a data verification test for block device backed ns.
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
+DESCRIPTION="data verification test for block device backed ns"
+
+requires() {
+	_have_program nvme && _have_fio && _have_module loop && \
+		_have_configfs && _have_module nvme-loop && \
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
+	local ret=0
+	local nvmedev
+	local loop_dev
+	local file_path="${TMPDIR}/img"
+	local subsys_name="blktests-subsystem-1"
+
+	truncate -s 1G "${file_path}"
+
+	loop_dev="$(losetup -f --show "${file_path}")"
+
+	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
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
+	_run_fio_verify_io --size=950m --filename="/dev/${nvmedev}n1"
+
+	nvme disconnect -n "${subsys_name}"
+
+	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
+	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_port "${port}"
+
+	losetup -d "${loop_dev}"
+
+	rm "${file_path}"
+	rm -f local*verify*state "${fio_out}"
+
+	modprobe -r nvme_loop
+	modprobe -r nvmet
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/010.out b/tests/nvme/010.out
new file mode 100644
index 0000000..788ea96
--- /dev/null
+++ b/tests/nvme/010.out
@@ -0,0 +1,5 @@
+Running nvme/010
+91fdba0d-f87b-4c25-b80f-db7be1418b9e
+uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.17.0
