From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Mon, 20 Jun 2016 08:12:42 +0200
Subject: [PATCH 1/2] nvme: Remove set-but-not-used variables
In-Reply-To: <09e593eb-9787-cba6-ef35-cc6412fd20b4@sandisk.com>
References: <09e593eb-9787-cba6-ef35-cc6412fd20b4@sandisk.com>
Message-ID: <65f82565-0f6e-8414-7295-95975b66a876@sandisk.com>

Detected these variables by building with W=1.

Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagig at grimberg.me>
---
 drivers/nvme/host/scsi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/nvme/host/scsi.c b/drivers/nvme/host/scsi.c
index e947e29..0fd9707 100644
--- a/drivers/nvme/host/scsi.c
+++ b/drivers/nvme/host/scsi.c
@@ -1347,10 +1347,6 @@ static inline void nvme_trans_modesel_get_bd_len(u8 *parm_list, u8 cdb10,
 static void nvme_trans_modesel_save_bd(struct nvme_ns *ns, u8 *parm_list,
 					u16 idx, u16 bd_len, u8 llbaa)
 {
-	u16 bd_num;
-
-	bd_num = bd_len / ((llbaa == 0) ?
-			SHORT_DESC_BLOCK : LONG_DESC_BLOCK);
 	/* Store block descriptor info if a FORMAT UNIT comes later */
 	/* TODO Saving 1st BD info; what to do if multiple BD received? */
 	if (llbaa == 0) {
@@ -1595,7 +1591,7 @@ static int nvme_trans_fmt_send_cmd(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	int nvme_sc;
 	struct nvme_id_ns *id_ns;
 	u8 i;
-	u8 flbas, nlbaf;
+	u8 nlbaf;
 	u8 selected_lbaf = 0xFF;
 	u32 cdw10 = 0;
 	struct nvme_command c;
@@ -1606,7 +1602,6 @@ static int nvme_trans_fmt_send_cmd(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	if (res)
 		return res;
 
-	flbas = (id_ns->flbas) & 0x0F;
 	nlbaf = id_ns->nlbaf;
 
 	for (i = 0; i < nlbaf; i++) {
-- 
2.8.4
