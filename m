From: krisman@linux.vnet.ibm.com (Gabriel Krisman Bertazi)
Date: Tue, 02 Aug 2016 23:10:38 -0300
Subject: [PATCH v2] nvme: Suspend all queues before deletion
In-Reply-To: <20160802222340.GA28486@localhost.localdomain> (Keith Busch's
 message of "Tue, 2 Aug 2016 18:23:40 -0400")
References: <1469812557-9809-1-git-send-email-krisman@linux.vnet.ibm.com>
 <20160802222340.GA28486@localhost.localdomain>
Message-ID: <87h9b2k3fl.fsf_-_@linux.vnet.ibm.com>

Keith Busch <keith.busch at intel.com> writes:

> I see what this is fixing, and maybe this works for most controllers,
> but this isn't a spec compliant way to delete queues: "Host software
> shall ensure that any associated I/O Submission Queue is deleted prior
> to deleting a Completion Queue". The host can't know if the submission
> queue is deleted until it sees status the delete command.

Hi Keith,

Thanks for your review.  I see the problem you pointed out, I actually
had thought of that, but I assumed it wouldn't be a problem, as long as
we removed the corresponding SQ before the CQ.  My mistake.

> Maybe we should suspend queues unconditionally during disable?

Yes, that approach seems to be ok. Please take the tested v2 below, in
which I apply your suggestion, as well as clean up a bit the code in
nvme_disable_io_queues and simplify the logic a bit.

Thanks,

-- >8 --
Subject: [PATCH v2] nvme: Suspend all queues before deletion

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
 drivers/nvme/host/pci.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index befac5b..cf38fe4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1561,15 +1561,10 @@ static void nvme_disable_io_queues(struct nvme_dev *dev)
 		reinit_completion(&dev->ioq_wait);
  retry:
 		timeout = ADMIN_TIMEOUT;
-		for (; i > 0; i--) {
-			struct nvme_queue *nvmeq = dev->queues[i];
-
-			if (!pass)
-				nvme_suspend_queue(nvmeq);
-			if (nvme_delete_queue(nvmeq, opcode))
+		for (; i > 0; i--, sent++)
+			if (nvme_delete_queue(dev->queues[i], opcode))
 				break;
-			++sent;
-		}
+
 		while (sent--) {
 			timeout = wait_for_completion_io_timeout(&dev->ioq_wait, timeout);
 			if (timeout == 0)
@@ -1716,11 +1711,12 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 		nvme_stop_queues(&dev->ctrl);
 		csts = readl(dev->bar + NVME_REG_CSTS);
 	}
+
+	for (i = dev->queue_count - 1; i > 0; i--)
+		nvme_suspend_queue(dev->queues[i]);
+
 	if (csts & NVME_CSTS_CFS || !(csts & NVME_CSTS_RDY)) {
-		for (i = dev->queue_count - 1; i >= 0; i--) {
-			struct nvme_queue *nvmeq = dev->queues[i];
-			nvme_suspend_queue(nvmeq);
-		}
+		nvme_suspend_queue(dev->queues[0]);
 	} else {
 		nvme_disable_io_queues(dev);
 		nvme_disable_admin_queue(dev, shutdown);
-- 
2.7.4
