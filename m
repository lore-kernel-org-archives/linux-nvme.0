From: jsmart2021@gmail.com (James Smart)
Date: Thu, 14 Sep 2017 11:03:09 -0700
Subject: [PATCH v2] nvme: stop aer posting if controller state not live
Message-ID: <20170914180309.20851-1-jsmart2021@gmail.com>

If an nvme async_event command completes, in most cases, a new
async event is posted. However, if the controller enters a
resetting or reconnecting state, there is nothing to block the
scheduled work element from posting the async event again. Nor are
there calls from the transport to stop async events when an
association dies.

In the case of FC, where the association is torn down, the aer must
be aborted on the FC link and completes through the normal job
completion path. Thus the terminated async event ends up being
rescheduled even though the controller isn't in a valid state for
the aer, and the reposting gets the transport into a partially torn
down data structure.

It's possible to hit the scenario on rdma, although much less likely
due to an aer completing right as the association is terminated and
as the association teardown reclaims the blk requests via
nvme_cancel_request() so its immediate, not a link-related action
like on FC.

Fix by putting controller state checks in both the async event
completion routine where it schedules the async event and in the
async event work routine before it calls into the transport. It's
effectively a "stop_async_events()" behavior.  The transport, when
it creates a new association with the subsystem will transition
the state back to live and is already restarting the async event
posting.

Signed-off-by: James Smart <james.smart at broadcom.com>

---
v2:
  rework if test into while stmt

 drivers/nvme/host/core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 90d09067a82a..fd1f489d4f9a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2588,7 +2588,7 @@ static void nvme_async_event_work(struct work_struct *work)
 		container_of(work, struct nvme_ctrl, async_event_work);
 
 	spin_lock_irq(&ctrl->lock);
-	while (ctrl->event_limit > 0) {
+	while (ctrl->state == NVME_CTRL_LIVE && ctrl->event_limit > 0) {
 		int aer_idx = --ctrl->event_limit;
 
 		spin_unlock_irq(&ctrl->lock);
@@ -2667,7 +2667,12 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		union nvme_result *res)
 {
 	u32 result = le32_to_cpu(res->u32);
-	bool done = true;
+	bool done = true, live = true;
+
+	spin_lock_irq(&ctrl->lock);
+	if (unlikely(ctrl->state != NVME_CTRL_LIVE))
+		live = false;
+	spin_unlock_irq(&ctrl->lock);
 
 	switch (le16_to_cpu(status) >> 1) {
 	case NVME_SC_SUCCESS:
@@ -2675,7 +2680,8 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		/*FALLTHRU*/
 	case NVME_SC_ABORT_REQ:
 		++ctrl->event_limit;
-		queue_work(nvme_wq, &ctrl->async_event_work);
+		if (live)
+			schedule_work(&ctrl->async_event_work);
 		break;
 	default:
 		break;
-- 
2.13.1
