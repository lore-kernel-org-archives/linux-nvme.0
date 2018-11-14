From: jsmart2021@gmail.com (James Smart)
Date: Wed, 14 Nov 2018 15:12:04 -0800
Subject: [PATCH] nvme: validate controller state before rescheduling keep alive
Message-ID: <20181114231204.5996-1-jsmart2021@gmail.com>

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
 drivers/nvme/host/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fe957166c4a9..deb047514408 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -843,7 +843,9 @@ static void nvme_keep_alive_end_io(struct request *rq, blk_status_t status)
 	}
 
 	ctrl->comp_seen = false;
-	schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
+	if (ctrl->state == NVME_CTRL_LIVE ||
+	    ctrl->state == NVME_CTRL_CONNECTING)
+		schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
 }
 
 static int nvme_keep_alive(struct nvme_ctrl *ctrl)
-- 
2.13.7
