From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Sat,  6 Jan 2018 07:33:35 +0800
Subject: [PATCH V3] nvme-pci: fix NULL pointer reference in nvme_alloc_ns
Message-ID: <1515195215-8913-1-git-send-email-jianchao.w.wang@oracle.com>

When the io queues setup or tagset allocation failed, ctrl.tagset
is NULL. But the scan work will still be queued and executed, then
panic comes up due to NULL pointer reference of ctrl.tagset.

To fix this, add a new ctrl state NVME_CTRL_ADMIN_ONLY to inidcate
only admin queue is live. When non io queues or tagset allocation
failed, ctrl enters into this state, scan work will not be started.
But async event work and nvme dev ioctl will be still available.
This will be helpful to do further investigation and recovery.

V3:
 - s/NVME_CTRL_ADMIN_LIVE/NVME_CTRL_ADMIN_ONLY/
 - s/BUG_ON/WARN_ON_ONCE/
 - Other misc code changes
V2:
 - Based on Sagi's suggestion, add new state NVME_CTRL_ADMIN_LIVE.
 - Change patch name and comment.

Suggested-by: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/nvme/host/core.c | 25 ++++++++++++++++++++++---
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  | 30 +++++++++++++++++++++---------
 3 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1e46e60..a614cd7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -232,6 +232,15 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 
 	old_state = ctrl->state;
 	switch (new_state) {
+	case NVME_CTRL_ADMIN_ONLY:
+		switch (old_state) {
+		case NVME_CTRL_RESETTING:
+			changed = true;
+			/* FALLTHRU */
+		default:
+			break;
+		}
+		break;
 	case NVME_CTRL_LIVE:
 		switch (old_state) {
 		case NVME_CTRL_NEW:
@@ -247,6 +256,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		switch (old_state) {
 		case NVME_CTRL_NEW:
 		case NVME_CTRL_LIVE:
+		case NVME_CTRL_ADMIN_ONLY:
 			changed = true;
 			/* FALLTHRU */
 		default:
@@ -266,6 +276,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	case NVME_CTRL_DELETING:
 		switch (old_state) {
 		case NVME_CTRL_LIVE:
+		case NVME_CTRL_ADMIN_ONLY:
 		case NVME_CTRL_RESETTING:
 		case NVME_CTRL_RECONNECTING:
 			changed = true;
@@ -2337,8 +2348,14 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
 	struct nvme_ctrl *ctrl =
 		container_of(inode->i_cdev, struct nvme_ctrl, cdev);
 
-	if (ctrl->state != NVME_CTRL_LIVE)
+	switch(ctrl->state) {
+	case NVME_CTRL_LIVE:
+	case NVME_CTRL_ADMIN_ONLY:
+		break;
+	default:
 		return -EWOULDBLOCK;
+	}
+
 	file->private_data = ctrl;
 	return 0;
 }
@@ -2602,6 +2619,7 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
 	static const char *const state_name[] = {
 		[NVME_CTRL_NEW]		= "new",
 		[NVME_CTRL_LIVE]	= "live",
+		[NVME_CTRL_ADMIN_ONLY]	= "only-admin",
 		[NVME_CTRL_RESETTING]	= "resetting",
 		[NVME_CTRL_RECONNECTING]= "reconnecting",
 		[NVME_CTRL_DELETING]	= "deleting",
@@ -3074,6 +3092,8 @@ static void nvme_scan_work(struct work_struct *work)
 	if (ctrl->state != NVME_CTRL_LIVE)
 		return;
 
+	WARN_ON_ONCE(!ctrl->tagset);
+
 	if (nvme_identify_ctrl(ctrl, &id))
 		return;
 
@@ -3094,8 +3114,7 @@ static void nvme_scan_work(struct work_struct *work)
 void nvme_queue_scan(struct nvme_ctrl *ctrl)
 {
 	/*
-	 * Do not queue new scan work when a controller is reset during
-	 * removal.
+	 * Only new queue scan work when admin and IO queues are both alive
 	 */
 	if (ctrl->state == NVME_CTRL_LIVE)
 		queue_work(nvme_wq, &ctrl->scan_work);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ea1aa52..eecf71c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -119,6 +119,7 @@ static inline struct nvme_request *nvme_req(struct request *req)
 enum nvme_ctrl_state {
 	NVME_CTRL_NEW,
 	NVME_CTRL_LIVE,
+	NVME_CTRL_ADMIN_ONLY,    /* Only admin queue live */
 	NVME_CTRL_RESETTING,
 	NVME_CTRL_RECONNECTING,
 	NVME_CTRL_DELETING,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f5800c3..e758c5a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2035,13 +2035,12 @@ static void nvme_disable_io_queues(struct nvme_dev *dev, int queues)
 }
 
 /*
- * Return: error value if an error occurred setting up the queues or calling
- * Identify Device.  0 if these succeeded, even if adding some of the
- * namespaces failed.  At the moment, these failures are silent.  TBD which
- * failures should be reported.
+ * return error value only when tagset allocation failed
  */
 static int nvme_dev_add(struct nvme_dev *dev)
 {
+	int ret;
+
 	if (!dev->ctrl.tagset) {
 		dev->tagset.ops = &nvme_mq_ops;
 		dev->tagset.nr_hw_queues = dev->online_queues - 1;
@@ -2057,8 +2056,12 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
 		dev->tagset.driver_data = dev;
 
-		if (blk_mq_alloc_tag_set(&dev->tagset))
-			return 0;
+		ret = blk_mq_alloc_tag_set(&dev->tagset);
+		if (ret) {
+			dev_warn(dev->ctrl.device,
+				"IO queues tagset allocation failed %d\n", ret);
+			return ret;
+		}
 		dev->ctrl.tagset = &dev->tagset;
 
 		nvme_dbbuf_set(dev);
@@ -2291,6 +2294,7 @@ static void nvme_reset_work(struct work_struct *work)
 		container_of(work, struct nvme_dev, ctrl.reset_work);
 	bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
 	int result = -ENODEV;
+	enum nvme_ctrl_state new_state = NVME_CTRL_LIVE;
 
 	if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING))
 		goto out;
@@ -2354,15 +2358,23 @@ static void nvme_reset_work(struct work_struct *work)
 		dev_warn(dev->ctrl.device, "IO queues not created\n");
 		nvme_kill_queues(&dev->ctrl);
 		nvme_remove_namespaces(&dev->ctrl);
+		new_state = NVME_CTRL_ADMIN_ONLY;
 	} else {
 		nvme_start_queues(&dev->ctrl);
 		nvme_wait_freeze(&dev->ctrl);
-		nvme_dev_add(dev);
+		/* hit this only when allocate tagset fails */
+		if (nvme_dev_add(dev))
+			new_state = NVME_CTRL_ADMIN_ONLY;
 		nvme_unfreeze(&dev->ctrl);
 	}
 
-	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_LIVE)) {
-		dev_warn(dev->ctrl.device, "failed to mark controller live\n");
+	/*
+	 * If only admin queue live, keep it to do further investigation or
+	 * recovery.
+	 */
+	if (!nvme_change_ctrl_state(&dev->ctrl, new_state)) {
+		dev_warn(dev->ctrl.device,
+			"failed to mark controller state %d\n", new_state);
 		goto out;
 	}
 
-- 
2.7.4
