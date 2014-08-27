From: keith.busch@intel.com (Keith Busch)
Date: Wed, 27 Aug 2014 13:55:39 -0600
Subject: [PATCH 2/2] NVMe: Fix SG_IO status values
In-Reply-To: <1409169339-9821-1-git-send-email-keith.busch@intel.com>
References: <1409169339-9821-1-git-send-email-keith.busch@intel.com>
Message-ID: <1409169339-9821-2-git-send-email-keith.busch@intel.com>

We've only been setting the sg_io_hdr status values on SCSI commands
that require an nvme command to complete the translation. The fields
in the struct are output parameters, so we have to set them, otherwise
user space will see whatever was in memory from before. In the case of
compat SG_IO, this would reveal kernel memory. This fixes the issue by
initializing the sg_io_hdr with successful status.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-scsi.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index dabafa6a..046ae33 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -2915,6 +2915,14 @@ static int nvme_scsi_translate(struct nvme_ns *ns, struct sg_io_hdr *hdr)
 	if (copy_from_user(cmd, hdr->cmdp, hdr->cmd_len))
 		return -EFAULT;
 
+	/*
+	 * Prime the hdr with good status for scsi commands that don't require
+	 * an nvme command for translation.
+	 */
+	retcode = nvme_trans_status_code(hdr, NVME_SC_SUCCESS);
+	if (retcode)
+		return retcode;
+
 	opcode = cmd[0];
 
 	switch (opcode) {
-- 
1.7.10.4
