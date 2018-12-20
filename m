From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 20 Dec 2018 11:04:20 -0800
Subject: [PATCH] nvme-fc: flush err and connect work in .stop_ctrl
Message-ID: <20181220190420.23515-1-sagi@grimberg.me>

Controller op .stop_ctrl was designed to let the driver
quiesce any pending works that may be active before starting
the controller teardown (delete_ctrl).

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/fc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 89accc76d71c..bf2ddc6850af 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2802,12 +2802,19 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 }
 
 static void
-nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
+nvme_fc_stop_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 
 	cancel_work_sync(&ctrl->err_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
+}
+
+static void
+nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
+{
+	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
+
 	/*
 	 * kill the association on the link side.  this will block
 	 * waiting for io to terminate
@@ -2925,6 +2932,7 @@ static const struct nvme_ctrl_ops nvme_fc_ctrl_ops = {
 	.free_ctrl		= nvme_fc_nvme_ctrl_freed,
 	.submit_async_event	= nvme_fc_submit_async_event,
 	.delete_ctrl		= nvme_fc_delete_ctrl,
+	.stop_ctrl		= nvme_fc_stop_ctrl,
 	.get_address		= nvmf_get_address,
 };
 
-- 
2.17.1
