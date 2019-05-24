From: keith.busch@intel.com (Keith Busch)
Date: Fri, 24 May 2019 14:20:36 -0600
Subject: [PATCH 3/3] nvme: quiesce admin queue for fw activation
In-Reply-To: <20190524202036.17265-1-keith.busch@intel.com>
References: <20190524202036.17265-1-keith.busch@intel.com>
Message-ID: <20190524202036.17265-4-keith.busch@intel.com>

From: Keith Busch <kbusch@kernel.org>

The controller's admin queue processing is paused during firmware
activation, just like IO queues. Quiesce these, and inform the syslog
this uncommon event is happening.

Signed-off-by: Keith Busch <kbusch at kernel.org>
---
 drivers/nvme/host/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 96dac2292897..5a6d27823f7f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3604,7 +3604,10 @@ static void nvme_fw_act_work(struct work_struct *work)
 		fw_act_timeout = jiffies +
 				msecs_to_jiffies(admin_timeout * 1000);
 
+	dev_info(ctrl->device, "processing paused for fw activation\n");
 	nvme_stop_queues(ctrl);
+	blk_mq_quiesce_queue(ctrl->admin_q);
+
 	while (nvme_ctrl_pp_status(ctrl)) {
 		if (time_after(jiffies, fw_act_timeout)) {
 			dev_warn(ctrl->device,
@@ -3619,7 +3622,10 @@ static void nvme_fw_act_work(struct work_struct *work)
 	    ctrl->state != NVME_CTRL_ADMIN_ONLY)
 		return;
 
+	dev_info(ctrl->device, "processing resumed\n");
+	blk_mq_unquiesce_queue(ctrl->admin_q);
 	nvme_start_queues(ctrl);
+
 	/* read FW slot information to clear the AER */
 	nvme_get_fw_slot_info(ctrl);
 }
-- 
2.14.4
