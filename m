From: jsmart2021@gmail.com (James Smart)
Date: Tue, 27 Nov 2018 17:04:44 -0800
Subject: [PATCH v2] nvme: validate controller state before rescheduling keep
 alive
Message-ID: <20181128010444.8747-1-jsmart2021@gmail.com>

Delete operations are seeing NULL pointer references in call_timer_fn.
Tracking these back, the timer appears to be the keep alive timer.

nvme_keep_alive_work() which is tied to the timer that is cancelled
by nvme_stop_keep_alive(), simply starts the keep alive io but doesn't
wait for it's completion. So nvme_stop_keep_alive() only stops a timer
when it's pending. When a keep alive is in flight, there is no timer
running and the nvme_stop_keep_alive() will have no affect on the keep
alive io. Thus, if the io completes successfully, the keep alive timer
will be rescheduled.   In the failure case, delete is called, the
controller state is changed, the nvme_stop_keep_alive() is called while
the io is outstanding, and the delete path continues on. The keep
alive happens to successfully complete before the delete paths mark it
as aborted as part of the queue termination, so the timer is restarted.
The delete paths then tear down the controller, and later on the timer
code fires and the timer entry is now corrupt.

Fix by validating the controller state before rescheduling the keep
alive. Testing with the fix has confirmed the condition above was hit.

Signed-off-by: James Smart <jsmart2021 at gmail.com>

---
v2:
  added locking around controller state check. Could have used rmb
  and wmb, but this isn't a performance condition.
---
 drivers/nvme/host/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bb39b91253c2..7c2184fa2917 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -831,6 +831,8 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 static void nvme_keep_alive_end_io(struct request *rq, blk_status_t status)
 {
 	struct nvme_ctrl *ctrl = rq->end_io_data;
+	unsigned long flags;
+	bool startka = false;
 
 	blk_mq_free_request(rq);
 
@@ -841,7 +843,13 @@ static void nvme_keep_alive_end_io(struct request *rq, blk_status_t status)
 		return;
 	}
 
-	schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
+	spin_lock_irqsave(&ctrl->lock, flags);
+	if (ctrl->state == NVME_CTRL_LIVE ||
+	    ctrl->state == NVME_CTRL_CONNECTING)
+		startka = true;
+	spin_unlock_irqrestore(&ctrl->lock, flags);
+	if (startka)
+		schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
 }
 
 static int nvme_keep_alive(struct nvme_ctrl *ctrl)
-- 
2.13.7
