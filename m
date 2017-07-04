From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue,  4 Jul 2017 10:57:32 +0300
Subject: [PATCH v2 4/8] nvme-fc: don't override opts->nr_io_queues
In-Reply-To: <1499155056-11241-1-git-send-email-sagi@grimberg.me>
References: <1499155056-11241-1-git-send-email-sagi@grimberg.me>
Message-ID: <1499155056-11241-5-git-send-email-sagi@grimberg.me>

Its what the user passed, so its probably a better
idea to keep it intact. Also, limit the number of
I/O queues to max online cpus and the lport maximum
hw queues.

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/fc.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 2f990d979037..996720043b3a 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2175,17 +2175,20 @@ static int
 nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 {
 	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
+	unsigned int nr_io_queues;
 	int ret;
 
-	ret = nvme_set_queue_count(&ctrl->ctrl, &opts->nr_io_queues);
+	nr_io_queues = min(min(opts->nr_io_queues, num_online_cpus()),
+				ctrl->lport->ops->max_hw_queues);
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
@@ -2245,15 +2248,19 @@ static int
 nvme_fc_reinit_io_queues(struct nvme_fc_ctrl *ctrl)
 {
 	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
+	unsigned int nr_io_queues;
 	int ret;
 
-	ret = nvme_set_queue_count(&ctrl->ctrl, &opts->nr_io_queues);
+	nr_io_queues = min(min(opts->nr_io_queues, num_online_cpus()),
+				ctrl->lport->ops->max_hw_queues);
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
@@ -2702,7 +2709,6 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	ctrl->ctrl.queue_count = min_t(unsigned int,
 				opts->nr_io_queues,
 				lport->ops->max_hw_queues);
-	opts->nr_io_queues = ctrl->ctrl.queue_count;	/* so opts has valid value */
 	ctrl->ctrl.queue_count++;	/* +1 for admin queue */
 
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
-- 
2.7.4
