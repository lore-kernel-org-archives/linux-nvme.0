From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Fri, 12 Aug 2016 17:04:51 -0700
Subject: [PATCH v1 4/5] nvme-loop: set sqsize to 0-based value, per spec
In-Reply-To: <1471046692-15978-1-git-send-email-james_p_freyensee@linux.intel.com>
References: <1471046692-15978-1-git-send-email-james_p_freyensee@linux.intel.com>
Message-ID: <1471046692-15978-5-git-send-email-james_p_freyensee@linux.intel.com>

Signed-off-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
---
 drivers/nvme/target/loop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 94e7829..ce22d4b0 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -558,7 +558,7 @@ static int nvme_loop_create_io_queues(struct nvme_loop_ctrl *ctrl)
 
 	memset(&ctrl->tag_set, 0, sizeof(ctrl->tag_set));
 	ctrl->tag_set.ops = &nvme_loop_mq_ops;
-	ctrl->tag_set.queue_depth = ctrl->ctrl.sqsize;
+	ctrl->tag_set.queue_depth = ctrl->ctrl.sqsize + 1;
 	ctrl->tag_set.reserved_tags = 1; /* fabric connect */
 	ctrl->tag_set.numa_node = NUMA_NO_NODE;
 	ctrl->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
@@ -622,7 +622,7 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 
 	ret = -ENOMEM;
 
-	ctrl->ctrl.sqsize = opts->queue_size;
+	ctrl->ctrl.sqsize = opts->queue_size - 1;
 	ctrl->ctrl.kato = opts->kato;
 
 	ctrl->queues = kcalloc(opts->nr_io_queues + 1, sizeof(*ctrl->queues),
-- 
2.7.4
