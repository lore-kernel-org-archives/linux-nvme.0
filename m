From: hare@suse.de (Hannes Reinecke)
Date: Mon, 15 Oct 2018 09:01:28 +0200
Subject: [PATCH 1/3] nvme: enable ANA support
In-Reply-To: <20181015070130.6695-1-hare@suse.de>
References: <20181015070130.6695-1-hare@suse.de>
Message-ID: <20181015070130.6695-2-hare@suse.de>

Update functions to support ANA.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 tests/nvme/rc | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 86 insertions(+), 3 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index eff1dd9..aaf438b 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -14,7 +14,7 @@ group_device_requires() {
 	_test_dev_is_nvme
 }
 
-NVMET_CFS="/sys/kernel/config/nvmet/"
+NVMET_CFS="/sys/kernel/config/nvmet"
 
 _test_dev_is_nvme() {
 	if ! readlink -f "$TEST_DEV_SYSFS/device" | grep -q nvme; then
@@ -36,6 +36,7 @@ _create_nvmet_port() {
 
 	mkdir "${NVMET_CFS}/ports/${port}"
 	echo "${trtype}" > "${NVMET_CFS}/ports/${port}/addr_trtype"
+	echo "${port}" > "${NVMET_CFS}/ports/${port}/addr_traddr"
 
 	echo "${port}"
 }
@@ -45,6 +46,62 @@ _remove_nvmet_port() {
 	rmdir "${NVMET_CFS}/ports/${port}"
 }
 
+_create_nvmet_anagroup() {
+	local port="$1"
+	local port_cfs="${NVMET_CFS}/ports/${port}"
+	local grpid
+
+	for ((grpid = 1; ; grpid++)); do
+		if [[ ! -e "${port_cfs}/ana_groups/${grpid}" ]]; then
+			break
+		fi
+	done
+
+	mkdir "${port_cfs}/ana_groups/${grpid}"
+
+	echo "${grpid}"
+}
+
+_remove_nvmet_anagroup() {
+	local port="$1"
+	local grpid="$2"
+	local ana_cfs="${NVMET_CFS}/ports/${port}/ana_groups/${grpid}"
+
+	rmdir "${ana_cfs}"
+}
+
+_set_nvmet_anagroup_state() {
+	local port="$1"
+	local grpid="$2"
+	local state="$3"
+	local ana_cfs="${NVMET_CFS}/ports/${port}/ana_groups/${grpid}"
+
+	echo "${state}" > "${ana_cfs}/ana_state"
+}
+
+_display_ana_state() {
+	local nvmet_subsystem="$1"
+	local grpid state cntlid
+
+	for nvme in /sys/class/nvme/* ; do
+		[ -f ${nvme}/subsysnqn ] || continue
+		subsys="$(cat "${nvme}/subsysnqn")"
+		if [ "${subsys}" != "${nvmet_subsystem}" ] ; then
+			continue
+		fi
+		cntlid="$(cat "${nvme}/cntlid")"
+		for c in ${nvme}/nvme* ; do
+			if [ ! -d ${c} ] ; then
+				echo "${cntlid}: ANA disabled"
+				continue
+			fi
+			grpid="$(cat "${c}/ana_grpid")"
+			state="$(cat "${c}/ana_state")"
+			echo "${cntlid}: grpid ${grpid} state ${state}"
+		done
+	done
+}
+
 _create_nvmet_ns() {
 	local nvmet_subsystem="$1"
 	local nsid="$2"
@@ -52,14 +109,22 @@ _create_nvmet_ns() {
 	local uuid="00000000-0000-0000-0000-000000000000"
 	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
 	local ns_path="${subsys_path}/namespaces/${nsid}"
+	local ana_grpid
 
-	if [[ $# -eq 4 ]]; then
+	if [[ $# -ge 4 ]]; then
 		uuid="$4"
 	fi
 
+	if [[ $# -eq 5 ]]; then
+		ana_grpid="$5"
+	fi
+
 	mkdir "${ns_path}"
 	printf "%s" "${blkdev}" > "${ns_path}/device_path"
 	printf "%s" "${uuid}" > "${ns_path}/device_uuid"
+	if [ -n "${ana_grpid}" ] ; then
+		printf "%s" "${ana_grpid}" > "${ns_path}/ana_grpid"
+	fi
 	printf 1 > "${ns_path}/enable"
 }
 
@@ -67,11 +132,12 @@ _create_nvmet_subsystem() {
 	local nvmet_subsystem="$1"
 	local blkdev="$2"
 	local uuid=$3
+	local ana_grpid=$4
 	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
 
 	mkdir -p "${cfs_path}"
 	echo 1 > "${cfs_path}/attr_allow_any_host"
-	_create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
+	_create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}" "${ana_grpid}"
 }
 
 _remove_nvmet_ns() {
@@ -115,6 +181,23 @@ _find_nvme_loop_dev() {
 		transport="$(cat "/sys/class/nvme/${dev}/transport")"
 		if [[ "$transport" == "loop" ]]; then
 			echo "$dev"
+			break
+		fi
+	done
+}
+
+_find_nvme_ns() {
+	local uuid=$1
+	local dev
+	local hidden
+
+	for dev in /sys/block/nvme*; do
+		hidden="$(cat "${dev}/hidden")"
+		[[ "$hidden" -eq 1 ]] && continue
+		u="$(cat "${dev}/uuid")"
+		if [[ "$uuid" = "$u" ]] ; then
+			echo "$(basename "${dev}")"
+			break
 		fi
 	done
 }
-- 
2.13.7
