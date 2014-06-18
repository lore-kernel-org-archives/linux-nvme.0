From: keith.busch@intel.com (Keith Busch)
Date: Wed, 18 Jun 2014 10:36:20 -0600
Subject: [PATCHv2] NVMe: Async event request
Message-ID: <1403109380-12247-1-git-send-email-keith.busch@intel.com>

Submits NVMe asynchronous event requests, one event up to the controller
maximum or number of possible different event types (8), whichever is
smaller. Events successfully returned by the controller are logged.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
v1 -> v2:

>From feedback on v1 (thanks, willy!), fixed incorrect available event
accounting when command id's are unavaialble.

 drivers/block/nvme-core.c |   44 +++++++++++++++++++++++++++++++++++++++++++-
 include/linux/nvme.h      |    1 +
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 02351e2..8997c77 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -207,6 +207,7 @@ static int alloc_cmdid_killable(struct nvme_queue *nvmeq, void *ctx,
 #define CMD_CTX_COMPLETED	(0x310 + CMD_CTX_BASE)
 #define CMD_CTX_INVALID		(0x314 + CMD_CTX_BASE)
 #define CMD_CTX_ABORT		(0x318 + CMD_CTX_BASE)
+#define CMD_CTX_ASYNC		(0x31C + CMD_CTX_BASE)
 
 static void special_completion(struct nvme_queue *nvmeq, void *ctx,
 						struct nvme_completion *cqe)
@@ -229,6 +230,18 @@ static void special_completion(struct nvme_queue *nvmeq, void *ctx,
 				cqe->command_id, le16_to_cpup(&cqe->sq_id));
 		return;
 	}
+	if (ctx == CMD_CTX_ASYNC) {
+		u32 result = le32_to_cpup(&cqe->result);
+		u16 status = le16_to_cpup(&cqe->status) >> 1;
+
+		if (status != NVME_SC_SUCCESS)
+			return;
+		
+		dev_warn(nvmeq->q_dmadev,
+				"async event result %08x\n", result);
+		++nvmeq->dev->event_limit;
+		return;
+	}
 
 	dev_warn(nvmeq->q_dmadev, "Unknown special completion %p\n", ctx);
 }
@@ -1159,7 +1172,8 @@ static void nvme_cancel_ios(struct nvme_queue *nvmeq, bool timeout)
 
 		if (timeout && !time_after(now, info[cmdid].timeout))
 			continue;
-		if (info[cmdid].ctx == CMD_CTX_CANCELLED)
+		if (info[cmdid].ctx == CMD_CTX_CANCELLED ||
+					info[cmdid].ctx == CMD_CTX_ASYNC)
 			continue;
 		if (timeout && nvmeq->dev->initialized) {
 			nvme_abort_cmd(cmdid, nvmeq);
@@ -1843,6 +1857,27 @@ static void nvme_resubmit_bios(struct nvme_queue *nvmeq)
 	}
 }
 
+static int nvme_submit_async_req(struct nvme_queue *nvmeq)
+{
+	struct nvme_command *c;
+	int cmdid;
+
+	cmdid = alloc_cmdid(nvmeq, CMD_CTX_ASYNC, special_completion, 0);
+	if (cmdid < 0)
+		return cmdid;
+
+	c = &nvmeq->sq_cmds[nvmeq->sq_tail];
+	memset(c, 0, sizeof(*c));
+	c->common.opcode = nvme_admin_async_event;
+	c->common.command_id = cmdid;
+
+	if (++nvmeq->sq_tail == nvmeq->q_depth)
+		nvmeq->sq_tail = 0;
+	writel(nvmeq->sq_tail, nvmeq->q_db);
+
+	return 0;
+}
+
 static int nvme_kthread(void *data)
 {
 	struct nvme_dev *dev, *next;
@@ -1876,6 +1911,12 @@ static int nvme_kthread(void *data)
 				nvme_cancel_ios(nvmeq, true);
 				nvme_resubmit_bios(nvmeq);
 				nvme_resubmit_iods(nvmeq);
+
+				while ((i == 0) && (dev->event_limit > 0)) {
+					if (nvme_submit_async_req(nvmeq))
+						break;
+					dev->event_limit--;
+				}
  unlock:
 				spin_unlock_irq(&nvmeq->q_lock);
 			}
@@ -2244,6 +2285,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	dev->oncs = le16_to_cpup(&ctrl->oncs);
 	dev->abort_limit = ctrl->acl + 1;
 	dev->vwc = ctrl->vwc;
+	dev->event_limit = min(ctrl->aerl + 1, 8);
 	memcpy(dev->serial, ctrl->sn, sizeof(ctrl->sn));
 	memcpy(dev->model, ctrl->mn, sizeof(ctrl->mn));
 	memcpy(dev->firmware_rev, ctrl->fr, sizeof(ctrl->fr));
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 2bf4031..974efd0 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -99,6 +99,7 @@ struct nvme_dev {
 	u32 stripe_size;
 	u16 oncs;
 	u16 abort_limit;
+	u8 event_limit;
 	u8 vwc;
 	u8 initialized;
 };
-- 
1.7.10.4
