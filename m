From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 11 Jun 2018 05:15:50 -0400
Subject: [PATCH V2 10/14] blktests: add NVMeOF mkfs test for file-ns
In-Reply-To: <20180611091554.19639-1-chaitanya.kulkarni@wdc.com>
References: <20180611091554.19639-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180611091554.19639-11-chaitanya.kulkarni@wdc.com>

This adds a new test which formats the ns with file system on the host side
and runs fio data verification workload.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 tests/nvme/013     | 84 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/013.out |  5 +++
 2 files changed, 89 insertions(+)
 create mode 100755 tests/nvme/013
 create mode 100644 tests/nvme/013.out

diff --git a/tests/nvme/013 b/tests/nvme/013
new file mode 100755
index 0000000..164a15e
--- /dev/null
+++ b/tests/nvme/013
@@ -0,0 +1,84 @@
+#!/bin/bash
+# Test mkfs with data verification for file backed ns.
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
+DESCRIPTION="test mkfs with data verification for file backed ns"
+
+requires() {
+	_have_program nvme && _have_program mkfs.xfs && _have_fio && \
+		_have_module nvmet && _have_module nvme-loop && \
+		_have_configfs
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
+	local mount_dir="/mnt/blktests/"
+	local file_path="${TMPDIR}/img"
+
+	local subsys_name="blktests-subsystem-1"
+
+	mkdir -p "${mount_dir}" > /dev/null 2>&1
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
+	umount ${mount_dir} > /dev/null 2>&1
+
+	mkfs.xfs -f /dev/"${nvmedev}n1" > /dev/null 2>&1
+
+	mount /dev/"${nvmedev}n1" "${mount_dir}"
+
+	_run_fio_verify_io --size=800m --directory="${mount_dir}/"
+
+	umount "${mount_dir}" > /dev/null 2>&1
+
+	nvme disconnect -n "${subsys_name}"
+
+	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
+	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_port "${port}"
+
+	rm -f local*verify*state
+	rm "${file_path}"
+	rm -fr "${mount_dir}"
+
+	modprobe -r nvme_loop
+	modprobe -r nvmet
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/013.out b/tests/nvme/013.out
new file mode 100644
index 0000000..f7285a9
--- /dev/null
+++ b/tests/nvme/013.out
@@ -0,0 +1,5 @@
+Running nvme/013
+91fdba0d-f87b-4c25-b80f-db7be1418b9e
+uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.17.0
