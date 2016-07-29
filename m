From: krisman@linux.vnet.ibm.com (Gabriel Krisman Bertazi)
Date: Fri, 29 Jul 2016 14:15:57 -0300
Subject: [PATCH] nvme: Suspend all queues before deletion
Message-ID: <1469812557-9809-1-git-send-email-krisman@linux.vnet.ibm.com>

When nvme_delete_queue fails in the first pass of the
nvme_disable_io_queues() loop, we return early, failing to suspend all
of the IO queues.  Later, on the nvme_pci_disable path, this causes us
to disable MSI without actually having freed all the IRQs, which
triggers the BUG_ON in free_msi_irqs(), as show below.

This patch refactors nvme_disable_io_queues to suspend all queues before
start submitting delete queue commands.  This way, we ensure that we
have at least returned every IRQ before continuing with the removal
path.

[  487.529200] kernel BUG at ../drivers/pci/msi.c:368!
cpu 0x46: Vector: 700 (Program Check) at [c0000078c5b83650]
    pc: c000000000627a50: free_msi_irqs+0x90/0x200
    lr: c000000000627a40: free_msi_irqs+0x80/0x200
    sp: c0000078c5b838d0
   msr: 9000000100029033
  current = 0xc0000078c5b40000
  paca    = 0xc000000002bd7600   softe: 0        irq_happened: 0x01
    pid   = 1376, comm = kworker/70:1H
kernel BUG at ../drivers/pci/msi.c:368!
Linux version 4.7.0.mainline+ (root at iod76) (gcc version 5.3.1 20160413
(Ubuntu/IBM 5.3.1-14ubuntu2.1) ) #104 SMP Fri Jul 29 09:20:17 CDT 2016
enter ? for help
[c0000078c5b83920] d0000000363b0cd8 nvme_dev_disable+0x208/0x4f0 [nvme]
[c0000078c5b83a10] d0000000363b12a4 nvme_timeout+0xe4/0x250 [nvme]
[c0000078c5b83ad0] c0000000005690e4 blk_mq_rq_timed_out+0x64/0x110
[c0000078c5b83b40] c00000000056c930 bt_for_each+0x160/0x170
[c0000078c5b83bb0] c00000000056d928 blk_mq_queue_tag_busy_iter+0x78/0x110
[c0000078c5b83c00] c0000000005675d8 blk_mq_timeout_work+0xd8/0x1b0
[c0000078c5b83c50] c0000000000e8cf0 process_one_work+0x1e0/0x590
[c0000078c5b83ce0] c0000000000e9148 worker_thread+0xa8/0x660
[c0000078c5b83d80] c0000000000f2090 kthread+0x110/0x130
[c0000078c5b83e30] c0000000000095f0 ret_from_kernel_thread+0x5c/0x6c

Signed-off-by: Gabriel Krisman Bertazi <krisman at linux.vnet.ibm.com>
Cc: Brian King <brking at linux.vnet.ibm.com>
Cc: Keith Busch <keith.busch at intel.com>
Cc: linux-nvme at lists.infradead.org
---
 drivers/nvme/host/pci.c | 48 +++++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4cb9b15..c4e8cc1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1533,33 +1533,35 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 
 static void nvme_disable_io_queues(struct nvme_dev *dev)
 {
-	int pass, queues = dev->online_queues - 1;
+	int i, queues = dev->online_queues - 1;
 	unsigned long timeout;
-	u8 opcode = nvme_admin_delete_sq;
+	int sent = 0;
 
-	for (pass = 0; pass < 2; pass++) {
-		int sent = 0, i = queues;
+	reinit_completion(&dev->ioq_wait);
+	for (i = queues; i > 0; i--)
+		nvme_suspend_queue(dev->queues[i]);
 
-		reinit_completion(&dev->ioq_wait);
- retry:
-		timeout = ADMIN_TIMEOUT;
-		for (; i > 0; i--) {
-			struct nvme_queue *nvmeq = dev->queues[i];
+	for (i = queues; i > 0; i--) {
+retry_sq:
+		if (nvme_delete_queue(dev->queues[i], nvme_admin_delete_sq))
+			break;
+		sent++;
+retry_cq:
+		if (nvme_delete_queue(dev->queues[i], nvme_admin_delete_cq))
+			break;
+		sent++;
+	}
 
-			if (!pass)
-				nvme_suspend_queue(nvmeq);
-			if (nvme_delete_queue(nvmeq, opcode))
-				break;
-			++sent;
-		}
-		while (sent--) {
-			timeout = wait_for_completion_io_timeout(&dev->ioq_wait, timeout);
-			if (timeout == 0)
-				return;
-			if (i)
-				goto retry;
-		}
-		opcode = nvme_admin_delete_cq;
+	timeout = ADMIN_TIMEOUT;
+	while (sent--) {
+		timeout = wait_for_completion_io_timeout(&dev->ioq_wait,
+							 timeout);
+		if (timeout == 0)
+			break;
+		if (i && i % 2 == 0)
+			goto retry_sq;
+		else if (i)
+			goto retry_cq;
 	}
 }
 
-- 
2.7.4
