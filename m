From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 11 Oct 2017 15:29:08 +0300
Subject: [PATCH 3/7] nvme-rdma: move assignment to declaration
In-Reply-To: <1507724952-13917-1-git-send-email-sagi@grimberg.me>
References: <1507724952-13917-1-git-send-email-sagi@grimberg.me>
Message-ID: <1507724952-13917-4-git-send-email-sagi@grimberg.me>

No need for the extra line for trivial assignments.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 09f774abe5a8..6e62657662fd 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -434,11 +434,9 @@ nvme_rdma_find_get_device(struct rdma_cm_id *cm_id)
 
 static void nvme_rdma_destroy_queue_ib(struct nvme_rdma_queue *queue)
 {
-	struct nvme_rdma_device *dev;
-	struct ib_device *ibdev;
+	struct nvme_rdma_device *dev = queue->device;
+	struct ib_device *ibdev = dev->dev;
 
-	dev = queue->device;
-	ibdev = dev->dev;
 	rdma_destroy_qp(queue->cm_id);
 	ib_free_cq(queue->ib_cq);
 
-- 
2.7.4
