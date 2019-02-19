From: hare@suse.de (Hannes Reinecke)
Date: Tue, 19 Feb 2019 13:13:57 +0100
Subject: [PATCH 1/2] nvme: return error from nvme_alloc_ns()
In-Reply-To: <20190219121358.57975-1-hare@suse.de>
References: <20190219121358.57975-1-hare@suse.de>
Message-ID: <20190219121358.57975-2-hare@suse.de>

nvme_alloc_ns() might fail, so we should be returning an error code.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f2f75831decd..9c6f6a4db60a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3214,21 +3214,23 @@ static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
 	return 0;
 }
 
-static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
+static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns *ns;
 	struct gendisk *disk;
 	struct nvme_id_ns *id;
 	char disk_name[DISK_NAME_LEN];
-	int node = ctrl->numa_node, flags = GENHD_FL_EXT_DEVT;
+	int node = ctrl->numa_node, flags = GENHD_FL_EXT_DEVT, ret;
 
 	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
 	if (!ns)
-		return;
+		return -ENOMEM;
 
 	ns->queue = blk_mq_init_queue(ctrl->tagset);
-	if (IS_ERR(ns->queue))
+	if (IS_ERR(ns->queue)) {
+		ret = PTR_ERR(ns->queue);
 		goto out_free_ns;
+	}
 
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, ns->queue);
 	if (ctrl->ops->flags & NVME_F_PCI_P2PDMA)
@@ -3244,20 +3246,27 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	nvme_set_queue_limits(ctrl, ns->queue);
 
 	id = nvme_identify_ns(ctrl, nsid);
-	if (!id)
+	if (!id) {
+		ret = -EIO;
 		goto out_free_queue;
+	}
 
-	if (id->ncap == 0)
+	if (id->ncap == 0) {
+		ret = -EINVAL;
 		goto out_free_id;
+	}
 
-	if (nvme_init_ns_head(ns, nsid, id))
+	ret = nvme_init_ns_head(ns, nsid, id);
+	if (ret)
 		goto out_free_id;
 	nvme_setup_streams_ns(ctrl, ns);
 	nvme_set_disk_name(disk_name, ns, ctrl, &flags);
 
 	disk = alloc_disk_node(0, node);
-	if (!disk)
+	if (!disk) {
+		ret = -ENOMEM;
 		goto out_unlink_ns;
+	}
 
 	disk->fops = &nvme_fops;
 	disk->private_data = ns;
@@ -3269,7 +3278,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	__nvme_revalidate_disk(disk, id);
 
 	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
-		if (nvme_nvm_register(ns, disk_name, node)) {
+		ret = nvme_nvm_register(ns, disk_name, node);
+		if (ret) {
 			dev_warn(ctrl->device, "LightNVM init failure\n");
 			goto out_put_disk;
 		}
@@ -3287,7 +3297,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	nvme_fault_inject_init(ns);
 	kfree(id);
 
-	return;
+	return 0;
  out_put_disk:
 	put_disk(ns->disk);
  out_unlink_ns:
@@ -3300,6 +3310,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	blk_cleanup_queue(ns->queue);
  out_free_ns:
 	kfree(ns);
+	return ret;
 }
 
 static void nvme_ns_remove(struct nvme_ns *ns)
-- 
2.16.4
