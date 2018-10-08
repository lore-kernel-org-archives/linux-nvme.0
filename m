From: bvanassche@acm.org (Bart Van Assche)
Date: Mon,  8 Oct 2018 14:28:54 -0700
Subject: [PATCH 16/16] nvmet-rdma: Check for timeout in nvme_rdma_wait_for_cm()
In-Reply-To: <20181008212854.68310-1-bvanassche@acm.org>
References: <20181008212854.68310-1-bvanassche@acm.org>
Message-ID: <20181008212854.68310-17-bvanassche@acm.org>

Check whether queue->cm_error holds a value before reading it. This patch
addresses Coverity ID 1373774: unchecked return value.

Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 drivers/nvme/host/rdma.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index dc042017c293..e7be903041a8 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -233,8 +233,15 @@ static void nvme_rdma_qp_event(struct ib_event *event, void *context)
 
 static int nvme_rdma_wait_for_cm(struct nvme_rdma_queue *queue)
 {
-	wait_for_completion_interruptible_timeout(&queue->cm_done,
+	int ret;
+
+	ret = wait_for_completion_interruptible_timeout(&queue->cm_done,
 			msecs_to_jiffies(NVME_RDMA_CONNECT_TIMEOUT_MS) + 1);
+	if (ret < 0)
+		return ret;
+	if (ret == 0)
+		return -ETIMEDOUT;
+	WARN_ON_ONCE(queue->cm_error > 0);
 	return queue->cm_error;
 }
 
-- 
2.19.0.605.g01d371f741-goog
