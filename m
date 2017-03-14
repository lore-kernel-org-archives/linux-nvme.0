From: yizhan@redhat.com (Yi Zhang)
Date: Tue, 14 Mar 2017 09:40:27 -0400 (EDT)
Subject: [PATCH v2] nvmet-rdma: Fix a possible uninitialized variable
 dereference
In-Reply-To: <1489412381-28947-1-git-send-email-sagi@grimberg.me>
References: <1489412381-28947-1-git-send-email-sagi@grimberg.me>
Message-ID: <1898652754.2479312.1489498827670.JavaMail.zimbra@redhat.com>

Thanks Sagi

Tested-by: Yi Zhang <yizhan at redhat.com>


Best Regards,
  Yi Zhang


----- Original Message -----
From: "Sagi Grimberg" <sagi@grimberg.me>
To: linux-nvme at lists.infradead.org, linux-rdma at vger.kernel.org
Cc: "Christoph Hellwig" <hch at lst.de>
Sent: Monday, March 13, 2017 9:39:41 PM
Subject: [PATCH v2] nvmet-rdma: Fix a possible uninitialized variable dereference

When handling a new recv command, we grab a new rsp resource and
check for the queue state being live. In case the queue is not in
live state, we simply restore the rsp back to the free list. However
in this flow we didn't set rsp->queue yet, so we cannot dereference it.

Instead, make sure to initialize rsp->queue (and other rsp members)
as soon as possible so we won't reference uninitialized variables.

Reported-by: Yi Zhang <yizhan at redhat.com>
Reported-by: Raju Rangoju <rajur at chelsio.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
- v1 broke srq, this one doesn't

 drivers/nvme/target/rdma.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 9aa1da3778b3..ecc4fe862561 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -703,11 +703,6 @@ static void nvmet_rdma_handle_command(struct nvmet_rdma_queue *queue,
 {
 	u16 status;
 
-	cmd->queue = queue;
-	cmd->n_rdma = 0;
-	cmd->req.port = queue->port;
-
-
 	ib_dma_sync_single_for_cpu(queue->dev->device,
 		cmd->cmd->sge[0].addr, cmd->cmd->sge[0].length,
 		DMA_FROM_DEVICE);
@@ -760,9 +755,12 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 
 	cmd->queue = queue;
 	rsp = nvmet_rdma_get_rsp(queue);
+	rsp->queue = queue;
 	rsp->cmd = cmd;
 	rsp->flags = 0;
 	rsp->req.cmd = cmd->nvme_cmd;
+	rsp->req.port = queue->port;
+	rsp->n_rdma = 0;
 
 	if (unlikely(queue->state != NVMET_RDMA_Q_LIVE)) {
 		unsigned long flags;
-- 
2.7.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
