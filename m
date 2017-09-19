From: jsmart2021@gmail.com (James Smart)
Date: Tue, 19 Sep 2017 14:02:10 -0700
Subject: [PATCH] nvme_fc: add message on final controller removal
Message-ID: <20170919210210.20201-1-jsmart2021@gmail.com>

Given disparity between class level delete and transport delete,
add an info message when the transport controller object deletes.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 2748a84cec3a..c70aa0975361 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1817,6 +1817,8 @@ nvme_fc_ctrl_free(struct kref *ref)
 		container_of(ref, struct nvme_fc_ctrl, ref);
 	unsigned long flags;
 
+	dev_info(ctrl->dev, "NVME-FC{%d}: Controller Removed\n", ctrl->cnum);
+
 	if (ctrl->ctrl.tagset) {
 		blk_cleanup_queue(ctrl->ctrl.connect_q);
 		blk_mq_free_tag_set(&ctrl->tag_set);
-- 
2.13.1
