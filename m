From: hare@suse.de (Hannes Reinecke)
Date: Mon, 15 Oct 2018 09:01:29 +0200
Subject: [PATCH 2/3] nvme: add test for ANA state transition
In-Reply-To: <20181015070130.6695-1-hare@suse.de>
References: <20181015070130.6695-1-hare@suse.de>
Message-ID: <20181015070130.6695-3-hare@suse.de>

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 tests/nvme/018     | 141 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/018.out |  18 +++++++
 2 files changed, 159 insertions(+)
 create mode 100755 tests/nvme/018
 create mode 100644 tests/nvme/018.out

diff --git a/tests/nvme/018 b/tests/nvme/018
new file mode 100755
index 0000000..4d9b6c7
--- /dev/null
+++ b/tests/nvme/018
@@ -0,0 +1,141 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Regression test for ANA base support
+#
+# Copyright (C) 2018 Hannes Reinecke, SUSE Linux GmbH
+#
+
+. tests/nvme/rc
+
+DESCRIPTION="test ANA optimized/transitioning/inaccessible support"
+QUICK=1
+
+switch_nvmet_anagroup() {
+	local port1="$1"
+	local port2="$2"
+	local mode="$3"
+
+	echo "ANA state ${mode}"
+
+	if [ "${mode}" = "change" ] ; then
+		_set_nvmet_anagroup_state "${port1}" "1" "change"
+		_set_nvmet_anagroup_state "${port1}" "2" "change"
+		_set_nvmet_anagroup_state "${port2}" "1" "change"
+		_set_nvmet_anagroup_state "${port2}" "2" "change"
+	elif [ "${mode}" = "failover" ] ; then
+		_set_nvmet_anagroup_state "${port1}" "1" "inaccessible"
+		_set_nvmet_anagroup_state "${port1}" "2" "optimized"
+		_set_nvmet_anagroup_state "${port2}" "1" "optimized"
+		_set_nvmet_anagroup_state "${port2}" "2" "inaccessible"
+	else
+		_set_nvmet_anagroup_state "${port1}" "1" "optimized"
+		_set_nvmet_anagroup_state "${port1}" "2" "inaccessible"
+		_set_nvmet_anagroup_state "${port2}" "1" "inaccessible"
+		_set_nvmet_anagroup_state "${port2}" "2" "optimized"
+	fi
+}
+
+requires() {
+	_have_program nvme && _have_module nvme-loop && _have_module loop && \
+		_have_configfs && _have_fio
+}
+
+test() {
+	local mount_dir="/mnt/blktests"
+	local subsys="blktests-subsystem-1"
+	local port1
+	local port2
+	local loop_dev1
+	local loop_dev2
+	local nvmedev
+
+	echo "Running ${TEST_NAME}"
+
+	modprobe nvmet
+	modprobe nvme-loop
+
+	mkdir -p "${mount_dir}" > /dev/null 2>&1
+
+	port1="$(_create_nvmet_port "loop")"
+	ag1="$(_create_nvmet_anagroup "${port1}")"
+
+	port2="$(_create_nvmet_port "loop")"
+	ag2="$(_create_nvmet_anagroup "${port2}")"
+
+	truncate -s 1G "$TMPDIR/img1"
+
+	loop_dev1="$(losetup -f --show "$TMPDIR/img1")"
+
+	_create_nvmet_subsystem "${subsys}" "${loop_dev1}" \
+		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" "1"
+
+	truncate -s 1G "$TMPDIR/img2"
+
+	loop_dev2="$(losetup -f --show "$TMPDIR/img2")"
+
+	_create_nvmet_ns "${subsys}" "2" "${loop_dev2}" \
+		"9aed0138-bfd9-46f5-92ac-24c70377fd49" "2"
+
+	_add_nvmet_subsys_to_port "${port1}" "${subsys}"
+	_add_nvmet_subsys_to_port "${port2}" "${subsys}"
+
+	switch_nvmet_anagroup "${port1}" "${port2}" failback
+
+	nvme connect -t loop -a "${port1}" -n "${subsys}"
+	nvme connect -t loop -a "${port2}" -n "${subsys}"
+
+	sleep 1
+
+	_display_ana_state "${subsys}"
+
+	nvmedev="$(_find_nvme_ns 91fdba0d-f87b-4c25-b80f-db7be1418b9e)"
+
+	mkfs.xfs -f /dev/"${nvmedev}" > /dev/null 2>&1
+
+	mount /dev/"${nvmedev}" "${mount_dir}"
+
+	_run_fio_rand_io --size=63m --directory="${mount_dir}" --runtime=20s --time_based &
+	trap "kill $!" EXIT
+
+	sleep 10
+
+	switch_nvmet_anagroup "${port1}" "${port2}" "change"
+
+	# Insert a delay to allow the AEN to be processed
+	sleep 1
+
+	_display_ana_state "${subsys}"
+
+	sleep 6
+
+	switch_nvmet_anagroup "${port1}" "${port2}" "failover"
+
+	# Insert a delay to allow the AEN to be processed
+	sleep 1
+
+	_display_ana_state "${subsys}"
+
+	wait
+	trap - EXIT
+
+	umount "${mount_dir}" > /dev/null 2>&1
+
+	nvme disconnect -n "${subsys}"
+
+	_remove_nvmet_subsystem_from_port "${port1}" "${subsys}"
+	_remove_nvmet_subsystem_from_port "${port2}" "${subsys}"
+	_remove_nvmet_ns "${subsys}" "2"
+	_remove_nvmet_subsystem "${subsys}"
+	_remove_nvmet_anagroup "${port1}" "${ag1}"
+	_remove_nvmet_port "${port1}"
+	_remove_nvmet_anagroup "${port2}" "${ag2}"
+	_remove_nvmet_port "${port2}"
+	losetup -d "${loop_dev2}"
+	rm "$TMPDIR/img2"
+	losetup -d "${loop_dev1}"
+	rm "$TMPDIR/img1"
+
+	modprobe -r nvme-loop
+	modprobe -r nvmet
+	echo "Test complete"
+}
diff --git a/tests/nvme/018.out b/tests/nvme/018.out
new file mode 100644
index 0000000..77d52d2
--- /dev/null
+++ b/tests/nvme/018.out
@@ -0,0 +1,18 @@
+Running nvme/018
+ANA state failback
+1: grpid 1 state optimized
+1: grpid 2 state inaccessible
+2: grpid 1 state inaccessible
+2: grpid 2 state optimized
+ANA state change
+1: grpid 1 state change
+1: grpid 2 state change
+2: grpid 1 state change
+2: grpid 2 state change
+ANA state failover
+1: grpid 1 state inaccessible
+1: grpid 2 state optimized
+2: grpid 1 state optimized
+2: grpid 2 state inaccessible
+NQN:blktests-subsystem-1 disconnected 2 controller(s)
+Test complete
-- 
2.13.7
