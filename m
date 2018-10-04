From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu,  4 Oct 2018 14:23:25 -0700
Subject: [PATCH rfc 2/3] nvme: enable aen also for discovery controllers
In-Reply-To: <20181004212328.30205-1-sagi@grimberg.me>
References: <20181004212328.30205-1-sagi@grimberg.me>
Message-ID: <20181004212328.30205-3-sagi@grimberg.me>

If the controller supports discovery log page change events,
we want to enable it on the host side as well.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index de745f94b698..efdbfc07de32 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1089,6 +1089,8 @@ static void nvme_enable_aen(struct nvme_ctrl *ctrl)
 	if (!supported_aens)
 		return;
 
+	queue_work(nvme_wq, &ctrl->async_event_work);
+
 	status = nvme_set_features(ctrl, NVME_FEAT_ASYNC_EVENT, supported_aens,
 			NULL, 0, &result);
 	if (status)
@@ -3489,10 +3491,13 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 	if (ctrl->kato)
 		nvme_start_keep_alive(ctrl);
 
+	if (ctrl->queue_count > 1 ||
+	    (ctrl->ops->flags & NVME_F_FABRICS &&
+	     ctrl->opts->discovery_nqn))
+		nvme_enable_aen(ctrl);
+
 	if (ctrl->queue_count > 1) {
 		nvme_queue_scan(ctrl);
-		nvme_enable_aen(ctrl);
-		queue_work(nvme_wq, &ctrl->async_event_work);
 		nvme_start_queues(ctrl);
 	}
 }
-- 
2.17.1
