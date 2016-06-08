From: hch@lst.de (Christoph Hellwig)
Date: Wed,  8 Jun 2016 14:31:00 +0200
Subject: [PATCH 05/11] nvme-loop: set SGL flag on AER
In-Reply-To: <1465389066-19119-1-git-send-email-hch@lst.de>
References: <1465389066-19119-1-git-send-email-hch@lst.de>
Message-ID: <1465389066-19119-6-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/target/loop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 08b4fbb..94e7829 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -209,6 +209,7 @@ static void nvme_loop_submit_async_event(struct nvme_ctrl *arg, int aer_idx)
 	memset(&iod->cmd, 0, sizeof(iod->cmd));
 	iod->cmd.common.opcode = nvme_admin_async_event;
 	iod->cmd.common.command_id = NVME_LOOP_AQ_BLKMQ_DEPTH;
+	iod->cmd.common.flags |= NVME_CMD_SGL_METABUF;
 
 	if (!nvmet_req_init(&iod->req, &queue->nvme_cq, &queue->nvme_sq,
 			&nvme_loop_ops)) {
-- 
2.1.4
