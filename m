From: keith.busch@intel.com (Keith Busch)
Date: Fri, 19 Jan 2018 01:42:18 -0700
Subject: [PATCH V5 0/2] nvme-pci: fix the timeout case when reset is
 ongoing
In-Reply-To: <0639aa2f-d153-5aac-ce08-df0d4b45f9a0@oracle.com>
References: <1516270202-8051-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180119080130.GE12043@localhost.localdomain>
 <0639aa2f-d153-5aac-ce08-df0d4b45f9a0@oracle.com>
Message-ID: <20180119084218.GF12043@localhost.localdomain>

On Fri, Jan 19, 2018@04:14:02PM +0800, jianchao.wang wrote:
> On 01/19/2018 04:01 PM, Keith Busch wrote:
> > The nvme_dev_disable routine makes forward progress without depending on
> > timeout handling to complete expired commands. Once controller disabling
> > completes, there can't possibly be any started requests that can expire.
> > So we don't need nvme_timeout to do anything for requests above the
> > boundary.
> > 
> Yes, once controller disabling completes, any started requests will be handled and cannot expire.
> But before the _boundary_, there could be a nvme_timeout context runs with nvme_dev_disable in parallel.
> If a timeout path grabs a request, then nvme_dev_disable cannot get and cancel it.
> So even though the nvme_dev_disable completes, there still could be a request in nvme_timeout context.
> 
> The worst case is :
> nvme_timeout                              nvme_reset_work
> if (ctrl->state == RESETTING )              nvme_dev_disable
>     nvme_dev_disable                        initializing procedure
> 
> the nvme_dev_disable run with reinit procedure in nvme_reset_work in parallel.

Okay, I see what you're saying. That's a pretty obscure case, as normally
we enter nvme_reset_work with the queues already disabled, but there
are a few cases where we need nvme_reset_work to handle that.

But if we are in that case, I think we really just want to sync the
queues. What do you think of this?

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fde6fd2e7eef..516383193416 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3520,6 +3520,17 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_stop_queues);
 
+void nvme_sync_queues(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+
+	mutex_lock(&ctrl->namespaces_mutex);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		blk_sync_queue(ns->queue);
+	mutex_unlock(&ctrl->namespaces_mutex);
+}
+EXPORT_SYMBOL_GPL(nvme_sync_queues);
+
 void nvme_start_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8e7fc1b041b7..45b1b8ceddb6 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -374,6 +374,7 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 
 void nvme_stop_queues(struct nvme_ctrl *ctrl);
 void nvme_start_queues(struct nvme_ctrl *ctrl);
+void nvme_sync_queues(struct nvme_ctrl *ctrl)
 void nvme_kill_queues(struct nvme_ctrl *ctrl);
 void nvme_unfreeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a2ffb557b616..1fe00be22ad1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2289,8 +2289,10 @@ static void nvme_reset_work(struct work_struct *work)
 	 * If we're called to reset a live controller first shut it down before
 	 * moving on.
 	 */
-	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
+	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE) {
 		nvme_dev_disable(dev, false);
+		nvme_sync_queues(&dev->ctrl);
+	}
 
 	result = nvme_pci_enable(dev);
 	if (result)
--
