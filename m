From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 29 Jun 2017 14:09:09 +0300
Subject: [PATCH 4/7] nvme-fc: don't override opts->nr_io_queues
In-Reply-To: <1498734552-14845-1-git-send-email-sagi@grimberg.me>
References: <1498734552-14845-1-git-send-email-sagi@grimberg.me>
Message-ID: <1498734552-14845-5-git-send-email-sagi@grimberg.me>

Its what the user passed, so its probably a better
idea to keep it intact. Also, limit the number of
I/O queues to max online cpus as blk-mq doesnt know
how to handle more anyhow.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/fc.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 2f990d979037..5ee821d9cb75 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2175,17 +2175,19 @@ static int
 nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 {
 	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
+	unsigned int nr_io_queues;
 	int ret;
 
-	ret = nvme_set_queue_count(&ctrl->ctrl, &opts->nr_io_queues);
+	nr_io_queues = min(opts->nr_io_queues, num_online_cpus());
+	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
 	if (ret) {
 		dev_info(ctrl->ctrl.device,
 			"set_queue_count failed: %d\n", ret);
 		return ret;
 	}
 
-	ctrl->ctrl.queue_count = opts->nr_io_queues + 1;
-	if (!opts->nr_io_queues)
+	ctrl->ctrl.queue_count = nr_io_queues + 1;
+	if (!nr_io_queues)
 		return 0;
 
 	nvme_fc_init_io_queues(ctrl);
@@ -2245,15 +2247,18 @@ static int
 nvme_fc_reinit_io_queues(struct nvme_fc_ctrl *ctrl)
 {
 	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
+	unsigned int nr_io_queues;
 	int ret;
 
-	ret = nvme_set_queue_count(&ctrl->ctrl, &opts->nr_io_queues);
+	nr_io_queues = min(opts->nr_io_queues, num_online_cpus());
+	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
 	if (ret) {
 		dev_info(ctrl->ctrl.device,
 			"set_queue_count failed: %d\n", ret);
 		return ret;
 	}
 
+	ctrl->ctrl.queue_count = nr_io_queues + 1;
 	/* check for io queues existing */
 	if (ctrl->ctrl.queue_count == 1)
 		return 0;
@@ -2702,7 +2707,6 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	ctrl->ctrl.queue_count = min_t(unsigned int,
 				opts->nr_io_queues,
 				lport->ops->max_hw_queues);
-	opts->nr_io_queues = ctrl->ctrl.queue_count;	/* so opts has valid value */
 	ctrl->ctrl.queue_count++;	/* +1 for admin queue */
 
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
-- 
2.7.4
