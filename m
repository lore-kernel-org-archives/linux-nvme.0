From: keith.busch@intel.com (Keith Busch)
Date: Wed, 24 Feb 2016 09:15:54 -0700
Subject: [PATCHv4-4.5 3/7] NVMe: Fix namespace removal deadlock
In-Reply-To: <1456330558-819-1-git-send-email-keith.busch@intel.com>
References: <1456330558-819-1-git-send-email-keith.busch@intel.com>
Message-ID: <1456330558-819-4-git-send-email-keith.busch@intel.com>

This patch makes nvme namespace removal lockless. It is up to the caller
to ensure no active namespace scanning is occuring. To ensure no scan
work occurs, the nvme pci driver adds a removing state to the controller
device to avoid queueing scan work during removal. The work is flushed
after setting the state, so no new scan work can be queued.

The lockless removal allows the driver to cleanup a namespace
request_queue if the controller fails during removal. Previously this
could deadlock trying to acquire the namespace mutex in order to handle
such events.

Signed-off-by: Keith Busch <keith.busch at intel.com>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
---
v3->v4:

  This combines two patches from the previous series into a single commit
  as it these two make a single feature.

  The test for controller removing is done prior to queueing scan work
  instead of in the scan work itself, and adds a code comment explaining
  its purpose.

 drivers/nvme/host/core.c | 12 +++++++-----
 drivers/nvme/host/nvme.h |  4 ++++
 drivers/nvme/host/pci.c  | 17 +++++++++++++++--
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4b54081..08b748e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1186,11 +1186,13 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 static void nvme_ns_remove(struct nvme_ns *ns)
 {
-	bool kill = nvme_io_incapable(ns->ctrl) &&
-			!blk_queue_dying(ns->queue);
+	bool kill;
 
-	lockdep_assert_held(&ns->ctrl->namespaces_mutex);
+	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
+		return;
 
+	kill = nvme_io_incapable(ns->ctrl) &&
+			!blk_queue_dying(ns->queue);
 	if (kill) {
 		blk_set_queue_dying(ns->queue);
 
@@ -1213,7 +1215,9 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 		blk_mq_abort_requeue_list(ns->queue);
 		blk_cleanup_queue(ns->queue);
 	}
+	mutex_lock(&ns->ctrl->namespaces_mutex);
 	list_del_init(&ns->list);
+	mutex_unlock(&ns->ctrl->namespaces_mutex);
 	nvme_put_ns(ns);
 }
 
@@ -1308,10 +1312,8 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns, *next;
 
-	mutex_lock(&ctrl->namespaces_mutex);
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list)
 		nvme_ns_remove(ns);
-	mutex_unlock(&ctrl->namespaces_mutex);
 }
 
 static DEFINE_IDA(nvme_instance_ida);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9407f2f..4075fa9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -114,6 +114,10 @@ struct nvme_ns {
 	bool ext;
 	u8 pi_type;
 	int type;
+	unsigned long flags;
+
+#define NVME_NS_REMOVING 0
+
 	u64 mode_select_num_blocks;
 	u32 mode_select_block_len;
 };
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2ea3e39..122f803 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -120,6 +120,7 @@ struct nvme_dev {
 	unsigned long flags;
 
 #define NVME_CTRL_RESETTING    0
+#define NVME_CTRL_REMOVING     1
 
 	struct nvme_ctrl ctrl;
 	struct completion ioq_wait;
@@ -286,6 +287,17 @@ static int nvme_init_request(void *data, struct request *req,
 	return 0;
 }
 
+static void nvme_queue_scan(struct nvme_dev *dev)
+{
+	/*
+	 * Do not queue new scan work when a controller is reset during
+	 * removal.
+	 */
+	if (test_bit(NVME_CTRL_REMOVING, &dev->flags))
+		return;
+	queue_work(nvme_workq, &dev->scan_work);
+}
+
 static void nvme_complete_async_event(struct nvme_dev *dev,
 		struct nvme_completion *cqe)
 {
@@ -300,7 +312,7 @@ static void nvme_complete_async_event(struct nvme_dev *dev,
 	switch (result & 0xff07) {
 	case NVME_AER_NOTICE_NS_CHANGED:
 		dev_info(dev->dev, "rescanning\n");
-		queue_work(nvme_workq, &dev->scan_work);
+		nvme_queue_scan(dev);
 	default:
 		dev_warn(dev->dev, "async event result %08x\n", result);
 	}
@@ -1690,7 +1702,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 			return 0;
 		dev->ctrl.tagset = &dev->tagset;
 	}
-	queue_work(nvme_workq, &dev->scan_work);
+	nvme_queue_scan(dev);
 	return 0;
 }
 
@@ -2128,6 +2140,7 @@ static void nvme_remove(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 
+	set_bit(NVME_CTRL_REMOVING, &dev->flags);
 	pci_set_drvdata(pdev, NULL);
 	flush_work(&dev->scan_work);
 	nvme_remove_namespaces(&dev->ctrl);
-- 
2.6.2.307.g37023ba
