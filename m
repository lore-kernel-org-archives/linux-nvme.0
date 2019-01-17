From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 17 Jan 2019 13:59:05 +0100
Subject: [PATCH blktests 1/2] nvme: enable buffered_io for file-backed
 namespaces
Message-ID: <20190117125906.15479-1-jthumshirn@suse.de>

All file-based NVMe over Fabrics tests fail in my test environment as I'm
running these tests form within an initramfs. It turns out the file backing
store of the NVMe target defaults to using direct I/O which is not
available on tmpfs for obvious reasons.

If the backing store of an nvme target is file-based enable the use of
buffered I/O.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 tests/nvme/rc | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index eff1dd992460..ec92e41396be 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -48,7 +48,7 @@ _remove_nvmet_port() {
 _create_nvmet_ns() {
 	local nvmet_subsystem="$1"
 	local nsid="$2"
-	local blkdev="$3"
+	local backstore="$3"
 	local uuid="00000000-0000-0000-0000-000000000000"
 	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
 	local ns_path="${subsys_path}/namespaces/${nsid}"
@@ -58,8 +58,11 @@ _create_nvmet_ns() {
 	fi
 
 	mkdir "${ns_path}"
-	printf "%s" "${blkdev}" > "${ns_path}/device_path"
+	printf "%s" "${backstore}" > "${ns_path}/device_path"
 	printf "%s" "${uuid}" > "${ns_path}/device_uuid"
+	if [[ -f ${backstore} ]]; then
+		printf 1 > "${ns_path}/buffered_io"
+	fi
 	printf 1 > "${ns_path}/enable"
 }
 
-- 
2.16.4
