From: rakesh@tuxera.com (Rakesh Pandit)
Date: Tue, 30 May 2017 10:16:12 +0300
Subject: [PATCH V2] nvme: fix nvme_remove going to uninterruptible sleep for
 ever
Message-ID: <20170530071610.GA2679@hercules.tuxera.com>

Once controller is in DEAD or DELETING state a call to delete_destroy
from nvme_uninit_ctrl results in setting the latency tolerance via
nvme_set_latency_tolerance callback even though queues have already
been killed.  This in turn leads the PID to go into uninterruptible
sleep and prevents removal of nvme controller from completion.  The
stack trace is:

[<ffffffff813c9716>] blk_execute_rq+0x56/0x80
[<ffffffff815cb6e9>] __nvme_submit_sync_cmd+0x89/0xf0
[<ffffffff815ce7be>] nvme_set_features+0x5e/0x90
[<ffffffff815ce9f6>] nvme_configure_apst+0x166/0x200
[<ffffffff815cef45>] nvme_set_latency_tolerance+0x35/0x50
[<ffffffff8157bd11>] apply_constraint+0xb1/0xc0
[<ffffffff8157cbb4>] dev_pm_qos_constraints_destroy+0xf4/0x1f0
[<ffffffff8157b44a>] dpm_sysfs_remove+0x2a/0x60
[<ffffffff8156d951>] device_del+0x101/0x320
[<ffffffff8156db8a>] device_unregister+0x1a/0x60
[<ffffffff8156dc4c>] device_destroy+0x3c/0x50
[<ffffffff815cd295>] nvme_uninit_ctrl+0x45/0xa0
[<ffffffff815d4858>] nvme_remove+0x78/0x110
[<ffffffff81452b69>] pci_device_remove+0x39/0xb0
[<ffffffff81572935>] device_release_driver_internal+0x155/0x210
[<ffffffff81572a02>] device_release_driver+0x12/0x20
[<ffffffff815d36fb>] nvme_remove_dead_ctrl_work+0x6b/0x70
[<ffffffff810bf3bc>] process_one_work+0x18c/0x3a0
[<ffffffff810bf61e>] worker_thread+0x4e/0x3b0
[<ffffffff810c5ac9>] kthread+0x109/0x140
[<ffffffff8185800c>] ret_from_fork+0x2c/0x40
[<ffffffffffffffff>] 0xffffffffffffffff

and PID is in 'D' state.  Attached patch returns from
nvme_configure_apst to avoids configuration and syncing commands when
controller is either in DELETING state or DEAD state which can only
happen once we are in nvme_remove.  This allows removal to complete
and release remaining resources after nvme_uninit_ctrl.

V2: Move the check to nvme_configure_apst instead of callback
(suggested by Christoph)
Fixes: c5552fde102fc ("nvme: Enable autonomous power state transitions")
Signed-off-by: Rakesh Pandit <rakesh at tuxera.com>
---
 drivers/nvme/host/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a609264..8dfe854 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1357,6 +1357,13 @@ static void nvme_configure_apst(struct nvme_ctrl *ctrl)
 	int ret;
 
 	/*
+	 * Avoid configuration and syncing commands if controller is already
+	 * being removed and queues have been killed.
+	 */
+	if (ctrl->state == NVME_CTRL_DELETING || ctrl->state == NVME_CTRL_DEAD)
+		return;
+
+	/*
 	 * If APST isn't supported or if we haven't been initialized yet,
 	 * then don't do anything.
 	 */
-- 
2.9.3
