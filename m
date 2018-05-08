From: jsmart2021@gmail.com (James Smart)
Date: Mon,  7 May 2018 17:12:10 -0700
Subject: [PATCH 3/7] nvme_fc: retry failures to set io queue count
In-Reply-To: <20180508001214.8951-1-jsmart2021@gmail.com>
References: <20180508001214.8951-1-jsmart2021@gmail.com>
Message-ID: <20180508001214.8951-4-jsmart2021@gmail.com>

During the creation of a new controller association, it's possible for
errors and link connectivity issues to cause nvme_set_queue_count() to
have its SET_FEATURES command fail with a positive non-zero code. The
routine doesn't treat this as a hard error, instead setting the io queue
count to zero and returning success.  This has the result of the
transport setting the io queue count to 0, making the storage controller
inoperable. The message "...Could not set queue count..." is seen.

Revise the fc transport to detect when it asked for io queues but got
back a result of 0 io queues. In such a case, fail the re-connection
attempt and fall into the retry loop.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 7e64fe69c945..69299bda7cb2 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2414,16 +2414,17 @@ static int
 nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 {
 	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
-	unsigned int nr_io_queues;
+	unsigned int nr_io_queues, numq;
 	int ret;
 
 	nr_io_queues = min(min(opts->nr_io_queues, num_online_cpus()),
 				ctrl->lport->ops->max_hw_queues);
+	numq = nr_io_queues;
 	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
-	if (ret) {
+	if (ret || (numq && !nr_io_queues)) {
 		dev_info(ctrl->ctrl.device,
 			"set_queue_count failed: %d\n", ret);
-		return ret;
+		return ret ? ret : -ENOTCONN;
 	}
 
 	ctrl->ctrl.queue_count = nr_io_queues + 1;
@@ -2486,16 +2487,17 @@ static int
 nvme_fc_reinit_io_queues(struct nvme_fc_ctrl *ctrl)
 {
 	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
-	unsigned int nr_io_queues;
+	unsigned int nr_io_queues, numq;
 	int ret;
 
 	nr_io_queues = min(min(opts->nr_io_queues, num_online_cpus()),
 				ctrl->lport->ops->max_hw_queues);
+	numq = nr_io_queues;
 	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
-	if (ret) {
+	if (ret || (numq && !nr_io_queues)) {
 		dev_info(ctrl->ctrl.device,
 			"set_queue_count failed: %d\n", ret);
-		return ret;
+		return ret ? ret : -ENOTCONN;
 	}
 
 	ctrl->ctrl.queue_count = nr_io_queues + 1;
-- 
2.13.1
