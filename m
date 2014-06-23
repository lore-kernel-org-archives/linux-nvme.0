From: wyung@micron.com (Winson Yung (wyung))
Date: Mon, 23 Jun 2014 21:21:18 +0000
Subject: [PATCHv3] NVMe: Async event request
In-Reply-To: <1403121537-28806-1-git-send-email-keith.busch@intel.com>
References: <1403121537-28806-1-git-send-email-keith.busch@intel.com>
Message-ID: <4153505278C0BF4DABE3DF3D82533FE23026BC6E@NTXBOIMBX05.micron.com>

Hi Keith, are you suggesting user to scan the system logs to find out all the async events. I found your following patch using read/poll get async events is much preferred:

http://lists.infradead.org/pipermail/linux-nvme/2013-August/000350.html

/Winson

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Keith Busch
Sent: Wednesday, June 18, 2014 12:59 PM
To: linux-nvme at lists.infradead.org
Cc: Keith Busch
Subject: [PATCHv3] NVMe: Async event request

Submits NVMe asynchronous event requests, one event up to the controller maximum or number of possible different event types (8), whichever is smaller. Events successfully returned by the controller are logged.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
v2 -> v3:
Reclaim available event requests on device resets and suspends.

 drivers/block/nvme-core.c |   42 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/nvme.h      |    1 +
 2 files changed, 43 insertions(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c index 02351e2..90673f3 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -207,6 +207,7 @@ static int alloc_cmdid_killable(struct nvme_queue *nvmeq, void *ctx,
 #define CMD_CTX_COMPLETED	(0x310 + CMD_CTX_BASE)
 #define CMD_CTX_INVALID		(0x314 + CMD_CTX_BASE)
 #define CMD_CTX_ABORT		(0x318 + CMD_CTX_BASE)
+#define CMD_CTX_ASYNC		(0x31C + CMD_CTX_BASE)
 
 static void special_completion(struct nvme_queue *nvmeq, void *ctx,
 						struct nvme_completion *cqe)
@@ -229,6 +230,17 @@ static void special_completion(struct nvme_queue *nvmeq, void *ctx,
 				cqe->command_id, le16_to_cpup(&cqe->sq_id));
 		return;
 	}
+	if (ctx == CMD_CTX_ASYNC) {
+		u32 result = le32_to_cpup(&cqe->result);
+		u16 status = le16_to_cpup(&cqe->status) >> 1;
+
+		if (status == NVME_SC_SUCCESS || status == NVME_SC_ABORT_REQ)
+			++nvmeq->dev->event_limit;
+		if (status == NVME_SC_SUCCESS)
+			dev_warn(nvmeq->q_dmadev,
+				"async event result %08x\n", result);
+		return;
+	}
 
 	dev_warn(nvmeq->q_dmadev, "Unknown special completion %p\n", ctx);  } @@ -1161,6 +1173,8 @@ static void nvme_cancel_ios(struct nvme_queue *nvmeq, bool timeout)
 			continue;
 		if (info[cmdid].ctx == CMD_CTX_CANCELLED)
 			continue;
+		if (timeout && info[cmdid].ctx == CMD_CTX_ASYNC)
+			continue;
 		if (timeout && nvmeq->dev->initialized) {
 			nvme_abort_cmd(cmdid, nvmeq);
 			continue;
@@ -1843,6 +1857,27 @@ static void nvme_resubmit_bios(struct nvme_queue *nvmeq)
 	}
 }
 
+static int nvme_submit_async_req(struct nvme_queue *nvmeq) {
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
 	memcpy(dev->firmware_rev, ctrl->fr, sizeof(ctrl->fr)); diff --git a/include/linux/nvme.h b/include/linux/nvme.h index 2bf4031..974efd0 100644
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


_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
