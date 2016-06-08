From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Wed,  8 Jun 2016 09:19:24 +0900
Subject: [PATCH] nvme: add missing error returns in format unit scsi
 translation
Message-ID: <1465345164-4481-1-git-send-email-akinobu.mita@gmail.com>

The Format Unit SCSI command emulation attempts to do sanity checks for
the block size and number before issuing the Format NVM NVMe command.
But the sanity checks lack the actual error return statements and the
conditions have been ignored.

Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
Cc: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at fb.com>
---
 drivers/nvme/host/scsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/scsi.c b/drivers/nvme/host/scsi.c
index e947e29..e95ab2b9 100644
--- a/drivers/nvme/host/scsi.c
+++ b/drivers/nvme/host/scsi.c
@@ -1619,11 +1619,13 @@ static int nvme_trans_fmt_send_cmd(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 		res = nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
 				ILLEGAL_REQUEST, SCSI_ASC_INVALID_PARAMETER,
 				SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
+		goto out;
 	}
 	if (ns->mode_select_num_blocks != le64_to_cpu(id_ns->ncap)) {
 		res = nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
 				ILLEGAL_REQUEST, SCSI_ASC_INVALID_PARAMETER,
 				SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
+		goto out;
 	}
 
 	cdw10 |= prot_info << 5;
@@ -1635,7 +1637,7 @@ static int nvme_trans_fmt_send_cmd(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 
 	nvme_sc = nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, NULL, 0);
 	res = nvme_trans_status_code(hdr, nvme_sc);
-
+out:
 	kfree(id_ns);
 	return res;
 }
-- 
2.7.4
