From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 21 Nov 2016 22:45:44 +0200
Subject: [PATCH 1/2] nvmet-rdma: align to generic ib_event logging helper
Message-ID: <1479761145-13264-1-git-send-email-maxg@mellanox.com>

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/target/rdma.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 005ef5d..80650e2 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1124,12 +1124,14 @@ static void nvmet_rdma_qp_event(struct ib_event *event, void *priv)
 {
 	struct nvmet_rdma_queue *queue = priv;
 
+	pr_err("received IB QP event: %s (%d)\n",
+	       ib_event_msg(event->event), event->event);
+
 	switch (event->event) {
 	case IB_EVENT_COMM_EST:
 		rdma_notify(queue->cm_id, event->event);
 		break;
 	default:
-		pr_err("received unrecognized IB QP event %d\n", event->event);
 		break;
 	}
 }
-- 
1.7.1
