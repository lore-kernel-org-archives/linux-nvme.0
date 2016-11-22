From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 22 Nov 2016 16:36:31 +0200
Subject: [PATCH v2 2/2] nvme-rdma: align to generic ib_event logging helper
In-Reply-To: <1479825391-10389-1-git-send-email-maxg@mellanox.com>
References: <1479825391-10389-1-git-send-email-maxg@mellanox.com>
Message-ID: <1479825391-10389-3-git-send-email-maxg@mellanox.com>

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 3d25add..9c34da5 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -241,7 +241,9 @@ static void nvme_rdma_free_ring(struct ib_device *ibdev,
 
 static void nvme_rdma_qp_event(struct ib_event *event, void *context)
 {
-	pr_debug("QP event %d\n", event->event);
+	pr_debug("QP event %s (%d)\n",
+		 ib_event_msg(event->event), event->event);
+
 }
 
 static int nvme_rdma_wait_for_cm(struct nvme_rdma_queue *queue)
-- 
1.7.1
