From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 11 Jun 2018 05:15:41 -0400
Subject: [PATCH V2 01/14] blktests: common/nvme export ns-mgmt interfaces
In-Reply-To: <20180611091554.19639-1-chaitanya.kulkarni@wdc.com>
References: <20180611091554.19639-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180611091554.19639-2-chaitanya.kulkarni@wdc.com>

This patch modifies and exports the interfaces to create and delete ns
which can be consumed by future testcases like creation/deletion of ns.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 common/nvme | 46 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/common/nvme b/common/nvme
index 5d7d89c..044d7fe 100644
--- a/common/nvme
+++ b/common/nvme
@@ -48,31 +48,51 @@ _remove_nvmet_port() {
 	rmdir "${NVMET_CFS}/ports/${port}"
 }
 
-_create_nvmet_subsystem() {
+_create_nvmet_ns() {
 	local nvmet_subsystem="$1"
-	local blkdev="$2"
+	local nsid="$2"
+	local blkdev="$3"
 	local uuid="00000000-0000-0000-0000-000000000000"
-	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+	local ns_path="${subsys_path}/namespaces/${nsid}"
 
-	if [[ $# -eq 3 ]]; then
-		uuid="$3"
+	if [[ $# -eq 4 ]]; then
+		uuid="$4"
 	fi
 
+	mkdir "${ns_path}"
+	printf "%s" "${blkdev}" > "${ns_path}/device_path"
+	printf "%s" "${uuid}" > "${ns_path}/device_uuid"
+	printf 1 > "${ns_path}/enable"
+}
+
+_create_nvmet_subsystem() {
+	local nvmet_subsystem="$1"
+	local blkdev="$2"
+	local uuid=$3
+	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+
 	mkdir -p "${cfs_path}"
 	echo 1 > "${cfs_path}/attr_allow_any_host"
-	mkdir "${cfs_path}/namespaces/1"
-	printf "%s" "$blkdev" > "${cfs_path}/namespaces/1/device_path"
-	printf "%s" "$uuid" > "${cfs_path}/namespaces/1/device_uuid"
-	printf 1 > "${cfs_path}/namespaces/1/enable"
+	_create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
+}
+
+_remove_nvmet_ns() {
+	local nvmet_subsystem="$1"
+	local nsid=$2
+	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+	local nvmet_ns_path="${subsys_path}/namespaces/${nsid}"
+
+	echo 0 > "${nvmet_ns_path}/enable"
+	rmdir "${nvmet_ns_path}"
 }
 
 _remove_nvmet_subsystem() {
 	local nvmet_subsystem="$1"
-	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
 
-	echo 0 > "${cfs_path}/namespaces/1/enable"
-	rmdir "${cfs_path}/namespaces/1/"
-	rmdir "${cfs_path}"
+	_remove_nvmet_ns "${nvmet_subsystem}" "1"
+	rmdir "${subsys_path}"
 }
 
 _add_nvmet_subsys_to_port() {
-- 
2.17.0
