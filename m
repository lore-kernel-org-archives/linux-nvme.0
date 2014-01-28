From: agordeev@redhat.com (Alexander Gordeev)
Date: Tue, 28 Jan 2014 09:38:49 +0100
Subject: [PATCH 03/14] NVMe: Cleanup nvme_create_queue() and
 nvme_disable_queue()
In-Reply-To: <cover.1390897693.git.agordeev@redhat.com>
References: <cover.1390897693.git.agordeev@redhat.com>
Message-ID: <7960acc850c15928afe22bd093c100a5dd10880f.1390897693.git.agordeev@redhat.com>

A queue structure contains both a pointer to the device it
belongs to and the queue ID - there is no need to drag these
parameters around.

Signed-off-by: Alexander Gordeev <agordeev at redhat.com>
---
 drivers/block/nvme-core.c |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 60c6c05..606a2e1 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1197,9 +1197,10 @@ static void nvme_clear_queue(struct nvme_queue *nvmeq)
 	spin_unlock_irq(&nvmeq->q_lock);
 }
 
-static void nvme_disable_queue(struct nvme_dev *dev, int qid)
+static void nvme_disable_queue(struct nvme_queue *nvmeq)
 {
-	struct nvme_queue *nvmeq = dev->queues[qid];
+	struct nvme_dev *dev = nvmeq->dev;
+	int qid = nvmeq->qid;
 
 	if (!nvmeq)
 		return;
@@ -1288,9 +1289,10 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	nvmeq->q_suspended = 0;
 }
 
-static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
+static int nvme_create_queue(struct nvme_queue *nvmeq)
 {
 	struct nvme_dev *dev = nvmeq->dev;
+	int qid = nvmeq->qid;
 	int result;
 
 	result = adapter_alloc_cq(dev, qid, nvmeq);
@@ -1974,10 +1976,10 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	}
 
 	for (i = 1; i < dev->queue_count; i++) {
-		result = nvme_create_queue(dev->queues[i], i);
+		result = nvme_create_queue(dev->queues[i]);
 		if (result) {
 			for (--i; i > 0; i--)
-				nvme_disable_queue(dev, i);
+				nvme_disable_queue(dev->queues[i]);
 			goto free_queues;
 		}
 	}
@@ -2140,7 +2142,7 @@ static void nvme_wait_dq(struct nvme_delq_ctx *dq, struct nvme_dev *dev)
 			set_current_state(TASK_RUNNING);
 
 			nvme_disable_ctrl(dev, readq(&dev->bar->cap));
-			nvme_disable_queue(dev, 0);
+			nvme_disable_queue(dev->queues[0]);
 
 			send_sig(SIGKILL, dq->worker->task, 1);
 			flush_kthread_worker(dq->worker);
@@ -2236,7 +2238,7 @@ static void nvme_disable_io_queues(struct nvme_dev *dev)
 		dev_err(&dev->pci_dev->dev,
 			"Failed to create queue del task\n");
 		for (i = dev->queue_count - 1; i > 0; i--)
-			nvme_disable_queue(dev, i);
+			nvme_disable_queue(dev->queues[i]);
 		return;
 	}
 
@@ -2276,7 +2278,7 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 	} else {
 		nvme_disable_io_queues(dev);
 		nvme_shutdown_ctrl(dev);
-		nvme_disable_queue(dev, 0);
+		nvme_disable_queue(dev->queues[0]);
 	}
 	nvme_dev_unmap(dev);
 }
@@ -2411,7 +2413,7 @@ static int nvme_dev_start(struct nvme_dev *dev)
 	return result;
 
  disable:
-	nvme_disable_queue(dev, 0);
+	nvme_disable_queue(dev->queues[0]);
 	spin_lock(&dev_list_lock);
 	list_del_init(&dev->node);
 	spin_unlock(&dev_list_lock);
-- 
1.7.7.6
