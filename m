From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 10 Apr 2018 20:18:08 +0300
Subject: [PATCH v1 4/5] nvme-fc: add keep-alive mechanism as admin_q property
In-Reply-To: <1523380689-17151-1-git-send-email-maxg@mellanox.com>
References: <1523380689-17151-1-git-send-email-maxg@mellanox.com>
Message-ID: <1523380689-17151-5-git-send-email-maxg@mellanox.com>

Activate/deactivate it during admin queue creation/destruction
and remove association to nvme ctrl.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/fc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 0676d44..236a8f1 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2692,6 +2692,8 @@ static inline blk_status_t nvme_fc_is_ready(struct nvme_fc_queue *queue,
 		opts->queue_size = ctrl->ctrl.maxcmd;
 	}
 
+	nvme_start_keep_alive(&ctrl->ctrl);
+
 	ret = nvme_fc_init_aen_ops(ctrl);
 	if (ret)
 		goto out_term_aen_ops;
@@ -2720,6 +2722,7 @@ static inline blk_status_t nvme_fc_is_ready(struct nvme_fc_queue *queue,
 
 out_term_aen_ops:
 	nvme_fc_term_aen_ops(ctrl);
+	nvme_stop_keep_alive(&ctrl->ctrl);
 out_disconnect_admin_queue:
 	/* send a Disconnect(association) LS to fc-nvme target */
 	nvme_fc_xmt_disconnect_assoc(ctrl);
@@ -2804,6 +2807,8 @@ static inline blk_status_t nvme_fc_is_ready(struct nvme_fc_queue *queue,
 
 	nvme_fc_term_aen_ops(ctrl);
 
+	nvme_stop_keep_alive(&ctrl->ctrl);
+
 	/*
 	 * send a Disconnect(association) LS to fc-nvme target
 	 * Note: could have been sent at top of process, but
-- 
1.8.3.1
