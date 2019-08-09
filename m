From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri,  9 Aug 2019 15:12:07 -0700
Subject: [PATCH v5 3/7] nvme: make nvme_identify_ns propagate errors back
In-Reply-To: <20190809221211.21157-1-sagi@grimberg.me>
References: <20190809221211.21157-1-sagi@grimberg.me>
Message-ID: <20190809221211.21157-4-sagi@grimberg.me>

right now callers of nvme_identify_ns only know that it failed,
but don't know why. Make nvme_identify_ns propagate the error back.
Note that if the return status from nvme_submit_sync_cmd() is positive
then we convert it from a blk_status_t to a negative errno.

Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cba0008dab5a..c01610733c20 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1110,13 +1110,16 @@ static struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
 
 	id = kmalloc(sizeof(*id), GFP_KERNEL);
 	if (!id)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	error = nvme_submit_sync_cmd(ctrl->admin_q, &c, id, sizeof(*id));
 	if (error) {
 		dev_warn(ctrl->device, "Identify namespace failed (%d)\n", error);
 		kfree(id);
-		return NULL;
+		if (error > 0)
+			return ERR_PTR(blk_status_to_errno(error));
+		else
+			return ERR_PTR(error);
 	}
 
 	return id;
@@ -1750,8 +1753,8 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	}
 
 	id = nvme_identify_ns(ctrl, ns->head->ns_id);
-	if (!id)
-		return -ENODEV;
+	if (IS_ERR(id))
+		return PTR_ERR(id);
 
 	if (id->ncap == 0) {
 		ret = -ENODEV;
@@ -3339,8 +3342,8 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	nvme_set_queue_limits(ctrl, ns->queue);
 
 	id = nvme_identify_ns(ctrl, nsid);
-	if (!id) {
-		ret = -EIO;
+	if (IS_ERR(id)) {
+		ret = PTR_ERR(id);
 		goto out_free_queue;
 	}
 
-- 
2.17.1
