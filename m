From: jsmart2021@gmail.com (James Smart)
Date: Fri, 11 May 2018 16:22:29 -0700
Subject: [PATCH v2] nvme: continue keep alive on error
Message-ID: <20180511232229.18929-1-jsmart2021@gmail.com>

Currently, if the keep_alive command failed, an error message is
generated and keep alive is stopped. This guarantees the target will
eventually not see a keep_alive in a KATO window and fail.

The keep_alive command may complete in error in cases where the
transport or lldd are temporarily out of resources. As such, the
command should be retried rather than letting the controller die.

If the command completes in error, retry another one after a short
delay. Track whether keep alive has had an error to reduce printing
the error message to the first failure only.

Signed-off-by: James Smart <james.smart at broadcom.com>

---
v2: add ka_error so that info print isn't 4 times a second for
  a repeating error.
---
 drivers/nvme/host/core.c | 17 +++++++++++------
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7a39ce8d9d5e..6eb36fdf91be 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -791,17 +791,21 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 static void nvme_keep_alive_end_io(struct request *rq, blk_status_t status)
 {
 	struct nvme_ctrl *ctrl = rq->end_io_data;
+	unsigned long delay = ctrl->kato * HZ;
 
 	blk_mq_free_request(rq);
 
 	if (status) {
-		dev_err(ctrl->device,
-			"failed nvme_keep_alive_end_io error=%d\n",
-				status);
-		return;
-	}
+		if (!ctrl->ka_error)
+			dev_info(ctrl->device,
+				"failed nvme_keep_alive_end_io error=%d, "
+				"retrying\n", status);
+		ctrl->ka_error = true;
+		delay = (HZ / 4);	/* 250ms */
+	} else
+		ctrl->ka_error = false;
 
-	schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
+	schedule_delayed_work(&ctrl->ka_work, delay);
 }
 
 static int nvme_keep_alive(struct nvme_ctrl *ctrl)
@@ -839,6 +843,7 @@ static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)
 	if (unlikely(ctrl->kato == 0))
 		return;
 
+	ctrl->ka_error = false;
 	schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7ded7a51c430..af65cc540776 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -178,6 +178,7 @@ struct nvme_ctrl {
 	u32 aen_result;
 	unsigned int shutdown_timeout;
 	unsigned int kato;
+	bool ka_error;
 	bool subsystem;
 	unsigned long quirks;
 	struct nvme_id_power_state psd[32];
-- 
2.13.1
