From: jsmart2021@gmail.com (James Smart)
Date: Wed,  9 May 2018 14:25:43 -0700
Subject: [PATCH] nvme: continue keep alive on error
Message-ID: <20180509212543.5169-1-jsmart2021@gmail.com>

Currently, if the keep_alive command failed, an error message is
generated and keep alive is stopped. This guarantees the target will
eventually not see a keep_alive in a KATO window and fail.

The keep_alive command may complete in error in cases where the
transport or lldd are temporarily out of resources. As such, the
command should be retried rather than letting the controller die.

If the command completes in error, retry another one after a short
delay.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f3779f350769..6f1b2502fc1c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -791,17 +791,18 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 static void nvme_keep_alive_end_io(struct request *rq, blk_status_t status)
 {
 	struct nvme_ctrl *ctrl = rq->end_io_data;
+	unsigned long delay = ctrl->kato * HZ;
 
 	blk_mq_free_request(rq);
 
 	if (status) {
-		dev_err(ctrl->device,
-			"failed nvme_keep_alive_end_io error=%d\n",
+		dev_info(ctrl->device,
+			"failed nvme_keep_alive_end_io error=%d, retrying\n",
 				status);
-		return;
+		delay = (HZ / 4);	/* 250ms */
 	}
 
-	schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
+	schedule_delayed_work(&ctrl->ka_work, delay);
 }
 
 static int nvme_keep_alive(struct nvme_ctrl *ctrl)
-- 
2.13.1
