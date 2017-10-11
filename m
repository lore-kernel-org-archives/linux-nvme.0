From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 11 Oct 2017 15:29:12 +0300
Subject: [PATCH 7/7] nvme-rdma: change queue flag semantics DELETING ->
 ALLOCATED
In-Reply-To: <1507724952-13917-1-git-send-email-sagi@grimberg.me>
References: <1507724952-13917-1-git-send-email-sagi@grimberg.me>
Message-ID: <1507724952-13917-8-git-send-email-sagi@grimberg.me>

Instead of marking we are deleting, mark we
are allocated and check that instead. This makes
the logic symmetrical to connected mark check.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2a18465bf361..405895b1dff2 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -79,8 +79,8 @@ struct nvme_rdma_request {
 };
 
 enum nvme_rdma_queue_flags {
-	NVME_RDMA_Q_LIVE		= 0,
-	NVME_RDMA_Q_DELETING		= 1,
+	NVME_RDMA_Q_ALLOCATED		= 0,
+	NVME_RDMA_Q_LIVE		= 1,
 };
 
 struct nvme_rdma_queue {
@@ -549,7 +549,7 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
 		goto out_destroy_cm_id;
 	}
 
-	clear_bit(NVME_RDMA_Q_DELETING, &queue->flags);
+	set_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags);
 
 	return 0;
 
@@ -569,7 +569,7 @@ static void nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
 
 static void nvme_rdma_free_queue(struct nvme_rdma_queue *queue)
 {
-	if (test_and_set_bit(NVME_RDMA_Q_DELETING, &queue->flags))
+	if (!test_and_clear_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
 		return;
 
 	nvme_rdma_destroy_queue_ib(queue);
-- 
2.7.4
