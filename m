From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 11 Jun 2018 05:15:53 -0400
Subject: [PATCH V2 13/14] blktests: add NVMeOF many bdev-ns creation test
In-Reply-To: <20180611091554.19639-1-chaitanya.kulkarni@wdc.com>
References: <20180611091554.19639-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180611091554.19639-14-chaitanya.kulkarni@wdc.com>

This patch adds a new testcase to exercise a large number of ns
creation and deletion along with discovery command.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 tests/nvme/016     | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/016.out | 13 ++++++++++
 2 files changed, 77 insertions(+)
 create mode 100755 tests/nvme/016
 create mode 100644 tests/nvme/016.out

diff --git a/tests/nvme/016 b/tests/nvme/016
new file mode 100755
index 0000000..affcfb8
--- /dev/null
+++ b/tests/nvme/016
@@ -0,0 +1,64 @@
+#!/bin/bash
+#
+# Test many target bdev-ns creation/deletion under one subsystem.
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
+DESCRIPTION="create/delete many bdev-ns and test discovery"
+
+requires() {
+	_have_program nvme && _have_module nvme-loop && _have_module nvmet \
+		_have_configfs
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local port
+	local iterations=1000
+	local loop_dev="$(losetup -f)"
+	local subsys_nqn="blktests-subsystem-1"
+	local subsys_nqn_path="${NVMET_CFS}/subsystems/${subsys_nqn}"
+
+	modprobe nvmet
+	modprobe nvme-loop
+
+	_create_nvmet_subsystem "${subsys_nqn}" "${loop_dev}"
+
+	for ((i = 2; i <= iterations; i++)); do
+		_create_nvmet_ns "${subsys_nqn}" "${i}" "${loop_dev}"
+	done
+
+	port="$(_create_nvmet_port "loop")"
+	_add_nvmet_subsys_to_port "$port" "${subsys_nqn}"
+
+	nvme discover -t loop | sed -r -e "s/portid:  [0-9]+/portid:  X/"
+	_remove_nvmet_subsystem_from_port "${port}" "${subsys_nqn}"
+	_remove_nvmet_port "${port}"
+
+	for ((i = iterations; i > 1; i--)); do
+		_remove_nvmet_ns "${subsys_nqn}" $i
+	done
+
+	_remove_nvmet_subsystem "${subsys_nqn}"
+
+	modprobe -r nvme-loop nvmet
+	echo "Test complete"
+}
diff --git a/tests/nvme/016.out b/tests/nvme/016.out
new file mode 100644
index 0000000..59bd293
--- /dev/null
+++ b/tests/nvme/016.out
@@ -0,0 +1,13 @@
+Running nvme/016
+
+Discovery Log Number of Records 1, Generation counter 1
+=====Discovery Log Entry 0======
+trtype:  loop
+adrfam:  pci
+subtype: nvme subsystem
+treq:    not specified
+portid:  X
+trsvcid: 
+subnqn:  blktests-subsystem-1
+traddr:  
+Test complete
-- 
2.17.0
