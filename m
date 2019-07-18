From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 18 Jul 2019 16:51:32 -0600
Subject: [PATCH 2/2] nvme-core: Fix deadlock when deleting the ctrl while
 scanning
In-Reply-To: <20190718225132.5865-1-logang@deltatee.com>
References: <20190718225132.5865-1-logang@deltatee.com>
Message-ID: <20190718225132.5865-2-logang@deltatee.com>

With multipath enabled, nvme_scan_work() can read from the
device (through nvme_mpath_add_disk()). However, with fabrics,
once ctrl->state is set to NVME_CTRL_DELETING, the reads will hang
(see nvmf_check_ready()).

After setting the state to deleting, nvme_remove_namespaces() will
hang waiting for scan_work to flush and these tasks will hang.

To fix this, ensure we take scan_lock before changing the ctrl-state.
Also, ensure the state is checked while the lock is held
in nvme_scan_lock_work().

  INFO: task kworker/u4:3:166 blocked for more than 120 seconds.
        Not tainted 5.2.0-rc6-vmlocalyes-00005-g808c8c2dc0cf #316
  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  kworker/u4:3    D    0   166      2 0x80004000
  Workqueue: nvme-wq nvme_scan_work
  Call Trace:
   __schedule+0x851/0x1400
   schedule+0x99/0x210
   io_schedule+0x21/0x70
   do_read_cache_page+0xa57/0x1330
   read_cache_page+0x4a/0x70
   read_dev_sector+0xbf/0x380
   amiga_partition+0xc4/0x1230
   check_partition+0x30f/0x630
   rescan_partitions+0x19a/0x980
   __blkdev_get+0x85a/0x12f0
   blkdev_get+0x2a5/0x790
   __device_add_disk+0xe25/0x1250
   device_add_disk+0x13/0x20
   nvme_mpath_set_live+0x172/0x2b0
   nvme_update_ns_ana_state+0x130/0x180
   nvme_set_ns_ana_state+0x9a/0xb0
   nvme_parse_ana_log+0x1c3/0x4a0
   nvme_mpath_add_disk+0x157/0x290
   nvme_validate_ns+0x1017/0x1bd0
   nvme_scan_work+0x44d/0x6a0
   process_one_work+0x7d7/0x1240
   worker_thread+0x8e/0xff0
   kthread+0x2c3/0x3b0
   ret_from_fork+0x35/0x40

   INFO: task kworker/u4:1:1034 blocked for more than 120 seconds.
        Not tainted 5.2.0-rc6-vmlocalyes-00005-g808c8c2dc0cf #316
  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  kworker/u4:1    D    0  1034      2 0x80004000
  Workqueue: nvme-delete-wq nvme_delete_ctrl_work
  Call Trace:
   __schedule+0x851/0x1400
   schedule+0x99/0x210
   schedule_timeout+0x390/0x830
   wait_for_completion+0x1a7/0x310
   __flush_work+0x241/0x5d0
   flush_work+0x10/0x20
   nvme_remove_namespaces+0x85/0x3d0
   nvme_do_delete_ctrl+0xb4/0x1e0
   nvme_delete_ctrl_work+0x15/0x20
   process_one_work+0x7d7/0x1240
   worker_thread+0x8e/0xff0
   kthread+0x2c3/0x3b0
   ret_from_fork+0x35/0x40

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 drivers/nvme/host/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3ca33a2714e5..0a7b46066fe3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -301,6 +301,9 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	unsigned long flags;
 	bool changed = false;
 
+	/* Ensure a scan isn't in progress when we change the state */
+	mutex_lock(&ctrl->scan_lock);
+
 	spin_lock_irqsave(&ctrl->lock, flags);
 
 	old_state = ctrl->state;
@@ -375,6 +378,8 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		ctrl->state = new_state;
 
 	spin_unlock_irqrestore(&ctrl->lock, flags);
+	mutex_unlock(&ctrl->scan_lock);
+
 	if (changed && ctrl->state == NVME_CTRL_LIVE)
 		nvme_kick_requeue_lists(ctrl);
 	return changed;
@@ -3534,6 +3539,8 @@ static void nvme_scan_work(struct work_struct *work)
 	struct nvme_id_ctrl *id;
 	unsigned nn;
 
+	mutex_lock(&ctrl->scan_lock);
+
 	if (ctrl->state != NVME_CTRL_LIVE)
 		return;
 
@@ -3547,7 +3554,6 @@ static void nvme_scan_work(struct work_struct *work)
 	if (nvme_identify_ctrl(ctrl, &id))
 		return;
 
-	mutex_lock(&ctrl->scan_lock);
 	nn = le32_to_cpu(id->nn);
 	if (ctrl->vs >= NVME_VS(1, 1, 0) &&
 	    !(ctrl->quirks & NVME_QUIRK_IDENTIFY_CNS)) {
-- 
2.20.1
