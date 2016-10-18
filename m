From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Tue, 18 Oct 2016 13:10:03 -0700
Subject: [PATCH 1/6] nvme/scsi: Remove set-but-not-used variables
In-Reply-To: <e96f7b21-9686-c24f-9c64-e6fb4b44fea0@sandisk.com>
References: <e96f7b21-9686-c24f-9c64-e6fb4b44fea0@sandisk.com>
Message-ID: <efa842ad-0cde-261f-a504-ec086fc11ab2@sandisk.com>

Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
---
 drivers/nvme/host/scsi.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/scsi.c b/drivers/nvme/host/scsi.c
index c2a0a1c7..0671fe0 100644
--- a/drivers/nvme/host/scsi.c
+++ b/drivers/nvme/host/scsi.c
@@ -1280,10 +1280,6 @@ static inline void nvme_trans_modesel_get_bd_len(u8 *parm_list, u8 cdb10,
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
@@ -1528,7 +1524,7 @@ static int nvme_trans_fmt_send_cmd(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	int nvme_sc;
 	struct nvme_id_ns *id_ns;
 	u8 i;
-	u8 flbas, nlbaf;
+	u8 nlbaf;
 	u8 selected_lbaf = 0xFF;
 	u32 cdw10 = 0;
 	struct nvme_command c;
@@ -1539,7 +1535,6 @@ static int nvme_trans_fmt_send_cmd(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	if (res)
 		return res;
 
-	flbas = (id_ns->flbas) & 0x0F;
 	nlbaf = id_ns->nlbaf;
 
 	for (i = 0; i < nlbaf; i++) {
@@ -2168,12 +2163,10 @@ static int nvme_trans_synchronize_cache(struct nvme_ns *ns,
 static int nvme_trans_start_stop(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 							u8 *cmd)
 {
-	u8 immed, pcmod, no_flush, start;
+	u8 immed, no_flush;
 
 	immed = cmd[1] & 0x01;
-	pcmod = cmd[3] & 0x0f;
 	no_flush = cmd[4] & 0x04;
-	start = cmd[4] & 0x01;
 
 	if (immed != 0) {
 		return nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
-- 
2.10.1
