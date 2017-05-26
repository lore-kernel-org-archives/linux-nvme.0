From: rakesh@tuxera.com (Rakesh Pandit)
Date: Fri, 26 May 2017 23:13:53 +0300
Subject: [PATCH V3] nvme: fix multiple ctrl removal scheduling
Message-ID: <20170526201351.GA21847@dhcp-216.srv.tuxera.com>

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

V3:
 - Use new state NVME_CTRL_SCHED_RESET for synchronization (Keith Busch)
 - Fix nvme_probe and keep WARN_ON in nvme_reset_work (Christoph Hellwig)
V2: Use controller state to solve the problem (Christoph Hellwig)
Fixes: c5f6ce97c1210 ("nvme: don't schedule multiple resets")
Signed-off-by: Rakesh Pandit <rakesh at tuxera.com>
---
 drivers/nvme/host/core.c | 12 +++++++++++-
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  | 12 +++++++++---
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d5e0906..8a9ee6d 100644
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
@@ -1895,6 +1904,7 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
 	static const char *const state_name[] = {
 		[NVME_CTRL_NEW]		= "new",
 		[NVME_CTRL_LIVE]	= "live",
+		[NVME_CTRL_SCHED_RESET] = "sched_reset",
 		[NVME_CTRL_RESETTING]	= "resetting",
 		[NVME_CTRL_RECONNECTING]= "reconnecting",
 		[NVME_CTRL_DELETING]	= "deleting",
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 29c708c..57802a2 100644
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
index 4c2ff2b..2dc5d30 100644
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
@@ -2137,6 +2142,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
 
+	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_SCHED_RESET);
 	queue_work(nvme_workq, &dev->reset_work);
 	return 0;
 
-- 
2.5.5
