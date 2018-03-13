From: jsmart2021@gmail.com (James Smart)
Date: Tue, 13 Mar 2018 09:48:07 -0700
Subject: [PATCH] nvme_fc: fix ctrl create failures racing with workq items
Message-ID: <20180313164807.8981-1-jsmart2021@gmail.com>

If there are errors during initial controller create, the transport
will teardown the partially initialized controller struct and free
the ctlr memory.  Trouble is - most of those errors can occur due
to asynchronous events happening such io timeouts and subsystem
connectivity failures. Those failures invoke async workq items to
reset the controller and attempt reconnect.  Those may be in progress
as the main thread frees the ctrl memory, resulting in NULL ptr oops.

Prevent this from happening by having the main ctrl failure thread
changing state to DELETING followed by synchronously cancelling any
pending queued work item. The change of state will prevent the
scheduling of resets or reconnect events.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b3ada7076801..eb378a5d452d 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3136,6 +3136,10 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	}
 
 	if (ret) {
+		nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING);
+		cancel_work_sync(&ctrl->ctrl.reset_work);
+		cancel_delayed_work_sync(&ctrl->connect_work);
+
 		/* couldn't schedule retry - fail out */
 		dev_err(ctrl->ctrl.device,
 			"NVME-FC{%d}: Connect retry failed\n", ctrl->cnum);
-- 
2.13.1
