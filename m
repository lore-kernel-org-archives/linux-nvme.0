From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 23 May 2018 23:43:14 -0400
Subject: [PATCH] blktests: nvme add ns add and remove routines
Message-ID: <20180524034314.8801-1-chaitanya.kulkarni@wdc.com>

This patch adds ns creation/deletion routines which can which can be
used to create and delete namespaces independently. Also, this avoids
hardcoding the namespace id when creating ns.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 common/nvme | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/common/nvme b/common/nvme
index 5d7d89c..d44b280 100644
--- a/common/nvme
+++ b/common/nvme
@@ -48,6 +48,15 @@ _remove_nvmet_port() {
 	rmdir "${NVMET_CFS}/ports/${port}"
 }
 
+_create_nvmet_ns() {
+	local nvmet_ns_path="$1"
+
+	mkdir "${nvmet_ns_path}"
+	printf "%s" "$blkdev" > "${nvmet_ns_path}/device_path"
+	printf "%s" "$uuid" > "${nvmet_ns_path}/device_uuid"
+	printf 1 > "${nvmet_ns_path}/enable"
+}
+
 _create_nvmet_subsystem() {
 	local nvmet_subsystem="$1"
 	local blkdev="$2"
@@ -60,18 +69,21 @@ _create_nvmet_subsystem() {
 
 	mkdir -p "${cfs_path}"
 	echo 1 > "${cfs_path}/attr_allow_any_host"
-	mkdir "${cfs_path}/namespaces/1"
-	printf "%s" "$blkdev" > "${cfs_path}/namespaces/1/device_path"
-	printf "%s" "$uuid" > "${cfs_path}/namespaces/1/device_uuid"
-	printf 1 > "${cfs_path}/namespaces/1/enable"
+	_create_nvmet_ns "${cfs_path}/namespaces/1/"
+}
+
+_remove_nvmet_ns() {
+	local nvmet_ns_path="$1"
+
+	echo 0 > "${nvmet_ns_path}/enable"
+	rmdir "${nvmet_ns_path}/"
 }
 
 _remove_nvmet_subsystem() {
 	local nvmet_subsystem="$1"
 	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
 
-	echo 0 > "${cfs_path}/namespaces/1/enable"
-	rmdir "${cfs_path}/namespaces/1/"
+	_remove_nvmet_ns "${cfs_path}/namespaces/1/"
 	rmdir "${cfs_path}"
 }
 
-- 
2.9.5
