From: wyung@micron.com (Winson Yung (wyung))
Date: Mon, 26 May 2014 13:04:55 -0700
Subject: [PATCH] NVMe: Add support to receive NVMe asynchronous events
Message-ID: <53839E67.1010006@micron.com>

As a NVMe mandatory admin command, this driver should be setup so
that it can receive drive critical asynchronous notification for
issue such as device reliability, temperature above threshold, or
available spare space fallen below threshould. This patch enables
very basic mechanism to log the asynchronous events in kernel log.

Signed-off-by: Winson Yung <wyung at micron.com>
---
 drivers/block/nvme-core.c |   57 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index cd8a8bc7..4cd9f8e 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -198,6 +198,7 @@ static int alloc_cmdid_killable(struct nvme_queue *nvmeq, void *ctx,
 #define CMD_CTX_COMPLETED	(0x310 + CMD_CTX_BASE)
 #define CMD_CTX_INVALID		(0x314 + CMD_CTX_BASE)
 #define CMD_CTX_ABORT		(0x318 + CMD_CTX_BASE)
+#define CMD_CTX_ASYNC_EVENT	(0x319 + CMD_CTX_BASE)
 
 static void special_completion(struct nvme_queue *nvmeq, void *ctx,
 						struct nvme_completion *cqe)
@@ -227,7 +228,27 @@ static void special_completion(struct nvme_queue *nvmeq, void *ctx,
 static void async_completion(struct nvme_queue *nvmeq, void *ctx,
 						struct nvme_completion *cqe)
 {
+	int cmdid;
+	struct nvme_queue *adminq;
+	struct nvme_dev *dev = nvmeq->dev;
 	struct async_cmd_info *cmdinfo = ctx;
+
+	if (ctx == CMD_CTX_ASYNC_EVENT) {
+		dev_warn(nvmeq->q_dmadev, "An async event is detected (DW0:%X)\n",
+								cqe->result);
+
+		adminq = rcu_dereference(dev->queues[0]);
+
+		/* Allocate a cmdid entry for next async event */
+		cmdid = alloc_cmdid(adminq, CMD_CTX_ASYNC_EVENT,
+						async_completion, 0);
+		if (cmdid < 0)
+			dev_warn(nvmeq->q_dmadev,
+				"Failure creating new entry for next async event\n");
+
+		return; /* Report asynchronous critical event, and exit */
+	}
+
 	cmdinfo->result = le32_to_cpup(&cqe->result);
 	cmdinfo->status = le16_to_cpup(&cqe->status) >> 1;
 	queue_kthread_work(cmdinfo->worker, &cmdinfo->work);
@@ -2381,6 +2402,37 @@ static int nvme_delete_cq(struct nvme_queue *nvmeq)
 						nvme_del_cq_work_handler);
 }
 
+static int nvme_enable_async_events(struct nvme_dev *dev)
+{
+	int status, cmdid;
+	u32 result, async_events;
+	struct nvme_queue *adminq;
+
+	async_events = NVME_SMART_CRIT_SPARE |
+			NVME_SMART_CRIT_TEMPERATURE |
+			NVME_SMART_CRIT_RELIABILITY |
+			NVME_SMART_CRIT_MEDIA |
+			NVME_SMART_CRIT_VOLATILE_MEMORY;
+
+	status = nvme_set_features(dev, NVME_FEAT_ASYNC_EVENT,
+					async_events, 0, &result);
+
+	if (status < 0)
+		return status;
+
+	if (status > 0) {
+		dev_err(&dev->pci_dev->dev, "Could not enable async event (%d)\n",
+									status);
+		return -EBUSY;
+	}
+
+	adminq = rcu_dereference(dev->queues[0]);
+
+	/* Allocate a cmdid entry in preparation of next incoming async event */
+	cmdid = alloc_cmdid(adminq, CMD_CTX_ASYNC_EVENT, async_completion, 0);
+	return cmdid;
+}
+
 static void nvme_del_sq_work_handler(struct kthread_work *work)
 {
 	struct nvme_queue *nvmeq = container_of(work, struct nvme_queue,
@@ -2638,6 +2690,11 @@ static int nvme_dev_start(struct nvme_dev *dev)
 		goto disable;
 	}
 
+	/* Enable receive asynchronous event */
+	result = nvme_enable_async_events(dev);
+	if (result < 0 && result != -EBUSY)
+		goto disable;
+
 	result = nvme_setup_io_queues(dev);
 	if (result && result != -EBUSY)
 		goto disable;
-- 
1.7.9.5
