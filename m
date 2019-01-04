From: keith.busch@intel.com (Keith Busch)
Date: Fri,  4 Jan 2019 15:04:33 -0700
Subject: [PATCH] nvme/pci: Rerun irq setup on IO queue init errors
Message-ID: <20190104220433.12835-1-keith.busch@intel.com>

If the driver is unable to create a subset of IO queues for any reason,
the read/write and polled queue sets will not match the actual allocated
hardware contexts. This leaves gaps in the CPU affinity mappings and
causes the following kernel panic after blk_mq_map_queue_type() returns
a NULL hctx.

  BUG: unable to handle kernel NULL pointer dereference at 0000000000000198
  #PF error: [normal kernel read fault]
  PGD 0 P4D 0
  Oops: 0000 [#1] SMP
  CPU: 64 PID: 1171 Comm: kworker/u259:1 Not tainted 4.20.0+ #241
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-2.fc27 04/01/2014
  Workqueue: nvme-wq nvme_scan_work [nvme_core]
  RIP: 0010:blk_mq_init_allocated_queue+0x2d9/0x440
  RSP: 0018:ffffb1bf0abc3cd0 EFLAGS: 00010286
  RAX: 000000000000001f RBX: ffff8ea744cf0718 RCX: 0000000000000000
  RDX: 0000000000000002 RSI: 000000000000007c RDI: ffffffff9109a820
  RBP: ffff8ea7565f7008 R08: 000000000000001f R09: 000000000000003f
  R10: ffffb1bf0abc3c00 R11: 0000000000000000 R12: 000000000001d008
  R13: ffff8ea7565f7008 R14: 000000000000003f R15: 0000000000000001
  FS:  0000000000000000(0000) GS:ffff8ea757200000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000198 CR3: 0000000013058000 CR4: 00000000000006e0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   blk_mq_init_queue+0x35/0x60
   nvme_validate_ns+0xc6/0x7c0 [nvme_core]
   ? nvme_identify_ctrl.isra.56+0x7e/0xc0 [nvme_core]
   nvme_scan_work+0xc8/0x340 [nvme_core]
   ? __wake_up_common+0x6d/0x120
   ? try_to_wake_up+0x55/0x410
   process_one_work+0x1e9/0x3d0
   worker_thread+0x2d/0x3d0
   ? process_one_work+0x3d0/0x3d0
   kthread+0x111/0x130
   ? kthread_park+0x90/0x90
   ret_from_fork+0x1f/0x30
  Modules linked in: nvme nvme_core serio_raw
  CR2: 0000000000000198

Fix by re-running the interrupt vector setup from scratch using a reduced
count that may be successful until the created queues matches the irq
affinity plus polling queue sets.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
Discussed in previous patch here:

  http://lists.infradead.org/pipermail/linux-nvme/2019-January/021956.html


 drivers/nvme/host/pci.c | 50 +++++++++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 98332d0a80f0..49cdb3a23487 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -95,6 +95,7 @@ struct nvme_dev;
 struct nvme_queue;
 
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
+static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode);
 
 /*
  * Represents an NVM Express device.  Each nvme_dev is a PCI function.
@@ -1420,6 +1421,14 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 	return 0;
 }
 
+static void nvme_suspend_io_queues(struct nvme_dev *dev)
+{
+	int i;
+
+	for (i = dev->ctrl.queue_count - 1; i > 0; i--)
+		nvme_suspend_queue(&dev->queues[i]);
+}
+
 static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
 {
 	struct nvme_queue *nvmeq = &dev->queues[0];
@@ -2132,6 +2141,12 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 	return result;
 }
 
+static void nvme_disable_io_queues(struct nvme_dev *dev)
+{
+	if (__nvme_disable_io_queues(dev, nvme_admin_delete_sq))
+		__nvme_disable_io_queues(dev, nvme_admin_delete_cq);
+}
+
 static int nvme_setup_io_queues(struct nvme_dev *dev)
 {
 	struct nvme_queue *adminq = &dev->queues[0];
@@ -2168,6 +2183,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	} while (1);
 	adminq->q_db = dev->dbs;
 
+ retry:
 	/* Deregister the admin queue's interrupt */
 	pci_free_irq(pdev, 0, adminq);
 
@@ -2185,25 +2201,34 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	result = max(result - 1, 1);
 	dev->max_qid = result + dev->io_queues[HCTX_TYPE_POLL];
 
-	dev_info(dev->ctrl.device, "%d/%d/%d default/read/poll queues\n",
-					dev->io_queues[HCTX_TYPE_DEFAULT],
-					dev->io_queues[HCTX_TYPE_READ],
-					dev->io_queues[HCTX_TYPE_POLL]);
-
 	/*
 	 * Should investigate if there's a performance win from allocating
 	 * more queues than interrupt vectors; it might allow the submission
 	 * path to scale better, even if the receive path is limited by the
 	 * number of interrupts.
 	 */
-
 	result = queue_request_irq(adminq);
 	if (result) {
 		adminq->cq_vector = -1;
 		return result;
 	}
 	set_bit(NVMEQ_ENABLED, &adminq->flags);
-	return nvme_create_io_queues(dev);
+
+	result = nvme_create_io_queues(dev);
+	if (result || dev->online_queues < 2)
+		return result;
+
+	if (dev->online_queues - 1 < dev->max_qid) {
+		nr_io_queues = dev->online_queues - 1;
+		nvme_disable_io_queues(dev);
+		nvme_suspend_io_queues(dev);
+		goto retry;
+	}
+	dev_info(dev->ctrl.device, "%d/%d/%d default/read/poll queues\n",
+					dev->io_queues[HCTX_TYPE_DEFAULT],
+					dev->io_queues[HCTX_TYPE_READ],
+					dev->io_queues[HCTX_TYPE_POLL]);
+	return 0;
 }
 
 static void nvme_del_queue_end(struct request *req, blk_status_t error)
@@ -2248,7 +2273,7 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 	return 0;
 }
 
-static bool nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode)
+static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode)
 {
 	int nr_queues = dev->online_queues - 1, sent = 0;
 	unsigned long timeout;
@@ -2407,7 +2432,6 @@ static void nvme_pci_disable(struct nvme_dev *dev)
 
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 {
-	int i;
 	bool dead = true;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
@@ -2434,13 +2458,11 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	nvme_stop_queues(&dev->ctrl);
 
 	if (!dead && dev->ctrl.queue_count > 0) {
-		if (nvme_disable_io_queues(dev, nvme_admin_delete_sq))
-			nvme_disable_io_queues(dev, nvme_admin_delete_cq);
+		nvme_disable_io_queues(dev);
 		nvme_disable_admin_queue(dev, shutdown);
 	}
-	for (i = dev->ctrl.queue_count - 1; i >= 0; i--)
-		nvme_suspend_queue(&dev->queues[i]);
-
+	nvme_suspend_io_queues(dev);
+	nvme_suspend_queue(&dev->queues[0]);
 	nvme_pci_disable(dev);
 
 	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_request, &dev->ctrl);
-- 
2.14.4
