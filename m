From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Thu, 5 Jul 2018 08:14:00 -0500
Subject: [PATCH] nvme-rdma: mark expected switch fall-through
Message-ID: <20180705131400.GA4076@embeddedor.com>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo at embeddedor.com>
---
 drivers/nvme/host/rdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 518c5b0..9935234 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1574,6 +1574,7 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	case RDMA_CM_EVENT_CONNECT_ERROR:
 	case RDMA_CM_EVENT_UNREACHABLE:
 		nvme_rdma_destroy_queue_ib(queue);
+		/* fall through */
 	case RDMA_CM_EVENT_ADDR_ERROR:
 		dev_dbg(queue->ctrl->ctrl.device,
 			"CM error event %d\n", ev->event);
-- 
2.7.4
