From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 19 Mar 2017 00:42:19 +0200
Subject: [PATCH 1/3] nvme-rdma: get rid of local reconnect_delay
In-Reply-To: <1489876941-6401-1-git-send-email-sagi@grimberg.me>
References: <1489876941-6401-1-git-send-email-sagi@grimberg.me>
Message-ID: <1489876941-6401-2-git-send-email-sagi@grimberg.me>

we already have it in opts.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index e1db1736823f..33f18636ea99 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -118,7 +118,6 @@ struct nvme_rdma_ctrl {
 
 	struct nvme_rdma_qe	async_event_sqe;
 
-	int			reconnect_delay;
 	struct delayed_work	reconnect_work;
 
 	struct list_head	list;
@@ -782,7 +781,7 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 		dev_info(ctrl->ctrl.device,
 			"Failed reconnect attempt, requeueing...\n");
 		queue_delayed_work(nvme_rdma_wq, &ctrl->reconnect_work,
-					ctrl->reconnect_delay * HZ);
+				ctrl->ctrl.opts->reconnect_delay * HZ);
 	}
 }
 
@@ -811,10 +810,10 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 				nvme_cancel_request, &ctrl->ctrl);
 
 	dev_info(ctrl->ctrl.device, "reconnecting in %d seconds\n",
-		ctrl->reconnect_delay);
+		ctrl->ctrl.opts->reconnect_delay);
 
 	queue_delayed_work(nvme_rdma_wq, &ctrl->reconnect_work,
-				ctrl->reconnect_delay * HZ);
+				ctrl->ctrl.opts->reconnect_delay * HZ);
 }
 
 static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
@@ -1918,7 +1917,6 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	if (ret)
 		goto out_free_ctrl;
 
-	ctrl->reconnect_delay = opts->reconnect_delay;
 	INIT_DELAYED_WORK(&ctrl->reconnect_work,
 			nvme_rdma_reconnect_ctrl_work);
 	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
-- 
2.7.4
