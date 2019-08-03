From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri,  2 Aug 2019 19:49:52 -0700
Subject: [PATCH rfc v2 3/6] nvme: make nvme_identify_ns propagate errors back
In-Reply-To: <20190803024955.29508-1-sagi@grimberg.me>
References: <20190803024955.29508-1-sagi@grimberg.me>
Message-ID: <20190803024955.29508-4-sagi@grimberg.me>

right now callers of nvme_identify_ns only know that
it failed, but don't know why. Make nvme_identify_ns propagate
the error back (like nvme_identify_ctrl).

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f435c85c4062..802d1b49ecff 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1094,10 +1094,9 @@ static int nvme_identify_ns_list(struct nvme_ctrl *dev, unsigned nsid, __le32 *n
 				    NVME_IDENTIFY_DATA_SIZE);
 }
 
-static struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
-		unsigned nsid)
+static int nvme_identify_ns(struct nvme_ctrl *ctrl,
+		unsigned nsid, struct nvme_id_ns **id)
 {
-	struct nvme_id_ns *id;
 	struct nvme_command c = { };
 	int error;
 
@@ -1106,18 +1105,17 @@ static struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
 	c.identify.nsid = cpu_to_le32(nsid);
 	c.identify.cns = NVME_ID_CNS_NS;
 
-	id = kmalloc(sizeof(*id), GFP_KERNEL);
-	if (!id)
-		return NULL;
+	*id = kmalloc(sizeof(**id), GFP_KERNEL);
+	if (!*id)
+		return -ENOMEM;
 
-	error = nvme_submit_sync_cmd(ctrl->admin_q, &c, id, sizeof(*id));
+	error = nvme_submit_sync_cmd(ctrl->admin_q, &c, *id, sizeof(**id));
 	if (error) {
 		dev_warn(ctrl->device, "Identify namespace failed (%d)\n", error);
-		kfree(id);
-		return NULL;
+		kfree(*id);
 	}
 
-	return id;
+	return error;
 }
 
 static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int fid,
@@ -1747,9 +1745,9 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 		return -ENODEV;
 	}
 
-	id = nvme_identify_ns(ctrl, ns->head->ns_id);
-	if (!id)
-		return -ENODEV;
+	ret = nvme_identify_ns(ctrl, ns->head->ns_id, &id);
+	if (ret)
+		return ret;
 
 	if (id->ncap == 0) {
 		ret = -ENODEV;
@@ -3336,11 +3334,9 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
 	nvme_set_queue_limits(ctrl, ns->queue);
 
-	id = nvme_identify_ns(ctrl, nsid);
-	if (!id) {
-		ret = -EIO;
+	ret = nvme_identify_ns(ctrl, nsid, &id);
+	if (ret)
 		goto out_free_queue;
-	}
 
 	if (id->ncap == 0) {
 		ret = -EINVAL;
-- 
2.17.1
