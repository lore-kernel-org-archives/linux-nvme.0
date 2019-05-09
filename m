From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Fri, 10 May 2019 00:43:17 +0900
Subject: [PATCH] nvme-cli: cleanup comments for telemetry log structure
Message-ID: <1557416597-21777-1-git-send-email-akinobu.mita@gmail.com>

This removes three comments for struct nvme_telemetry_log_page_hdr.

- The comment on top of the definision doesn't describe more than the
  struct name itself.

- The rsvd1 field has already been verified.

- The structures with trailing zero size array are commonly used in
  nvme-cli, so we don't need special comment for telemetry_dataarea[0].

Cc: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Kenneth Heitke <kenneth.heitke at intel.com>
Suggested-by: Kenneth Heitke <kenneth.heitke at intel.com>
Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
---
 linux/nvme.h | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/linux/nvme.h b/linux/nvme.h
index f6d7341..2c840b9 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -426,9 +426,6 @@ struct nvme_id_nvmset {
 	struct nvme_nvmset_attr_entry	ent[NVME_MAX_NVMSET];
 };
 
-/* Derived from 1.3a Figure 101: Get Log Page ? Telemetry Host
- * -Initiated Log (Log Identifier 07h)
- */
 struct nvme_telemetry_log_page_hdr {
 	__u8    lpi; /* Log page identifier */
 	__u8    rsvd[4];
@@ -436,15 +433,10 @@ struct nvme_telemetry_log_page_hdr {
 	__le16  dalb1; /* Data area 1 last block */
 	__le16  dalb2; /* Data area 2 last block */
 	__le16  dalb3; /* Data area 3 last block */
-	__u8    rsvd1[368]; /* TODO verify */
+	__u8    rsvd1[368];
 	__u8    ctrlavail; /* Controller initiated data avail?*/
 	__u8    ctrldgn; /* Controller initiated telemetry Data Gen # */
 	__u8    rsnident[128];
-	/* We'll have to double fetch so we can get the header,
-	 * parse dalb1->3 determine how much size we need for the
-	 * log then alloc below. Or just do a secondary non-struct
-	 * allocation.
-	 */
 	__u8    telemetry_dataarea[0];
 };
 
-- 
2.7.4
