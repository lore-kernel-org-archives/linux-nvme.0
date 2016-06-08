From: hch@lst.de (Christoph Hellwig)
Date: Wed,  8 Jun 2016 14:31:01 +0200
Subject: [PATCH 06/11] nvme-rdma: set SGL flag on AER
In-Reply-To: <1465389066-19119-1-git-send-email-hch@lst.de>
References: <1465389066-19119-1-git-send-email-hch@lst.de>
Message-ID: <1465389066-19119-7-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/rdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index e938ab6..d8574f4 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1105,6 +1105,7 @@ static void nvme_rdma_submit_async_event(struct nvme_ctrl *arg, int aer_idx)
 	memset(cmd, 0, sizeof(*cmd));
 	cmd->common.opcode = nvme_admin_async_event;
 	cmd->common.command_id = NVME_RDMA_AQ_BLKMQ_DEPTH;
+	cmd->common.flags |= NVME_CMD_SGL_METABUF;
 	nvme_rdma_set_sg_null(cmd);
 
 	ib_dma_sync_single_for_device(dev, sqe->dma, sizeof(*cmd),
-- 
2.1.4
