From: dmilburn@redhat.com (David Milburn)
Date: Tue, 13 Jun 2017 16:36:50 -0500
Subject: [PATCH] nvme: submit nvme_admin_activate_fw to admin queue
Message-ID: <1497389810-19303-1-git-send-email-dmilburn@redhat.com>

The nvme_admin_activate_fw command should be submitted to
the admin queue; otherwise, mode 0x0F (ACTIVATE_DEFERRED_MICROCODE)
and mode 0x05 (DOWNLOAD_SAVE_ACTIVATE) will fail.

Fixes: b90c48d0c11ef("nvme: split nvme_trans_send_fw_cmd")
Reported-by: Joseph Szczypek <joseph.szczypek at hpe.com>
Tested-by: Micah Parrish <micah.parrish at hpe.com>
Signed-off-by: David Milburn <dmilburn at redhat.com>
---
 drivers/nvme/host/scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/scsi.c b/drivers/nvme/host/scsi.c
index 1f7671e..f4395e6 100644
--- a/drivers/nvme/host/scsi.c
+++ b/drivers/nvme/host/scsi.c
@@ -1231,7 +1231,7 @@ static int nvme_trans_send_activate_fw_cmd(struct nvme_ns *ns, struct sg_io_hdr
 	c.common.opcode = nvme_admin_activate_fw;
 	c.common.cdw10[0] = cpu_to_le32(buffer_id | NVME_FWACT_REPL_ACTV);
 
-	nvme_sc = nvme_submit_sync_cmd(ns->queue, &c, NULL, 0);
+	nvme_sc = nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, NULL, 0);
 	return nvme_trans_status_code(hdr, nvme_sc);
 }
 
-- 
1.8.3.1
