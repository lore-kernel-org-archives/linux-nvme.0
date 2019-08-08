From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu,  8 Aug 2019 16:25:32 -0700
Subject: [PATCH v4 3/7] nvme: make nvme_identify_ns propagate errors back
In-Reply-To: <20190808232536.4258-1-sagi@grimberg.me>
References: <20190808232536.4258-1-sagi@grimberg.me>
Message-ID: <20190808232536.4258-4-sagi@grimberg.me>

right now callers of nvme_identify_ns only know that it failed,
but don't know why. Make nvme_identify_ns propagate the error back.

Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c259586eeadc..6fac09b24733 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1108,13 +1108,13 @@ static struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
 
 	id = kmalloc(sizeof(*id), GFP_KERNEL);
 	if (!id)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	error = nvme_submit_sync_cmd(ctrl->admin_q, &c, id, sizeof(*id));
 	if (error) {
 		dev_warn(ctrl->device, "Identify namespace failed (%d)\n", error);
 		kfree(id);
-		return NULL;
+		return ERR_PTR(error);
 	}
 
 	return id;
@@ -1748,8 +1748,8 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	}
 
 	id = nvme_identify_ns(ctrl, ns->head->ns_id);
-	if (!id)
-		return -ENODEV;
+	if (IS_ERR(id))
+		return PTR_ERR(id);
 
 	if (id->ncap == 0) {
 		ret = -ENODEV;
@@ -3337,8 +3337,8 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
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
