From: hare@suse.de (Hannes Reinecke)
Date: Thu,  7 Jun 2018 09:35:56 +0200
Subject: [PATCH 4/4] nvme: start ANATT timer on out-of-order state changes
In-Reply-To: <20180607073556.39050-1-hare@suse.de>
References: <20180607073556.39050-1-hare@suse.de>
Message-ID: <20180607073556.39050-5-hare@suse.de>

If I/O is terminated due to an invalid ANA state we should be starting
the ANATT timer as we really should have received an ANA AEN signalling
the state change.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/multipath.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 7a37f5959ad4..7f34ae260ca9 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -49,7 +49,10 @@ static void nvme_update_ana_state(struct nvme_ns *ns, enum nvme_ana_state state)
 void nvme_failover_req(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
+	struct device *dev = disk_to_dev(ns->disk);
 	unsigned long flags;
+	enum nvme_ana_state ana_state;
+	bool ana_state_changed = false;
 
 	spin_lock_irqsave(&ns->head->requeue_lock, flags);
 	blk_steal_bios(&ns->head->requeue_list, req);
@@ -60,26 +63,45 @@ void nvme_failover_req(struct request *req)
 	 * Reset the controller for any non-ANA error as we don't know what
 	 * caused the error:
 	 */
+	ana_state = READ_ONCE(ns->ctrl->ana_state[ns->anagrpid]);
 	switch (nvme_req(req)->status & 0x7ff) {
 	case NVME_SC_ANA_TRANSITION:
-		nvme_update_ana_state(ns, NVME_ANA_CHANGE);
-		if (!timer_pending(&ns->anatt_timer)) {
-			ns->anatt_timer.expires =
-				ns->ctrl->anatt * HZ + jiffies;
-			add_timer(&ns->anatt_timer);
+		if (ana_state != NVME_ANA_CHANGE) {
+			nvme_update_ana_state(ns, NVME_ANA_CHANGE);
+			ana_state_changed = true;
 		}
 		break;
 	case NVME_SC_ANA_PERSISTENT_LOSS:
-		nvme_update_ana_state(ns, NVME_ANA_PERSISTENT_LOSS);
+		if (ana_state != NVME_ANA_PERSISTENT_LOSS) {
+			nvme_update_ana_state(ns, NVME_ANA_PERSISTENT_LOSS);
+			ana_state_changed = true;
+		}
 		break;
 	case NVME_SC_ANA_INACCESSIBLE:
-		nvme_update_ana_state(ns, NVME_ANA_INACCESSIBLE);
+		if (ana_state != NVME_ANA_INACCESSIBLE) {
+			nvme_update_ana_state(ns, NVME_ANA_INACCESSIBLE);
+			ana_state_changed = true;
+		}
 		break;
 	default:
 		nvme_reset_ctrl(ns->ctrl);
 		break;
 	}
 
+	if (ana_state_changed) {
+		/*
+		 * We should have received an ANA AEN signalling the state
+		 * change. As we haven't (or we wouldn't ever reach here)
+		 * give it a benefit of doubt to start the ANATT timer
+		 * before resetting the controller.
+		 */
+		if (!timer_pending(&ns->anatt_timer)) {
+			ns->anatt_timer.expires =
+				ns->ctrl->anatt * HZ + jiffies;
+			add_timer(&ns->anatt_timer);
+		}
+	}
+
 	kblockd_schedule_work(&ns->head->requeue_work);
 }
 
-- 
2.12.3
