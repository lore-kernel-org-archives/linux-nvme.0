From: jsmart2021@gmail.com (James Smart)
Date: Thu, 11 Jan 2018 14:29:22 -0800
Subject: [PATCH] nvme_fc: fix rogue admin cmds stalling teardown
Message-ID: <20180111222922.3332-1-jsmart2021@gmail.com>

When connectivity is lost to a device, the association is terminated
and the blk-mq queues are quiesced/stopped. When connectivity is
re-established, they are resumed.

If an admin command is received while connectivity is list, the ioctl
queues the command on the admin_q and the command stalls (the thread
issuing the ioctl hangs/waits). if the connectivity is lost long
enough such that the controller is then deleted, the delete code
makes its calls to initiate the delete, which then expects the core
layer to call the transport when all references are removed and the
controller can be freed.  Unfortunately, nothing in this path dequeued
the admin command, so a reference sits outstanding and things stop,
hanging the delete indefinitely.

Correct by unquiescing the admin queue in the delete association. This
means any admin command (which should only be from an ioctl) issued
after connectivity is lost will detect the controller is in a
reconnecting state and will (fast) fail the command. Thus, a pending
reference can no longer be created.  Once connectivity is re-established,
a new ioctl/admin command would see proper device state and function again.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 306aee47c8ce..fe98e994498c 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2921,6 +2921,9 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 	__nvme_fc_delete_hw_queue(ctrl, &ctrl->queues[0], 0);
 	nvme_fc_free_queue(&ctrl->queues[0]);
 
+	/* re-enable the admin_q so anything new can fast fail */
+	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
+
 	nvme_fc_ctlr_inactive_on_rport(ctrl);
 }
 
-- 
2.13.1
