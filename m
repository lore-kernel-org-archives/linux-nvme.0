From: keith.busch@intel.com (Keith Busch)
Date: Fri, 24 Mar 2017 16:49:42 -0400
Subject: [RFC PATCH] nvme: Submit uevents for log page notification
Message-ID: <1490388582-10237-1-git-send-email-keith.busch@intel.com>

This is a first attempt at adding uevents to nvme. The concept was
discussed at LSFMM, so here it is for consideration. :)

In this implementation, the driver will submit a "change" uevent whenever
the controller indicates a log page contains pertinent information. This
happens in response to an Asynchronouse Event Notification, or if a
command completes with the "MORE" status bit set. If there are other
events anyone thinks we'd like udev to get a chance to handle, or would
prefer to see these variables submitted to udev in a different format,
please let me know.

Submitting a uevent from the kernel can't be done from an irq context,
which is the context the driver learns of such event, so this path
enqueues the log identifier of internest on a FIFO, then has the async
event work flush the event FIFO to udev. Pretty simple.

Tested with the following rule to kick an nvme-cli generic get-log to
clear the log request and append the returned log data to a temporary
log. This is just an example for testing and not intended for real
life use.

ACTION=="change", SUBSYSTEM=="nvme", ENV{NVME_LOG}=="*", \
	RUN+="/bin/sh -c '/usr/local/sbin/nvme get-log $env{DEVNAME} --log-id=$env{NVME_LOG} --log-len=4096 >> /tmp/nvme-log'"

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c   | 35 +++++++++++++++++++++++++++++++++--
 drivers/nvme/host/fc.c     |  2 ++
 drivers/nvme/host/nvme.h   |  4 ++++
 drivers/nvme/host/pci.c    |  2 ++
 drivers/nvme/host/rdma.c   |  2 ++
 drivers/nvme/target/loop.c |  2 ++
 include/linux/nvme.h       |  2 ++
 7 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9b3b57f..a757deb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1879,6 +1879,27 @@ static const struct attribute_group *nvme_dev_attr_groups[] = {
 	NULL,
 };
 
+void nvme_uevent_work(struct nvme_ctrl *ctrl, int log)
+{
+	char buffer[13]; /* NVME_LOG=255\0 */
+	char *envp[2] = {buffer, NULL};
+
+	snprintf(buffer, sizeof(buffer), "NVME_LOG=%d", log);
+	kobject_uevent_env(&ctrl->device->kobj, KOBJ_CHANGE, envp);
+}
+
+void nvme_uevent(struct nvme_ctrl *ctrl, int log_page)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ctrl->lock, flags);
+	kfifo_put(&ctrl->log_event_fifo, log_page);
+	spin_unlock_irqrestore(&ctrl->lock, flags);
+
+	schedule_work(&ctrl->async_event_work);
+}
+EXPORT_SYMBOL_GPL(nvme_uevent);
+
 static int ns_cmp(void *priv, struct list_head *a, struct list_head *b)
 {
 	struct nvme_ns *nsa = container_of(a, struct nvme_ns, list);
@@ -2149,8 +2170,14 @@ static void nvme_async_event_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl =
 		container_of(work, struct nvme_ctrl, async_event_work);
+	int log_page;
 
 	spin_lock_irq(&ctrl->lock);
+	while (kfifo_get(&ctrl->log_event_fifo, &log_page)) {
+		spin_unlock_irq(&ctrl->lock);
+		nvme_uevent_work(ctrl, log_page);
+		spin_lock_irq(&ctrl->lock);
+	}
 	while (ctrl->event_limit > 0) {
 		int aer_idx = --ctrl->event_limit;
 
@@ -2165,6 +2192,8 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		union nvme_result *res)
 {
 	u32 result = le32_to_cpu(res->u32);
+	u8 log_page = (result >> 16) & 8;
+	u8 event_type = result & 7;
 	bool done = true;
 
 	switch (le16_to_cpu(status) >> 1) {
@@ -2173,7 +2202,6 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		/*FALLTHRU*/
 	case NVME_SC_ABORT_REQ:
 		++ctrl->event_limit;
-		schedule_work(&ctrl->async_event_work);
 		break;
 	default:
 		break;
@@ -2182,13 +2210,15 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 	if (done)
 		return;
 
-	switch (result & 0xff07) {
+	nvme_uevent(ctrl, log_page);
+	switch (event_type) {
 	case NVME_AER_NOTICE_NS_CHANGED:
 		dev_info(ctrl->device, "rescanning\n");
 		nvme_queue_scan(ctrl);
 		break;
 	default:
 		dev_warn(ctrl->device, "async event result %08x\n", result);
+		break;
 	}
 }
 EXPORT_SYMBOL_GPL(nvme_complete_async_event);
@@ -2280,6 +2310,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->quirks = quirks;
 	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
 	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
+	INIT_KFIFO(ctrl->log_event_fifo);
 
 	ret = nvme_set_instance(ctrl);
 	if (ret)
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 9690beb..3930a12 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1936,6 +1936,8 @@ nvme_fc_complete_rq(struct request *rq)
 			nvme_requeue_req(rq);
 			return;
 		}
+		if (req->errors & NVME_SC_MORE)
+			nvme_uevent(&dev->ctrl, NVME_LOG_ERROR);
 
 		if (blk_rq_is_passthrough(rq))
 			error = rq->errors;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2aa20e3..fda6ebb 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -173,6 +173,9 @@ struct nvme_ctrl {
 	u16 icdoff;
 	u16 maxcmd;
 	struct nvmf_ctrl_options *opts;
+
+#define NVME_EVENT_FIFO_SIZE 8
+	DECLARE_KFIFO(log_event_fifo, int, NVME_EVENT_FIFO_SIZE);
 };
 
 /*
@@ -290,6 +293,7 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		union nvme_result *res);
 void nvme_queue_async_events(struct nvme_ctrl *ctrl);
+void nvme_uevent(struct nvme_ctrl *ctrl, int log_id);
 
 void nvme_stop_queues(struct nvme_ctrl *ctrl);
 void nvme_start_queues(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 26a5fd0..6a2f0d3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -642,6 +642,8 @@ static void nvme_complete_rq(struct request *req)
 			nvme_requeue_req(req);
 			return;
 		}
+		if (req->errors & NVME_SC_MORE)
+			nvme_uevent(&dev->ctrl, NVME_LOG_ERROR);
 
 		if (blk_rq_is_passthrough(req))
 			error = req->errors;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 779f516..d8397665 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1507,6 +1507,8 @@ static void nvme_rdma_complete_rq(struct request *rq)
 			nvme_requeue_req(rq);
 			return;
 		}
+		if (req->errors & NVME_SC_MORE)
+			nvme_uevent(&dev->ctrl, NVME_LOG_ERROR);
 
 		if (blk_rq_is_passthrough(rq))
 			error = rq->errors;
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index d1f06e7..369b5de3 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -103,6 +103,8 @@ static void nvme_loop_complete_rq(struct request *req)
 			nvme_requeue_req(req);
 			return;
 		}
+		if (req->errors & NVME_SC_MORE)
+			nvme_uevent(&dev->ctrl, NVME_LOG_ERROR);
 
 		if (blk_rq_is_passthrough(req))
 			error = req->errors;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index c43d435..e711de6 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -16,6 +16,7 @@
 #define _LINUX_NVME_H
 
 #include <linux/types.h>
+#include <linux/kfifo.h>
 
 /* NQN names in commands fields specified one size */
 #define NVMF_NQN_FIELD_LEN	256
@@ -1003,6 +1004,7 @@ enum {
 	NVME_SC_ACCESS_DENIED		= 0x286,
 	NVME_SC_UNWRITTEN_BLOCK		= 0x287,
 
+	NVME_SC_MORE			= 0x2000,
 	NVME_SC_DNR			= 0x4000,
 
 
-- 
2.7.2
