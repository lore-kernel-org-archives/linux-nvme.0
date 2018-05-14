From: hch@lst.de (Christoph Hellwig)
Date: Mon, 14 May 2018 09:56:41 +0200
Subject: [PATCH 06/11] nvmet: refactor AER handling
In-Reply-To: <20180514075646.28823-1-hch@lst.de>
References: <20180514075646.28823-1-hch@lst.de>
Message-ID: <20180514075646.28823-7-hch@lst.de>

Create a helper to iterate all controlles in a subsystem instead of open
coding the loop.  Also use the NVME_AER_NOTICE_NS_CHANGED definition instead
of plain 0.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/target/core.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index e95424f172fd..505d4267b8f1 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -137,6 +137,19 @@ static void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 	schedule_work(&ctrl->async_event_work);
 }
 
+static void nvmet_send_ns_changed_event(struct nvmet_subsys *subsys)
+{
+	/*
+	 * XXX: should also include the log id, but the changed namespace list
+	 * log needs to be implemented first..
+	 */
+	struct nvmet_ctrl *ctrl;
+
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
+		nvmet_add_async_event(ctrl, NVME_AER_TYPE_NOTICE,
+				NVME_AER_NOTICE_NS_CHANGED, 0);
+}
+
 int nvmet_register_transport(const struct nvmet_fabrics_ops *ops)
 {
 	int ret = 0;
@@ -274,7 +287,6 @@ void nvmet_put_namespace(struct nvmet_ns *ns)
 int nvmet_ns_enable(struct nvmet_ns *ns)
 {
 	struct nvmet_subsys *subsys = ns->subsys;
-	struct nvmet_ctrl *ctrl;
 	int ret = 0;
 
 	mutex_lock(&subsys->lock);
@@ -320,9 +332,7 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 		list_add_tail_rcu(&ns->dev_link, &old->dev_link);
 	}
 
-	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
-		nvmet_add_async_event(ctrl, NVME_AER_TYPE_NOTICE, 0, 0);
-
+	nvmet_send_ns_changed_event(subsys);
 	ns->enabled = true;
 	ret = 0;
 out_unlock:
@@ -337,7 +347,6 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 void nvmet_ns_disable(struct nvmet_ns *ns)
 {
 	struct nvmet_subsys *subsys = ns->subsys;
-	struct nvmet_ctrl *ctrl;
 
 	mutex_lock(&subsys->lock);
 	if (!ns->enabled)
@@ -363,9 +372,7 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
 	percpu_ref_exit(&ns->ref);
 
 	mutex_lock(&subsys->lock);
-	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
-		nvmet_add_async_event(ctrl, NVME_AER_TYPE_NOTICE, 0, 0);
-
+	nvmet_send_ns_changed_event(subsys);
 	if (ns->bdev)
 		blkdev_put(ns->bdev, FMODE_WRITE|FMODE_READ);
 out_unlock:
-- 
2.17.0
