From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue,  1 Jan 2019 00:19:30 -0800
Subject: [PATCH] nvme: remove .stop_ctrl callout
Message-ID: <20190101081930.29589-1-sagi@grimberg.me>

It is used now just to flush error recovery and
reconnect works in rdma and tcp. These can simply
move to the corresponding teardown routines.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c |  2 --
 drivers/nvme/host/nvme.h |  1 -
 drivers/nvme/host/rdma.c | 12 +++---------
 drivers/nvme/host/tcp.c  | 10 +++-------
 4 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5181c6f9dae5..935592f74f06 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3599,8 +3599,6 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 	nvme_stop_keep_alive(ctrl);
 	flush_work(&ctrl->async_event_work);
 	cancel_work_sync(&ctrl->fw_act_work);
-	if (ctrl->ops->stop_ctrl)
-		ctrl->ops->stop_ctrl(ctrl);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_ctrl);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 970a6385a5b0..d062f7ede538 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -359,7 +359,6 @@ struct nvme_ctrl_ops {
 	void (*submit_async_event)(struct nvme_ctrl *ctrl);
 	void (*delete_ctrl)(struct nvme_ctrl *ctrl);
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
-	void (*stop_ctrl)(struct nvme_ctrl *ctrl);
 };
 
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 0a2fd2949ad7..e63f36c09c9a 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -928,14 +928,6 @@ static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
 	}
 }
 
-static void nvme_rdma_stop_ctrl(struct nvme_ctrl *nctrl)
-{
-	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
-
-	cancel_work_sync(&ctrl->err_work);
-	cancel_delayed_work_sync(&ctrl->reconnect_work);
-}
-
 static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
@@ -1832,6 +1824,9 @@ static const struct blk_mq_ops nvme_rdma_admin_mq_ops = {
 
 static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 {
+	cancel_work_sync(&ctrl->err_work);
+	cancel_delayed_work_sync(&ctrl->reconnect_work);
+
 	nvme_rdma_teardown_io_queues(ctrl, shutdown);
 	if (shutdown)
 		nvme_shutdown_ctrl(&ctrl->ctrl);
@@ -1880,7 +1875,6 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.submit_async_event	= nvme_rdma_submit_async_event,
 	.delete_ctrl		= nvme_rdma_delete_ctrl,
 	.get_address		= nvmf_get_address,
-	.stop_ctrl		= nvme_rdma_stop_ctrl,
 };
 
 /*
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index de174912445e..b9183c47dc89 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1826,6 +1826,9 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 
 static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 {
+	cancel_work_sync(&to_tcp_ctrl(ctrl)->err_work);
+	cancel_delayed_work_sync(&to_tcp_ctrl(ctrl)->connect_work);
+
 	nvme_tcp_teardown_io_queues(ctrl, shutdown);
 	if (shutdown)
 		nvme_shutdown_ctrl(ctrl);
@@ -1863,12 +1866,6 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 	nvme_tcp_reconnect_or_remove(ctrl);
 }
 
-static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
-{
-	cancel_work_sync(&to_tcp_ctrl(ctrl)->err_work);
-	cancel_delayed_work_sync(&to_tcp_ctrl(ctrl)->connect_work);
-}
-
 static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
@@ -2116,7 +2113,6 @@ static const struct nvme_ctrl_ops nvme_tcp_ctrl_ops = {
 	.submit_async_event	= nvme_tcp_submit_async_event,
 	.delete_ctrl		= nvme_tcp_delete_ctrl,
 	.get_address		= nvmf_get_address,
-	.stop_ctrl		= nvme_tcp_stop_ctrl,
 };
 
 static bool
-- 
2.17.1
