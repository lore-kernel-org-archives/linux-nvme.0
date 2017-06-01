From: hch@lst.de (Christoph Hellwig)
Date: Thu,  1 Jun 2017 16:06:29 +0200
Subject: [PATCH] nvme: fix multiple ctrl removal scheduling
In-Reply-To: <20170601140629.15313-1-hch@lst.de>
References: <20170601140629.15313-1-hch@lst.de>
Message-ID: <20170601140629.15313-2-hch@lst.de>

From: Rakesh Pandit <rakesh@tuxera.com>

Commit c5f6ce97c1210 tries to address multiple resets but fails as
work_busy doesn't involve any synchronization and can fail.  This is
reproducible easily as can be seen by WARNING below which is triggered
with line:

WARN_ON(dev->ctrl.state == NVME_CTRL_RESETTING)

Allowing multiple resets can result in multiple controller removal as
well if different conditions inside nvme_reset_work fail and which
might deadlock on device_release_driver.

This patch introduces new state called NVME_CTRL_SCHED_RESET and uses
it for synchronizing work queue addition (reset_work) as state change
uses controller spinlock.

[  480.327007] WARNING: CPU: 3 PID: 150 at drivers/nvme/host/pci.c:1900 nvme_reset_work+0x36c/0xec0
[  480.327008] Modules linked in: rfcomm fuse nf_conntrack_netbios_ns nf_conntrack_broadcast...
[  480.327044]  btusb videobuf2_core ghash_clmulni_intel snd_hwdep cfg80211 acer_wmi hci_uart..
[  480.327065] CPU: 3 PID: 150 Comm: kworker/u16:2 Not tainted 4.12.0-rc1+ #13
[  480.327065] Hardware name: Acer Predator G9-591/Mustang_SLS, BIOS V1.10 03/03/2016
[  480.327066] Workqueue: nvme nvme_reset_work
[  480.327067] task: ffff880498ad8000 task.stack: ffffc90002218000
[  480.327068] RIP: 0010:nvme_reset_work+0x36c/0xec0
[  480.327069] RSP: 0018:ffffc9000221bdb8 EFLAGS: 00010246
[  480.327070] RAX: 0000000000460000 RBX: ffff880498a98128 RCX: dead000000000200
[  480.327070] RDX: 0000000000000001 RSI: ffff8804b1028020 RDI: ffff880498a98128
[  480.327071] RBP: ffffc9000221be50 R08: 0000000000000000 R09: 0000000000000000
[  480.327071] R10: ffffc90001963ce8 R11: 000000000000020d R12: ffff880498a98000
[  480.327072] R13: ffff880498a53500 R14: ffff880498a98130 R15: ffff880498a98128
[  480.327072] FS:  0000000000000000(0000) GS:ffff8804c1cc0000(0000) knlGS:0000000000000000
[  480.327073] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  480.327074] CR2: 00007ffcf3c37f78 CR3: 0000000001e09000 CR4: 00000000003406e0
[  480.327074] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  480.327075] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  480.327075] Call Trace:
[  480.327079]  ? __switch_to+0x227/0x400
[  480.327081]  process_one_work+0x18c/0x3a0
[  480.327082]  worker_thread+0x4e/0x3b0
[  480.327084]  kthread+0x109/0x140
[  480.327085]  ? process_one_work+0x3a0/0x3a0
[  480.327087]  ? kthread_park+0x60/0x60
[  480.327102]  ret_from_fork+0x2c/0x40
[  480.327103] Code: e8 5a dc ff ff 85 c0 41 89 c1 0f.....

Fixes: c5f6ce97c1210 ("nvme: don't schedule multiple resets")
Signed-off-by: Rakesh Pandit <rakesh at tuxera.com>
[hch: also update the fabrics drivers]
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c   | 12 +++++++++++-
 drivers/nvme/host/fc.c     | 12 ++++++++----
 drivers/nvme/host/nvme.h   |  1 +
 drivers/nvme/host/pci.c    | 12 +++++++++---
 drivers/nvme/host/rdma.c   |  5 ++++-
 drivers/nvme/target/loop.c |  5 ++++-
 6 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a60926410438..0935dc08f46e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -161,7 +161,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 			break;
 		}
 		break;
-	case NVME_CTRL_RESETTING:
+	case NVME_CTRL_SCHED_RESET:
 		switch (old_state) {
 		case NVME_CTRL_NEW:
 		case NVME_CTRL_LIVE:
@@ -172,6 +172,15 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 			break;
 		}
 		break;
+	case NVME_CTRL_RESETTING:
+		switch (old_state) {
+		case NVME_CTRL_SCHED_RESET:
+			changed = true;
+			/* FALLTHRU */
+		default:
+			break;
+		}
+		break;
 	case NVME_CTRL_RECONNECTING:
 		switch (old_state) {
 		case NVME_CTRL_LIVE:
@@ -1907,6 +1916,7 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
 	static const char *const state_name[] = {
 		[NVME_CTRL_NEW]		= "new",
 		[NVME_CTRL_LIVE]	= "live",
+		[NVME_CTRL_SCHED_RESET] = "sched_reset",
 		[NVME_CTRL_RESETTING]	= "resetting",
 		[NVME_CTRL_RECONNECTING]= "reconnecting",
 		[NVME_CTRL_DELETING]	= "deleting",
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 5b14cbefb724..61d7746bbbc8 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1754,10 +1754,10 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 	if (ctrl->queue_count > 1)
 		nvme_stop_queues(&ctrl->ctrl);
 
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RECONNECTING)) {
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_SCHED_RESET)) {
 		dev_err(ctrl->ctrl.device,
 			"NVME-FC{%d}: error_recovery: Couldn't change state "
-			"to RECONNECTING\n", ctrl->cnum);
+			"to SCHED_RESET\n", ctrl->cnum);
 		return;
 	}
 
@@ -2578,7 +2578,7 @@ static void
 nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 {
 	/* If we are resetting/deleting then do nothing */
-	if (ctrl->ctrl.state != NVME_CTRL_RECONNECTING) {
+	if (ctrl->ctrl.state != NVME_CTRL_SCHED_RESET) {
 		WARN_ON_ONCE(ctrl->ctrl.state == NVME_CTRL_NEW ||
 			ctrl->ctrl.state == NVME_CTRL_LIVE);
 		return;
@@ -2613,6 +2613,10 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
 	/* will block will waiting for io to terminate */
 	nvme_fc_delete_association(ctrl);
 
+	if (WARN_ON_ONCE(!nvme_change_ctrl_state(&ctrl->ctrl,
+			NVME_CTRL_RESETTING)))
+		return;
+
 	ret = nvme_fc_create_association(ctrl);
 	if (ret)
 		nvme_fc_reconnect_or_delete(ctrl, ret);
@@ -2633,7 +2637,7 @@ nvme_fc_reset_nvme_ctrl(struct nvme_ctrl *nctrl)
 	dev_info(ctrl->ctrl.device,
 		"NVME-FC{%d}: admin requested controller reset\n", ctrl->cnum);
 
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_SCHED_RESET))
 		return -EBUSY;
 
 	if (!queue_work(nvme_fc_wq, &ctrl->reset_work))
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9d6a070d4391..4ca84b12df69 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -109,6 +109,7 @@ static inline struct nvme_request *nvme_req(struct request *req)
 enum nvme_ctrl_state {
 	NVME_CTRL_NEW,
 	NVME_CTRL_LIVE,
+	NVME_CTRL_SCHED_RESET,
 	NVME_CTRL_RESETTING,
 	NVME_CTRL_RECONNECTING,
 	NVME_CTRL_DELETING,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d52701df7245..5b460ce745f6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1366,7 +1366,12 @@ static bool nvme_should_reset(struct nvme_dev *dev, u32 csts)
 	 */
 	bool nssro = dev->subsystem && (csts & NVME_CSTS_NSSRO);
 
-	/* If there is a reset ongoing, we shouldn't reset again. */
+	/*
+	 * If there is a reset ongoing, we shouldn't reset again.  Even though
+	 * work_busy provides an advisory hint, nvme_reset is always called
+	 * after this and takes care of synchronization using controller state
+	 * change.
+	 */
 	if (work_busy(&dev->reset_work))
 		return false;
 
@@ -2009,8 +2014,8 @@ static int nvme_reset(struct nvme_dev *dev)
 {
 	if (!dev->ctrl.admin_q || blk_queue_dying(dev->ctrl.admin_q))
 		return -ENODEV;
-	if (work_busy(&dev->reset_work))
-		return -ENODEV;
+	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_SCHED_RESET))
+		return -EBUSY;
 	if (!queue_work(nvme_workq, &dev->reset_work))
 		return -EBUSY;
 	return 0;
@@ -2138,6 +2143,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
 
+	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_SCHED_RESET);
 	queue_work(nvme_workq, &dev->reset_work);
 	return 0;
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 28bd255c144d..aa3174afe73b 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1736,6 +1736,9 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 
 	nvme_rdma_shutdown_ctrl(ctrl);
 
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
+		goto del_dead_ctrl;
+
 	ret = nvme_rdma_configure_admin_queue(ctrl);
 	if (ret) {
 		/* ctrl is already shutdown, just remove the ctrl */
@@ -1778,7 +1781,7 @@ static int nvme_rdma_reset_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_SCHED_RESET))
 		return -EBUSY;
 
 	if (!queue_work(nvme_rdma_wq, &ctrl->reset_work))
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index e503cfff0337..de9c1d367d70 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -508,6 +508,9 @@ static void nvme_loop_reset_ctrl_work(struct work_struct *work)
 
 	nvme_loop_shutdown_ctrl(ctrl);
 
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
+		goto out_disable;
+
 	ret = nvme_loop_configure_admin_queue(ctrl);
 	if (ret)
 		goto out_disable;
@@ -544,7 +547,7 @@ static int nvme_loop_reset_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_loop_ctrl *ctrl = to_loop_ctrl(nctrl);
 
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_SCHED_RESET))
 		return -EBUSY;
 
 	if (!schedule_work(&ctrl->reset_work))
-- 
2.11.0
