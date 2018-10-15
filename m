From: hare@suse.de (Hannes Reinecke)
Date: Mon, 15 Oct 2018 09:01:30 +0200
Subject: [PATCH 3/3] nvme: Add test for fcloop
In-Reply-To: <20181015070130.6695-1-hare@suse.de>
References: <20181015070130.6695-1-hare@suse.de>
Message-ID: <20181015070130.6695-4-hare@suse.de>

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 tests/nvme/029     | 123 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/029.out |   2 +
 tests/nvme/rc      |  52 ++++++++++++++++++++++
 3 files changed, 177 insertions(+)
 create mode 100755 tests/nvme/029
 create mode 100644 tests/nvme/029.out

diff --git a/tests/nvme/029 b/tests/nvme/029
new file mode 100755
index 0000000..f8ed9b5
--- /dev/null
+++ b/tests/nvme/029
@@ -0,0 +1,123 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2018 Johannes Thumshirn, Hannes Reinecke, SUSE Linux GmbH
+#
+# Reproducer for nvme-fcloop
+#
+
+. tests/nvme/rc
+
+DESCRIPTION="create nvme-fcloop with two ports and connect/disconnect"
+
+requires() {
+	_have_module nvme-fcloop && _have_module nvmet && _have_module loop && \
+		_have_configfs && _have_module nvme-core && \
+		_have_module nvmet-fc
+}
+
+test() {
+	local subsys="blktests-subsystem-1"
+	local remote_wwnn1="0x100140111111dbcc"
+	local remote_wwpn1="0x200140111111dbcc"
+	local remote_wwnn2="0x100140111111dbcd"
+	local remote_wwpn2="0x200140111111dbcd"
+	local host_wwnn1="0x100140111111dac8"
+	local host_wwpn1="0x200140111111dac8"
+	local host_wwnn2="0x100140111111dac9"
+	local host_wwpn2="0x200140111111dac9"
+
+	echo "Running ${TEST_NAME}"
+
+	modprobe nvmet-fc
+	modprobe nvme-fcloop
+
+	_nvme_fcloop_add_tport ${remote_wwnn1} ${remote_wwpn1}
+	_nvme_fcloop_add_tport ${remote_wwnn2} ${remote_wwpn2}
+
+	_nvme_fcloop_add_lport ${host_wwnn1} ${host_wwpn1}
+	_nvme_fcloop_add_lport ${host_wwnn2} ${host_wwpn2}
+
+	_nvme_fcloop_add_rport ${host_wwnn1} ${host_wwpn1} \
+		${remote_wwnn1} ${remote_wwpn1}
+	_nvme_fcloop_add_rport ${host_wwnn2} ${host_wwpn2} \
+		${remote_wwnn2} ${remote_wwpn2}
+
+	local port1
+	port1=$(_create_nvmet_port "fc")
+	ag1="$(_create_nvmet_anagroup "${port1}")"
+
+	local port2
+	port2=$(_create_nvmet_port "fc")
+	ag2="$(_create_nvmet_anagroup "${port2}")"
+
+	local remote_traddr1
+	remote_traddr1=$(printf "nn-%s:pn-%s" "${remote_wwnn1}" "${remote_wwpn1}")
+	echo fc > /sys/kernel/config/nvmet/ports/${port1}/addr_adrfam
+	echo "${remote_traddr1}" > /sys/kernel/config/nvmet/ports/${port1}/addr_traddr
+
+	local remote_traddr2
+	remote_traddr2=$(printf "nn-%s:pn-%s" "${remote_wwnn2}" "${remote_wwpn2}")
+	echo fc > /sys/kernel/config/nvmet/ports/${port2}/addr_adrfam
+	echo "${remote_traddr2}" > /sys/kernel/config/nvmet/ports/${port2}/addr_traddr
+
+	truncate -s 1G "$TMPDIR/img"
+
+	local loop_dev
+	loop_dev="$(losetup -f --show "$TMPDIR/img")"
+
+	_create_nvmet_subsystem "${subsys}" "${loop_dev}" \
+		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" "1"
+	_add_nvmet_subsys_to_port "${port1}" "${subsys}"
+	_add_nvmet_subsys_to_port "${port2}" "${subsys}"
+
+	_set_nvmet_anagroup_state "${port2}" "1" "inaccessible"
+	_set_nvmet_anagroup_state "${port2}" "2" "optimized"
+
+	local host_traddr1
+	host_traddr1=$(printf "nn-%s:pn-%s" "${host_wwnn1}" "${host_wwpn1}")
+
+	nvme connect -t fc -a "${remote_traddr1}"  -w "${host_traddr1}" \
+		-n "${subsys}"
+
+	local host_traddr2
+	host_traddr2=$(printf "nn-%s:pn-%s" "${host_wwnn2}" "${host_wwpn2}")
+
+	nvme connect -t fc -a "${remote_traddr2}"  -w "${host_traddr2}" \
+		-n "${subsys}"
+
+	nvmedev="$(_find_nvme_ns 91fdba0d-f87b-4c25-b80f-db7be1418b9e)"
+
+	# Allow I/O to settle
+	udevadm settle
+
+	nvme disconnect -n "${subsys}"
+
+	_remove_nvmet_subsystem_from_port "${port1}" "${subsys}"
+	_remove_nvmet_subsystem_from_port "${port2}" "${subsys}"
+	_remove_nvmet_subsystem "${subsys}"
+	_remove_nvmet_anagroup "${port1}" "${ag1}"
+	_remove_nvmet_port "${port1}"
+	_remove_nvmet_anagroup "${port2}" "${ag2}"
+	_remove_nvmet_port "${port2}"
+
+	losetup -d "$loop_dev"
+	rm "$TMPDIR/img"
+
+	_nvme_fcloop_del_rport "${host_wwnn1}" "${host_wwpn1}" \
+		"${remote_wwnn1}" "${remote_wwpn1}"
+	_nvme_fcloop_del_rport "${host_wwnn2}" "${host_wwpn2}" \
+		"${remote_wwnn2}" "${remote_wwpn2}"
+
+	_nvme_fcloop_del_tport "${remote_wwnn1}" "${remote_wwpn1}"
+	_nvme_fcloop_del_tport "${remote_wwnn2}" "${remote_wwpn2}"
+
+	_nvme_fcloop_del_lport "${host_wwnn1}" "${host_wwpn1}"
+	_nvme_fcloop_del_lport "${host_wwnn2}" "${host_wwpn2}"
+
+	modprobe -r nvme-fcloop
+	modprobe -r nvmet-fc
+	modprobe -r nvmet
+	modprobe -r loop
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/029.out b/tests/nvme/029.out
new file mode 100644
index 0000000..745f142
--- /dev/null
+++ b/tests/nvme/029.out
@@ -0,0 +1,2 @@
+Running nvme/029
+Test complete
diff --git a/tests/nvme/rc b/tests/nvme/rc
index aaf438b..3b3d852 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -201,3 +201,55 @@ _find_nvme_ns() {
 		fi
 	done
 }
+
+_nvme_fcloop_add_rport() {
+	local local_wwnn="$1"
+	local local_wwpn="$2"
+	local remote_wwnn="$3"
+	local remote_wwpn="$4"
+	local loopctl=/sys/class/fcloop/ctl
+
+	echo "wwnn=${remote_wwnn},wwpn=${remote_wwpn},lpwwnn=${local_wwnn},lpwwpn=${local_wwpn},roles=0x60" > ${loopctl}/add_remote_port
+}
+
+_nvme_fcloop_del_rport() {
+	local local_wwnn="$1"
+	local local_wwpn="$2"
+	local remote_wwnn="$3"
+	local remote_wwpn="$4"
+	local loopctl=/sys/class/fcloop/ctl
+
+	echo "wwnn=${remote_wwnn},wwpn=${remote_wwpn}" > ${loopctl}/del_remote_port
+}
+
+_nvme_fcloop_add_lport() {
+	local wwnn="$1"
+	local wwpn="$2"
+	local loopctl=/sys/class/fcloop/ctl
+
+	echo "wwnn=${wwnn},wwpn=${wwpn}" > ${loopctl}/add_local_port
+}
+
+_nvme_fcloop_del_lport() {
+	local wwnn="$1"
+	local wwpn="$2"
+	local loopctl=/sys/class/fcloop/ctl
+
+	echo "wwnn=${wwnn},wwpn=${wwpn}" > ${loopctl}/del_local_port
+}
+
+_nvme_fcloop_add_tport() {
+	local wwnn="$1"
+	local wwpn="$2"
+	local loopctl=/sys/class/fcloop/ctl
+
+	echo "wwnn=${wwnn},wwpn=${wwpn}" > ${loopctl}/add_target_port
+}
+
+_nvme_fcloop_del_tport() {
+	local wwnn="$1"
+	local wwpn="$2"
+	local loopctl=/sys/class/fcloop/ctl
+
+	echo "wwnn=${wwnn},wwpn=${wwpn}" > ${loopctl}/del_target_port
+}
-- 
2.13.7
