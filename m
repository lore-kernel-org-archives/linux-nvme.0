From: zhangweiping@didichuxing.com (=?gb2312?B?1cXOsMa9KLv5tKHGvcyosr8p?=)
Date: Tue, 27 Jun 2017 14:46:24 +0000
Subject: [PATCH] nvme: remove indenty ctrl before scan namespace
Message-ID: <20170627144624.GA36121@localhost.didichuxing.com>

All nvme host drivers have already identified ctrl beforce scan namespace,
so when first time identify ctrl we get the number of namespace and store it
into nvme_ctrl. When we scan namespace just use it instead of indentify again.

Signed-off-by: weiping zhang <zhangweiping at didichuxing.com>
---
 drivers/nvme/host/core.c | 25 ++++++++++---------------
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 903d581..34f85df 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1586,6 +1586,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		ctrl->quirks &= ~NVME_QUIRK_NO_DEEPEST_PS;
 	}
 
+	ctrl->nn = le32_to_cpu(id->nn);
 	ctrl->oacs = le16_to_cpu(id->oacs);
 	ctrl->vid = le16_to_cpu(id->vid);
 	ctrl->oncs = le16_to_cpup(&id->oncs);
@@ -2147,13 +2148,14 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 	}
 }
 
-static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
+static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 	__le32 *ns_list;
-	unsigned i, j, nsid, prev = 0, num_lists = DIV_ROUND_UP(nn, 1024);
+	u32 i, j, nsid, prev = 0, num_lists, nn =  ctrl->nn;
 	int ret = 0;
 
+	num_lists = DIV_ROUND_UP(nn, 1024);
 	ns_list = kzalloc(0x1000, GFP_KERNEL);
 	if (!ns_list)
 		return -ENOMEM;
@@ -2187,41 +2189,34 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
 	return ret;
 }
 
-static void nvme_scan_ns_sequential(struct nvme_ctrl *ctrl, unsigned nn)
+static void nvme_scan_ns_sequential(struct nvme_ctrl *ctrl)
 {
-	unsigned i;
+	u32 i;
 
-	for (i = 1; i <= nn; i++)
+	for (i = 1; i <= ctrl->nn; i++)
 		nvme_validate_ns(ctrl, i);
 
-	nvme_remove_invalid_namespaces(ctrl, nn);
+	nvme_remove_invalid_namespaces(ctrl, ctrl->nn);
 }
 
 static void nvme_scan_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl =
 		container_of(work, struct nvme_ctrl, scan_work);
-	struct nvme_id_ctrl *id;
-	unsigned nn;
 
 	if (ctrl->state != NVME_CTRL_LIVE)
 		return;
 
-	if (nvme_identify_ctrl(ctrl, &id))
-		return;
-
-	nn = le32_to_cpu(id->nn);
 	if (ctrl->vs >= NVME_VS(1, 1, 0) &&
 	    !(ctrl->quirks & NVME_QUIRK_IDENTIFY_CNS)) {
-		if (!nvme_scan_ns_list(ctrl, nn))
+		if (!nvme_scan_ns_list(ctrl))
 			goto done;
 	}
-	nvme_scan_ns_sequential(ctrl, nn);
+	nvme_scan_ns_sequential(ctrl);
  done:
 	mutex_lock(&ctrl->namespaces_mutex);
 	list_sort(NULL, &ctrl->namespaces, ns_cmp);
 	mutex_unlock(&ctrl->namespaces_mutex);
-	kfree(id);
 }
 
 void nvme_queue_scan(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9d6a070..67f373b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -131,6 +131,7 @@ struct nvme_ctrl {
 	struct device *device;	/* char device */
 	struct list_head node;
 	struct ida ns_ida;
+	u32 nn; /* namespace num */
 
 	struct opal_dev *opal_dev;
 
-- 
2.9.4
