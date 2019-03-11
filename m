From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 11 Mar 2019 15:18:55 -0700
Subject: [PATCH v2] nvme: test out-of-range I/O access (file backend)
Message-ID: <20190311221855.27375-1-sagi@grimberg.me>

Test that we correctly fail an out-of-range access
with a proper NVMe status code.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
Changes from v1:
- "ERROR:" prefix to err message
- document that we are testing file backend

 tests/nvme/018     | 58 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/018.out |  6 +++++
 2 files changed, 64 insertions(+)
 create mode 100755 tests/nvme/018
 create mode 100755 tests/nvme/018.out

diff --git a/tests/nvme/018 b/tests/nvme/018
new file mode 100755
index 000000000000..30140ae15f9d
--- /dev/null
+++ b/tests/nvme/018
@@ -0,0 +1,58 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2018 Sagi Grimberg
+#
+# Test NVMe out of range access on a file backend
+
+. tests/nvme/rc
+
+DESCRIPTION="unit test NVMe-oF out of range access on a file backend"
+QUICK=1
+
+requires() {
+	_have_program nvme && _have_modules nvme-loop && _have_modules loop && \
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
+	local nvmedev
+	local file_path="$TMPDIR/img"
+	local subsys_name="blktests-subsystem-1"
+
+	truncate -s 1G "${file_path}"
+
+	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
+		 "91fdba0d-f87b-4c25-b80f-db7be1418b9e"
+	port="$(_create_nvmet_port "loop")"
+	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+
+	nvme connect -t loop -n "${subsys_name}"
+
+	nvmedev="$(_find_nvme_loop_dev)"
+	cat "/sys/block/${nvmedev}n1/uuid"
+	cat "/sys/block/${nvmedev}n1/wwid"
+
+	sectors=$(blockdev --getsz /dev/${nvmedev}n1)
+	bs=$(blockdev --getbsz /dev/${nvmedev}n1)
+
+	nvme read "/dev/${nvmedev}n1" -s $sectors -c 0 -z $bs
+	if [[ ! $? ]]; then
+		echo "ERROR: Successfully read out of device lba range"
+	fi
+
+	nvme disconnect -n "${subsys_name}"
+
+	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
+	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_port "${port}"
+
+	rm "${file_path}"
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/018.out b/tests/nvme/018.out
new file mode 100755
index 000000000000..0ab3b2a892d3
--- /dev/null
+++ b/tests/nvme/018.out
@@ -0,0 +1,6 @@
+Running nvme/018
+91fdba0d-f87b-4c25-b80f-db7be1418b9e
+uuid.91fdba0d-f87b-4c25-b80f-db7be1418b9e
+read:CAP_EXCEEDED: The execution of the command has caused the capacity of the namespace to be exceeded(6081)
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.17.1
