From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Mon, 28 Sep 2015 19:20:57 -0700
Subject: [PATCH 3/4] nvme: split pci specific functionality out of core code
Message-ID: <1443493257.3449.15.camel@linux.intel.com>

>From d4d0aa24c3e422dbf01b400b2992f76a7d7691b2 Mon Sep 17 00:00:00 2001
From: Jay Sternberg <jay.e.sternberg@intel.com>
Date: Mon, 28 Sep 2015 11:38:12 -0700
Subject: [PATCH 3/4] nvme: split pci specific functionality out of core
code

Signed-off-by: Jay Sternberg <jay.e.sternberg at intel.com>
---
 drivers/nvme/host/Kconfig  |   23 +-
 drivers/nvme/host/Makefile |   12 +
 drivers/nvme/host/core.c   |  852 ++++++------------------------------
----
 drivers/nvme/host/ops.h    |   56 +++
 drivers/nvme/host/pci.c    |  954
++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/scsi.c   |   17 +-
 6 files changed, 1169 insertions(+), 745 deletions(-)
 create mode 100644 drivers/nvme/host/ops.h
 create mode 100644 drivers/nvme/host/pci.c

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 4118c2e..2c7bc73 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -1,8 +1,6 @@
 config NVME_HOST
        tristate "NVM Express block device"
-       depends on NVME
-       depends on PCI
-       depends on BLOCK
+       depends on NVME && BLOCK
        ---help---
 	 The NVM Express driver is for solid state drives directly
 	 connected to the PCI or PCI Express bus.  If you know you
@@ -10,3 +8,22 @@ config NVME_HOST
 
 	 To compile this driver as a module, choose M here: the
 	 module will be called nvme.
+
+config NVME_INCLUDE_PCI
+       bool "Include Local PCIe Support"
+       depends on NVME_HOST && PCI
+       default y
+       ---help---
+	 The NVM Express driver is for solid state drives directly
+	 connected to the local PCI or PCI Express bus.  If you know
+	 you don't have one of these, it is safe to answer N.
+
+config NVME_PCI
+       tristate "PCI Support"
+       depends on NVME_INCLUDE_PCI
+       default y
+       ---help---
+	 choose y to have Local PCI support in the NVM Express module.
+	 choose m to have Local PCI support in a separate modules from
the
+	   NVM Express module.
+	   the module will be called nvme_pci.
diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index 10cf9a5..373cd73 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -1,3 +1,15 @@
 obj-$(CONFIG_NVME_HOST)		+= nvme.o
 
+ifeq ("$(CONFIG_NVME_PCI)","m")
+  obj-$(CONFIG_NVME_HOST)	+= nvme_pci.o
+endif
+
 nvme-y				:= core.o scsi.o
+
+ifeq ("$(CONFIG_NVME_PCI)","m")
+  nvme_pci-y			+= pci.o
+else
+  ifeq ("$(CONFIG_NVME_PCI)","y")
+    nvme-y			+= pci.o
+  endif
+endif
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dec3961..cda911f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1,6 +1,6 @@
 /*
  * NVM Express device driver
- * Copyright (c) 2011-2014, Intel Corporation.
+ * Copyright (c) 2011-2015, Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or
modify it
  * under the terms and conditions of the GNU General Public License,
@@ -13,7 +13,7 @@
  */
 
 #include "common.h"
-#include "pci.h"
+#include "ops.h"
 
 #include <linux/hdreg.h>
 #include <linux/interrupt.h>
@@ -25,10 +25,11 @@
 #include <linux/scatterlist.h>
 #include <linux/ptrace.h>
 #include <linux/t10-pi.h>
-#include <linux/delay.h>
-#include <linux/pci.h>
 #include <scsi/sg.h>
 
+#define NVME_MINORS		(1U << MINORBITS)
+#define ADMIN_TIMEOUT		(admin_timeout * HZ)
+
 static unsigned char admin_timeout = 60;
 module_param(admin_timeout, byte, 0644);
 MODULE_PARM_DESC(admin_timeout, "timeout in seconds for admin
commands");
@@ -37,34 +38,28 @@ unsigned char nvme_io_timeout = 30;
 module_param_named(io_timeout, nvme_io_timeout, byte, 0644);
 MODULE_PARM_DESC(io_timeout, "timeout in seconds for I/O");
 
-static unsigned char shutdown_timeout = 5;
-module_param(shutdown_timeout, byte, 0644);
-MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller
shutdown");
-
 static int nvme_major;
 module_param(nvme_major, int, 0);
 
 static int nvme_char_major;
 module_param(nvme_char_major, int, 0);
 
-static int use_threaded_interrupts;
-module_param(use_threaded_interrupts, int, 0);
-
-static bool use_cmb_sqes = true;
-module_param(use_cmb_sqes, bool, 0644);
-MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O
SQes");
-
 static DEFINE_SPINLOCK(dev_list_lock);
 static LIST_HEAD(dev_list);
 static struct task_struct *nvme_thread;
 static struct workqueue_struct *nvme_workq;
 static wait_queue_head_t nvme_kthread_wait;
+static int shutting_down;
 
 static struct class *nvme_class;
 
+#ifdef CONFIG_NVME_PCI
+int nvme_pci_init(void);
+void nvme_pci_exit(void);
+#endif
+
 static void nvme_reset_failed_dev(struct work_struct *ws);
 static int nvme_reset(struct nvme_dev *dev);
-static int nvme_process_cq(struct nvme_queue *nvmeq);
 
 /*
  * Check we didin't inadvertently grow the command struct
@@ -277,7 +272,7 @@ static void abort_completion(struct nvme_queue
*nvmeq, void *ctx,
 
 	blk_mq_free_request(req);
 
-	dev_warn(nvmeq->q_dmadev, "Abort status:%x result:%x", status,
result);
+	dev_warn(nvmeq->q_dmadev, "Abort status:%x result:%x\n",
status, result);
 	++nvmeq->dev->abort_limit;
 }
 
@@ -329,7 +324,6 @@ static void *nvme_finish_cmd(struct nvme_queue
*nvmeq, int tag,
 static void __nvme_submit_cmd(struct nvme_queue *nvmeq,
 						struct nvme_command
*cmd)
 {
-	struct nvme_pci_queue *q = (struct nvme_pci_queue *) nvmeq
->context;
 	u16 tail = nvmeq->sq_tail;
 
 	if (nvmeq->sq_cmds_io)
@@ -339,8 +333,9 @@ static void __nvme_submit_cmd(struct nvme_queue
*nvmeq,
 
 	if (++tail == nvmeq->q_depth)
 		tail = 0;
-	writel(tail, q->q_db);
+
 	nvmeq->sq_tail = tail;
+	nvme_pci_submit_sync_cmd(nvmeq, cmd);
 }
 
 static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct
nvme_command *cmd)
@@ -381,10 +376,10 @@ __nvme_alloc_iod(unsigned nseg, unsigned bytes,
struct nvme_dev *dev,
 }
 
 static struct nvme_iod *nvme_alloc_iod(struct request *rq, struct
nvme_dev *dev,
-			               gfp_t gfp)
+				       gfp_t gfp)
 {
 	unsigned size = !(rq->cmd_flags & REQ_DISCARD) ?
blk_rq_bytes(rq) :
-                                                sizeof(struct
nvme_dsm_range);
+				sizeof(struct nvme_dsm_range);
 	struct nvme_iod *iod;
 
 	if (rq->nr_phys_segments <= NVME_INT_PAGES &&
@@ -841,7 +836,7 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx
*hctx,
 			goto retry_cmd;
 
 		if (blk_rq_bytes(req) !=
-                    nvme_setup_prps(dev, iod, blk_rq_bytes(req),
GFP_ATOMIC)) {
+		    nvme_setup_prps(dev, iod, blk_rq_bytes(req),
GFP_ATOMIC)) {
 			dma_unmap_sg(dev->dev, iod->sg, iod->nents,
dma_dir);
 			goto retry_cmd;
 		}
@@ -885,11 +880,8 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx
*hctx,
 	return BLK_MQ_RQ_QUEUE_BUSY;
 }
 
-static int nvme_process_cq(struct nvme_queue *nvmeq)
+int nvme_process_cq(struct nvme_queue *nvmeq)
 {
-	struct nvme_pci_queue *q = (struct nvme_pci_queue *) nvmeq
->context;
-	struct nvme_dev *dev = nvmeq->dev;
-        struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
 	u16 head, phase;
 
 	head = nvmeq->cq_head;
@@ -919,34 +911,15 @@ static int nvme_process_cq(struct nvme_queue
*nvmeq)
 	if (head == nvmeq->cq_head && phase == nvmeq->cq_phase)
 		return 0;
 
-	writel(head, q->q_db + pdev->db_stride);
+	nvme_pci_process_cq(nvmeq, head);
+
 	nvmeq->cq_head = head;
 	nvmeq->cq_phase = phase;
 
 	nvmeq->cqe_seen = 1;
 	return 1;
 }
-
-static irqreturn_t nvme_irq(int irq, void *data)
-{
-	irqreturn_t result;
-	struct nvme_queue *nvmeq = data;
-	spin_lock(&nvmeq->q_lock);
-	nvme_process_cq(nvmeq);
-	result = nvmeq->cqe_seen ? IRQ_HANDLED : IRQ_NONE;
-	nvmeq->cqe_seen = 0;
-	spin_unlock(&nvmeq->q_lock);
-	return result;
-}
-
-static irqreturn_t nvme_irq_check(int irq, void *data)
-{
-	struct nvme_queue *nvmeq = data;
-	struct nvme_completion cqe = nvmeq->cqes[nvmeq->cq_head];
-	if ((le16_to_cpu(cqe.status) & 1) != nvmeq->cq_phase)
-		return IRQ_NONE;
-	return IRQ_WAKE_THREAD;
-}
+EXPORT_SYMBOL_GPL(nvme_process_cq);
 
 /*
  * Returns 0 on success.  If the result is negative, it's a Linux
error code;
@@ -1135,6 +1108,7 @@ int nvme_identify_ctrl(struct nvme_dev *dev,
struct nvme_id_ctrl **id)
 		kfree(*id);
 	return error;
 }
+EXPORT_SYMBOL_GPL(nvme_identify_ctrl);
 
 int nvme_identify_ns(struct nvme_dev *dev, unsigned nsid,
 		struct nvme_id_ns **id)
@@ -1143,8 +1117,8 @@ int nvme_identify_ns(struct nvme_dev *dev,
unsigned nsid,
 	int error;
 
 	/* gcc-4.4.4 (at least) has issues with initializers and anon
unions */
-	c.identify.opcode = nvme_admin_identify,
-	c.identify.nsid = cpu_to_le32(nsid),
+	c.identify.opcode = nvme_admin_identify;
+	c.identify.nsid = cpu_to_le32(nsid);
 
 	*id = kmalloc(sizeof(struct nvme_id_ns), GFP_KERNEL);
 	if (!*id)
@@ -1341,7 +1315,6 @@ static void nvme_free_queues(struct nvme_dev
*dev, int lowest)
 static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 {
 	struct nvme_dev *dev = nvmeq->dev;
-        struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
 	int vector;
 
 	spin_lock_irq(&nvmeq->q_lock);
@@ -1349,7 +1322,7 @@ static int nvme_suspend_queue(struct nvme_queue
*nvmeq)
 		spin_unlock_irq(&nvmeq->q_lock);
 		return 1;
 	}
-	vector = pdev->entry[nvmeq->cq_vector].vector;
+	vector = nvme_pci_get_vector(nvmeq);
 	dev->online_queues--;
 	nvmeq->cq_vector = -1;
 	spin_unlock_irq(&nvmeq->q_lock);
@@ -1357,8 +1330,7 @@ static int nvme_suspend_queue(struct nvme_queue
*nvmeq)
 	if (!nvmeq->qid && dev->admin_q)
 		blk_mq_freeze_queue_start(dev->admin_q);
 
-	irq_set_affinity_hint(vector, NULL);
-	free_irq(vector, nvmeq);
+	nvme_pci_suspend_queue(nvmeq, vector);
 
 	return 0;
 }
@@ -1374,7 +1346,6 @@ static void nvme_clear_queue(struct nvme_queue
*nvmeq)
 static void nvme_disable_queue(struct nvme_dev *dev, int qid)
 {
 	struct nvme_queue *nvmeq = dev->queues[qid];
-        struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
 
 	if (!nvmeq)
 		return;
@@ -1383,7 +1354,7 @@ static void nvme_disable_queue(struct nvme_dev
*dev, int qid)
 
 	/* Don't tell the adapter to delete the admin queue.
 	 * Don't tell a removed adapter to delete IO queues. */
-	if (qid && readl(&pdev->bar->csts) != -1) {
+	if (qid && nvme_pci_is_active(dev)) {
 		adapter_delete_sq(dev, qid);
 		adapter_delete_cq(dev, qid);
 	}
@@ -1393,83 +1364,30 @@ static void nvme_disable_queue(struct nvme_dev
*dev, int qid)
 	spin_unlock_irq(&nvmeq->q_lock);
 }
 
-static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
-				int entry_size)
-{
-	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
-	int q_depth = dev->q_depth;
-	unsigned q_size_aligned = roundup(q_depth * entry_size, dev
->page_size);
-
-	if (q_size_aligned * nr_io_queues > pdev->cmb_size) {
-		u64 mem_per_q = div_u64(pdev->cmb_size, nr_io_queues);
-		mem_per_q = round_down(mem_per_q, dev->page_size);
-		q_depth = div_u64(mem_per_q, entry_size);
-
-		/*
-		 * Ensure the reduced q_depth is above some threshold
where it
-		 * would be better to map queues in system memory with
the
-		 * original depth
-		 */
-		if (q_depth < 64)
-			return -ENOMEM;
-	}
-
-	return q_depth;
-}
-
 static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue
*nvmeq,
 				int qid, int depth)
 {
-	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
-
-	if (qid && pdev->cmb && use_cmb_sqes && NVME_CMB_SQS(pdev
->cmbsz)) {
-		unsigned offset = (qid - 1) *
-					roundup(SQ_SIZE(depth), dev
->page_size);
-		nvmeq->sq_dma_addr = pdev->cmb_dma_addr + offset;
-		nvmeq->sq_cmds_io = pdev->cmb + offset;
-	} else {
-		nvmeq->sq_cmds = dma_alloc_coherent(dev->dev,
SQ_SIZE(depth),
-					&nvmeq->sq_dma_addr,
GFP_KERNEL);
-		if (!nvmeq->sq_cmds)
-			return -ENOMEM;
-	}
-
 	return 0;
 }
 
 static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int
qid,
 							int depth)
 {
-	struct nvme_queue *nvmeq;
-	struct nvme_pci_queue *q;
-	struct nvme_pci_dev *pdev;
-
-	nvmeq = kzalloc(sizeof(*nvmeq), GFP_KERNEL);
+	struct nvme_queue *nvmeq = kzalloc(sizeof(*nvmeq),
GFP_KERNEL);
 	if (!nvmeq)
 		return NULL;
 
-	q = kzalloc(sizeof(*q), GFP_KERNEL);
-	if (!q)
-		goto free_nvmeq;
-
-	nvmeq->context = q;
-
-	pdev = kzalloc(sizeof(*q), GFP_KERNEL);
-	if (!pdev)
-		goto free_pci_queue;
-
-	dev->context = pdev;
-
 	nvmeq->cqes = dma_zalloc_coherent(dev->dev, CQ_SIZE(depth),
 					  &nvmeq->cq_dma_addr,
GFP_KERNEL);
 	if (!nvmeq->cqes)
-		goto free_pci_dev;
+		goto free_nvmeq;
 
 	if (nvme_alloc_sq_cmds(dev, nvmeq, qid, depth))
 		goto free_cqdma;
 
 	nvmeq->q_dmadev = dev->dev;
 	nvmeq->dev = dev;
+
 	spin_lock_init(&nvmeq->q_lock);
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
@@ -1478,9 +1396,8 @@ static struct nvme_queue *nvme_alloc_queue(struct
nvme_dev *dev, int qid,
 	nvmeq->cq_vector = -1;
 	dev->queues[qid] = nvmeq;
 
-	q->q_db = &pdev->dbs[qid * 2 * pdev->db_stride];
-	snprintf(q->irqname, sizeof(q->irqname), "nvme%dq%d",
-			dev->instance, qid);
+	/* added call for setting irqname and q_db */
+	nvme_pci_alloc_queue(nvmeq);
 
 	/* make sure queue descriptor is set before queue count, for
kthread */
 	mb();
@@ -1491,40 +1408,22 @@ static struct nvme_queue
*nvme_alloc_queue(struct nvme_dev *dev, int qid,
  free_cqdma:
 	dma_free_coherent(dev->dev, CQ_SIZE(depth), (void *)nvmeq
->cqes,
 							nvmeq
->cq_dma_addr);
- free_pci_dev:
-	kfree(pdev);
- free_pci_queue:
-	kfree(q);
  free_nvmeq:
 	kfree(nvmeq);
 	return NULL;
 }
 
-static int queue_request_irq(struct nvme_dev *dev, struct nvme_queue
*nvmeq,
-							const char
*name)
-{
-	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
-
-	if (use_threaded_interrupts)
-		return request_threaded_irq(pdev->entry[nvmeq
->cq_vector].vector,
-					nvme_irq_check, nvme_irq,
IRQF_SHARED,
-					name, nvmeq);
-	return request_irq(pdev->entry[nvmeq->cq_vector].vector,
nvme_irq,
-				IRQF_SHARED, name, nvmeq);
-}
 
 static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 {
 	struct nvme_dev *dev = nvmeq->dev;
-	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
-	struct nvme_pci_queue *q = (struct nvme_pci_queue *) nvmeq
->context;
 
 	spin_lock_irq(&nvmeq->q_lock);
 	nvmeq->sq_tail = 0;
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
 
-	q->q_db = &pdev->dbs[qid * 2 * pdev->db_stride];
+	nvme_pci_init_queue(nvmeq);
 
 	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq->q_depth));
 	dev->online_queues++;
@@ -1533,7 +1432,6 @@ static void nvme_init_queue(struct nvme_queue
*nvmeq, u16 qid)
 
 static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 {
-	struct nvme_pci_queue *q = (struct nvme_pci_queue *) nvmeq
->context;
 	struct nvme_dev *dev = nvmeq->dev;
 	int result;
 
@@ -1546,8 +1444,8 @@ static int nvme_create_queue(struct nvme_queue
*nvmeq, int qid)
 	if (result < 0)
 		goto release_cq;
 
-	result = queue_request_irq(dev, nvmeq, q->irqname);
-	if (result < 0)
+	result = nvme_pci_create_queue(nvmeq);
+	if (result)
 		goto release_sq;
 
 	nvme_init_queue(nvmeq, qid);
@@ -1560,83 +1458,6 @@ static int nvme_create_queue(struct nvme_queue
*nvmeq, int qid)
 	return result;
 }
 
-static int nvme_wait_ready(struct nvme_dev *dev, u64 cap, bool
enabled)
-{
-	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
-	unsigned long timeout;
-	u32 bit = enabled ? NVME_CSTS_RDY : 0;
-
-	timeout = ((NVME_CAP_TIMEOUT(cap) + 1) * HZ / 2) + jiffies;
-
-	while ((readl(&pdev->bar->csts) & NVME_CSTS_RDY) != bit) {
-		msleep(100);
-		if (fatal_signal_pending(current))
-			return -EINTR;
-		if (time_after(jiffies, timeout)) {
-			dev_err(dev->dev,
-				"Device not ready; aborting %s\n",
enabled ?
-						"initialisation" :
"reset");
-			return -ENODEV;
-		}
-	}
-
-	return 0;
-}
-
-/*
- * If the device has been passed off to us in an enabled state, just
clear
- * the enabled bit.  The spec says we should set the 'shutdown
notification
- * bits', but doing so may cause the device to complete commands to
the
- * admin queue ... and we don't know what memory that might be
pointing at!
- */
-static int nvme_disable_ctrl(struct nvme_dev *dev, u64 cap)
-{
-	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
-
-	pdev->ctrl_config &= ~NVME_CC_SHN_MASK;
-	pdev->ctrl_config &= ~NVME_CC_ENABLE;
-	writel(pdev->ctrl_config, &pdev->bar->cc);
-
-	return nvme_wait_ready(dev, cap, false);
-}
-
-static int nvme_enable_ctrl(struct nvme_dev *dev, u64 cap)
-{
-	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
-
-	pdev->ctrl_config &= ~NVME_CC_SHN_MASK;
-	pdev->ctrl_config |= NVME_CC_ENABLE;
-	writel(pdev->ctrl_config, &pdev->bar->cc);
-
-	return nvme_wait_ready(dev, cap, true);
-}
-
-static int nvme_shutdown_ctrl(struct nvme_dev *dev)
-{
-	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
-	unsigned long timeout;
-
-	pdev->ctrl_config &= ~NVME_CC_SHN_MASK;
-	pdev->ctrl_config |= NVME_CC_SHN_NORMAL;
-
-	writel(pdev->ctrl_config, &pdev->bar->cc);
-
-	timeout = SHUTDOWN_TIMEOUT + jiffies;
-	while ((readl(&pdev->bar->csts) & NVME_CSTS_SHST_MASK) !=
-							NVME_CSTS_SHST
_CMPLT) {
-		msleep(100);
-		if (fatal_signal_pending(current))
-			return -EINTR;
-		if (time_after(jiffies, timeout)) {
-			dev_err(dev->dev,
-				"Device shutdown incomplete; abort
shutdown\n");
-			return -ENODEV;
-		}
-	}
-
-	return 0;
-}
-
 static struct blk_mq_ops nvme_mq_admin_ops = {
 	.queue_rq	= nvme_queue_rq,
 	.map_queue	= blk_mq_map_queue,
@@ -1695,40 +1516,8 @@ static int nvme_alloc_admin_tags(struct nvme_dev
*dev)
 
 static int nvme_configure_admin_queue(struct nvme_dev *dev)
 {
-	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
-	struct nvme_pci_queue *q;
 	int result;
-	u32 aqa;
-	u64 cap = readq(&pdev->bar->cap);
 	struct nvme_queue *nvmeq;
-	unsigned page_shift = PAGE_SHIFT;
-	unsigned dev_page_min = NVME_CAP_MPSMIN(cap) + 12;
-	unsigned dev_page_max = NVME_CAP_MPSMAX(cap) + 12;
-
-	if (page_shift < dev_page_min) {
-		dev_err(dev->dev,
-				"Minimum device page size (%u) too
large for "
-				"host (%u)\n", 1 << dev_page_min,
-				1 << page_shift);
-		return -ENODEV;
-	}
-	if (page_shift > dev_page_max) {
-		dev_info(dev->dev,
-				"Device maximum page size (%u) smaller
than "
-				"host (%u); enabling work-around\n",
-				1 << dev_page_max, 1 << page_shift);
-		page_shift = dev_page_max;
-	}
-
-	dev->subsystem = readl(&pdev->bar->vs) >= NVME_VS(1, 1) ?
-						NVME_CAP_NSSRC(cap) :
0;
-
-	if (dev->subsystem && (readl(&pdev->bar->csts) &
NVME_CSTS_NSSRO))
-		writel(NVME_CSTS_NSSRO, &pdev->bar->csts);
-
-	result = nvme_disable_ctrl(dev, cap);
-	if (result < 0)
-		return result;
 
 	nvmeq = dev->queues[0];
 	if (!nvmeq) {
@@ -1737,34 +1526,11 @@ static int nvme_configure_admin_queue(struct
nvme_dev *dev)
 			return -ENOMEM;
 	}
 
-	aqa = nvmeq->q_depth - 1;
-	aqa |= aqa << 16;
-
-	dev->page_size = 1 << page_shift;
-
-	pdev->ctrl_config = NVME_CC_CSS_NVM;
-	pdev->ctrl_config |= (page_shift - 12) << NVME_CC_MPS_SHIFT;
-	pdev->ctrl_config |= NVME_CC_ARB_RR | NVME_CC_SHN_NONE;
-	pdev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
-
-	writel(aqa, &pdev->bar->aqa);
-	writeq(nvmeq->sq_dma_addr, &pdev->bar->asq);
-	writeq(nvmeq->cq_dma_addr, &pdev->bar->acq);
-
-	result = nvme_enable_ctrl(dev, cap);
+	result = nvme_pci_setup_admin_queue(nvmeq);
 	if (result)
 		goto free_nvmeq;
 
-	q = (struct nvme_pci_queue *) nvmeq->context;
-
-	nvmeq->cq_vector = 0;
-	result = queue_request_irq(dev, nvmeq, q->irqname);
-	if (result) {
-		nvmeq->cq_vector = -1;
-		goto free_nvmeq;
-	}
-
-	return result;
+	return 0;
 
  free_nvmeq:
 	nvme_free_queues(dev, 0);
@@ -1888,17 +1654,6 @@ static int nvme_user_cmd(struct nvme_dev *dev,
struct nvme_ns *ns,
 	return status;
 }
 
-static int nvme_subsys_reset(struct nvme_dev *dev)
-{
-	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
-
-	if (!dev->subsystem)
-		return -ENOTTY;
-
-	writel(0x4E564D65, &pdev->bar->nssr); /* "NVMe" */
-	return 0;
-}
-
 static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
unsigned int cmd,
 							unsigned long
arg)
 {
@@ -2063,17 +1818,13 @@ static int nvme_kthread(void *data)
 		spin_lock(&dev_list_lock);
 		list_for_each_entry_safe(dev, next, &dev_list, node) {
 			int i;
-			struct nvme_pci_dev *pdev = (struct
nvme_pci_dev *) dev->context;
-			u32 csts = readl(&pdev->bar->csts);
 
-			if ((dev->subsystem && (csts &
NVME_CSTS_NSSRO)) ||
-							csts &
NVME_CSTS_CFS) {
+			if (nvme_pci_is_status_fatal(dev)) {
 				if (work_busy(&dev->reset_work))
 					continue;
 				list_del_init(&dev->node);
 				dev_warn(dev->dev,
-					"Failed status: %x, reset
controller\n",
-					readl(&pdev->bar->csts));
+					"Failed, reset controller\n");
 				dev->reset_workfn =
nvme_reset_failed_dev;
 				queue_work(nvme_workq, &dev
->reset_work);
 				continue;
@@ -2209,75 +1960,9 @@ static int set_queue_count(struct nvme_dev *dev,
int count)
 	return min(result & 0xffff, result >> 16) + 1;
 }
 
-static void __iomem *nvme_map_cmb(struct nvme_dev *dev)
-{
-	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
-	u64 szu, size, offset;
-	u32 cmbloc;
-	resource_size_t bar_size;
-	struct pci_dev *pci_dev = to_pci_dev(dev->dev);
-	void __iomem *cmb;
-	dma_addr_t dma_addr;
-
-	if (!use_cmb_sqes)
-		return NULL;
-
-	pdev->cmbsz = readl(&pdev->bar->cmbsz);
-	if (!(NVME_CMB_SZ(pdev->cmbsz)))
-		return NULL;
-
-	cmbloc = readl(&pdev->bar->cmbloc);
-
-	szu = (u64)1 << (12 + 4 * NVME_CMB_SZU(pdev->cmbsz));
-	size = szu * NVME_CMB_SZ(pdev->cmbsz);
-	offset = szu * NVME_CMB_OFST(cmbloc);
-	bar_size = pci_resource_len(pci_dev, NVME_CMB_BIR(cmbloc));
-
-	if (offset > bar_size)
-		return NULL;
-
-	/*
-	 * Controllers may support a CMB size larger than their BAR,
-	 * for example, due to being behind a bridge. Reduce the CMB
to
-	 * the reported size of the BAR
-	 */
-	if (size > bar_size - offset)
-		size = bar_size - offset;
-
-	dma_addr = pci_resource_start(pci_dev, NVME_CMB_BIR(cmbloc)) +
offset;
-	cmb = ioremap_wc(dma_addr, size);
-	if (!cmb)
-		return NULL;
-
-	pdev->cmb_dma_addr = dma_addr;
-	pdev->cmb_size = size;
-	return cmb;
-}
-
-static inline void nvme_release_cmb(struct nvme_dev *dev)
-{
-	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
-
-	if (pdev->cmb) {
-		iounmap(pdev->cmb);
-		pdev->cmb = NULL;
-	}
-}
-
-static size_t db_bar_size(struct nvme_dev *dev, unsigned nr_io_queues)
-{
-	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
-
-	return 4096 + ((nr_io_queues + 1) * 8 * pdev->db_stride);
-}
-
 static int nvme_setup_io_queues(struct nvme_dev *dev)
 {
-	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
-	struct nvme_queue *adminq = dev->queues[0];
-	struct nvme_pci_queue *q = (struct nvme_pci_queue *) adminq
->context;
-	struct pci_dev *pci_dev = to_pci_dev(dev->dev);
-	int result, i, vecs, nr_io_queues, size;
+	int result, nr_io_queues;
 
 	nr_io_queues = num_possible_cpus();
 	result = set_queue_count(dev, nr_io_queues);
@@ -2286,69 +1971,14 @@ static int nvme_setup_io_queues(struct nvme_dev
*dev)
 	if (result < nr_io_queues)
 		nr_io_queues = result;
 
-	if (pdev->cmb && NVME_CMB_SQS(pdev->cmbsz)) {
-		result = nvme_cmb_qdepth(dev, nr_io_queues,
-				sizeof(struct nvme_command));
-		if (result > 0)
-			dev->q_depth = result;
-		else
-			nvme_release_cmb(dev);
-	}
-
-	size = db_bar_size(dev, nr_io_queues);
-	if (size > 8192) {
-		iounmap(pdev->bar);
-		do {
-			pdev->bar =
ioremap(pci_resource_start(pci_dev, 0),
-					    size);
-			if (pdev->bar)
-				break;
-			if (!--nr_io_queues)
-				return -ENOMEM;
-			size = db_bar_size(dev, nr_io_queues);
-		} while (1);
-		pdev->dbs = ((void __iomem *)pdev->bar) + 4096;
-		q->q_db = pdev->dbs;
-	}
+	result = nvme_pci_setup_io_queues(dev, nr_io_queues);
+	if (result <= 0)
+		goto free_queues;
 
-	/* Deregister the admin queue's interrupt */
-	free_irq(pdev->entry[0].vector, adminq);
+	nr_io_queues = result;
 
-	/*
-	 * If we enable msix early due to not intx, disable it again
before
-	 * setting up the full range we need.
-	 */
-	if (!pci_dev->irq)
-		pci_disable_msix(pci_dev);
-
-	for (i = 0; i < nr_io_queues; i++)
-		pdev->entry[i].entry = i;
-	vecs = pci_enable_msix_range(pci_dev, pdev->entry, 1,
nr_io_queues);
-	if (vecs < 0) {
-		vecs = pci_enable_msi_range(pci_dev, 1,
min(nr_io_queues, 32));
-		if (vecs < 0) {
-			vecs = 1;
-		} else {
-			for (i = 0; i < vecs; i++)
-				pdev->entry[i].vector = i + pci_dev
->irq;
-		}
-	}
-
-	/*
-	 * Should investigate if there's a performance win from
allocating
-	 * more queues than interrupt vectors; it might allow the
submission
-	 * path to scale better, even if the receive path is limited
by the
-	 * number of interrupts.
-	 */
-	nr_io_queues = vecs;
 	dev->max_qid = nr_io_queues;
 
-	result = queue_request_irq(dev, adminq, q->irqname);
-	if (result) {
-		adminq->cq_vector = -1;
-		goto free_queues;
-	}
-
 	/* Free previously allocated queues that are no longer usable
*/
 	nvme_free_queues(dev, nr_io_queues + 1);
 	nvme_create_io_queues(dev);
@@ -2393,17 +2023,10 @@ static struct nvme_ns *nvme_find_ns(struct
nvme_dev *dev, unsigned nsid)
 	return NULL;
 }
 
-static inline bool nvme_io_incapable(struct nvme_dev *dev)
-{
-	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
-
-	return (!pdev->bar || readl(&pdev->bar->csts) & NVME_CSTS_CFS
||
-							dev
->online_queues < 2);
-}
-
 static void nvme_ns_remove(struct nvme_ns *ns)
 {
-	bool kill = nvme_io_incapable(ns->dev) && !blk_queue_dying(ns
->queue);
+	bool kill = nvme_pci_is_io_incapable(ns->dev) &&
+		!blk_queue_dying(ns->queue);
 
 	if (kill)
 		blk_set_queue_dying(ns->queue);
@@ -2415,10 +2038,10 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	if (kill || !blk_queue_dying(ns->queue)) {
 		blk_mq_abort_requeue_list(ns->queue);
 		blk_cleanup_queue(ns->queue);
-        }
+	}
 }
 
-static void nvme_scan_namespaces(struct nvme_dev *dev, unsigned nn)
+void nvme_scan_namespaces(struct nvme_dev *dev, unsigned nn)
 {
 	struct nvme_ns *ns, *next;
 	unsigned i;
@@ -2441,19 +2064,17 @@ static void nvme_scan_namespaces(struct
nvme_dev *dev, unsigned nn)
 	}
 	list_sort(NULL, &dev->namespaces, ns_cmp);
 }
+EXPORT_SYMBOL_GPL(nvme_scan_namespaces);
 
-static void nvme_dev_scan(struct work_struct *work)
+void nvme_common_reset_failed_dev(struct nvme_dev *dev)
 {
-	struct nvme_dev *dev = container_of(work, struct nvme_dev,
scan_work);
-	struct nvme_id_ctrl *ctrl;
-
-	if (!dev->tagset.tags)
-		return;
-	if (nvme_identify_ctrl(dev, &ctrl))
-		return;
-	nvme_scan_namespaces(dev, le32_to_cpup(&ctrl->nn));
-	kfree(ctrl);
+	if (!work_busy(&dev->reset_work)) {
+		dev->reset_workfn = nvme_reset_failed_dev;
+		queue_work(nvme_workq, &dev->reset_work);
+	}
 }
+EXPORT_SYMBOL_GPL(nvme_common_reset_failed_dev);
+
 
 /*
  * Return: error value if an error occurred setting up the queues or
calling
@@ -2461,42 +2082,8 @@ static void nvme_dev_scan(struct work_struct
*work)
  * namespaces failed.  At the moment, these failures are silent.  TBD
which
  * failures should be reported.
  */
-static int nvme_dev_add(struct nvme_dev *dev)
+int nvme_dev_add(struct nvme_dev *dev)
 {
-	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
-	struct pci_dev *pci_dev = to_pci_dev(dev->dev);
-	int res;
-	struct nvme_id_ctrl *ctrl;
-	int shift = NVME_CAP_MPSMIN(readq(&pdev->bar->cap)) + 12;
-
-	res = nvme_identify_ctrl(dev, &ctrl);
-	if (res) {
-		dev_err(dev->dev, "Identify Controller failed (%d)\n",
res);
-		return -EIO;
-	}
-
-	dev->oncs = le16_to_cpup(&ctrl->oncs);
-	dev->abort_limit = ctrl->acl + 1;
-	dev->vwc = ctrl->vwc;
-	memcpy(dev->serial, ctrl->sn, sizeof(ctrl->sn));
-	memcpy(dev->model, ctrl->mn, sizeof(ctrl->mn));
-	memcpy(dev->firmware_rev, ctrl->fr, sizeof(ctrl->fr));
-	if (ctrl->mdts)
-		dev->max_hw_sectors = 1 << (ctrl->mdts + shift - 9);
-	if ((pci_dev->vendor == PCI_VENDOR_ID_INTEL) &&
-			(pci_dev->device == 0x0953) && ctrl->vs[3]) {
-		unsigned int max_hw_sectors;
-
-		dev->stripe_size = 1 << (ctrl->vs[3] + shift);
-		max_hw_sectors = dev->stripe_size >> (shift - 9);
-		if (dev->max_hw_sectors) {
-			dev->max_hw_sectors = min(max_hw_sectors,
-							dev
->max_hw_sectors);
-		} else
-			dev->max_hw_sectors = max_hw_sectors;
-	}
-	kfree(ctrl);
-
 	if (!dev->tagset.tags) {
 		dev->tagset.ops = &nvme_mq_ops;
 		dev->tagset.nr_hw_queues = dev->online_queues - 1;
@@ -2511,91 +2098,9 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		if (blk_mq_alloc_tag_set(&dev->tagset))
 			return 0;
 	}
-	schedule_work(&dev->scan_work);
-	return 0;
-}
-
-static int nvme_dev_map(struct nvme_dev *dev)
-{
-	u64 cap;
-	int bars, result = -ENOMEM;
-	struct pci_dev *pci_dev = to_pci_dev(dev->dev);
-	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
-
-	if (pci_enable_device_mem(pci_dev))
-		return result;
-
-	pdev->entry[0].vector = pci_dev->irq;
-	pci_set_master(pci_dev);
-	bars = pci_select_bars(pci_dev, IORESOURCE_MEM);
-	if (!bars)
-		goto disable_pci;
-
-	if (pci_request_selected_regions(pci_dev, bars, "nvme"))
-		goto disable_pci;
-
-	if (dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(64)) &&
-	    dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(32)))
-		goto disable;
-
-	pdev->bar = ioremap(pci_resource_start(pci_dev, 0), 8192);
-	if (!pdev->bar)
-		goto disable;
-
-	if (readl(&pdev->bar->csts) == -1) {
-		result = -ENODEV;
-		goto unmap;
-	}
-
-	/*
-	 * Some devices don't advertse INTx interrupts, pre-enable a
single
-	 * MSIX vec for setup. We'll adjust this later.
-	 */
-	if (!pci_dev->irq) {
-		result = pci_enable_msix(pci_dev, pdev->entry, 1);
-		if (result < 0)
-			goto unmap;
-	}
-
-	cap = readq(&pdev->bar->cap);
-	dev->q_depth = min_t(int, NVME_CAP_MQES(cap) + 1,
NVME_Q_DEPTH);
-
-	pdev->db_stride = 1 << NVME_CAP_STRIDE(cap);
-	pdev->dbs = ((void __iomem *)pdev->bar) + 4096;
-	if (readl(&pdev->bar->vs) >= NVME_VS(1, 2))
-		pdev->cmb = nvme_map_cmb(dev);
-
-	return 0;
-
- unmap:
-	iounmap(pdev->bar);
-	pdev->bar = NULL;
- disable:
-	pci_release_regions(pci_dev);
- disable_pci:
-	pci_disable_device(pci_dev);
-	return result;
-}
-
-static void nvme_dev_unmap(struct nvme_dev *dev)
-{
-	struct pci_dev *pci_dev = to_pci_dev(dev->dev);
-	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
-
-	if (pci_dev->msi_enabled)
-		pci_disable_msi(pci_dev);
-	else if (pci_dev->msix_enabled)
-		pci_disable_msix(pci_dev);
-
-	if (pdev->bar) {
-		iounmap(pdev->bar);
-		pdev->bar = NULL;
-		pci_release_regions(pci_dev);
-	}
-
-	if (pci_is_enabled(pci_dev))
-		pci_disable_device(pci_dev);
+	return nvme_pci_dev_add(dev);
 }
+EXPORT_SYMBOL_GPL(nvme_dev_add);
 
 struct nvme_delq_ctx {
 	struct task_struct *waiter;
@@ -2605,8 +2110,6 @@ struct nvme_delq_ctx {
 
 static void nvme_wait_dq(struct nvme_delq_ctx *dq, struct nvme_dev
*dev)
 {
-	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
-
 	dq->waiter = current;
 	mb();
 
@@ -2624,7 +2127,7 @@ static void nvme_wait_dq(struct nvme_delq_ctx
*dq, struct nvme_dev *dev)
 			 * queues than admin tags.
 			 */
 			set_current_state(TASK_RUNNING);
-			nvme_disable_ctrl(dev, readq(&pdev->bar
->cap));
+			nvme_pci_disable_ctrl(dev);
 			nvme_clear_queue(dev->queues[0]);
 			flush_kthread_worker(dq->worker);
 			nvme_disable_queue(dev, 0);
@@ -2787,33 +2290,30 @@ static void nvme_unfreeze_queues(struct
nvme_dev *dev)
 	}
 }
 
-static void nvme_dev_shutdown(struct nvme_dev *dev)
+void nvme_dev_shutdown(struct nvme_dev *dev)
 {
-	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
 	int i;
-	u32 csts = -1;
 
 	nvme_dev_list_remove(dev);
 
-	if (pdev->bar) {
-		nvme_freeze_queues(dev);
-		csts = readl(&pdev->bar->csts);
-	}
-	if (csts & NVME_CSTS_CFS || !(csts & NVME_CSTS_RDY)) {
+	nvme_freeze_queues(dev);
+	if (nvme_pci_is_active(dev) || !nvme_pci_is_ready(dev)) {
 		for (i = dev->queue_count - 1; i >= 0; i--) {
 			struct nvme_queue *nvmeq = dev->queues[i];
 			nvme_suspend_queue(nvmeq);
 		}
 	} else {
 		nvme_disable_io_queues(dev);
-		nvme_shutdown_ctrl(dev);
+		nvme_pci_shutdown_ctrl(dev);
 		nvme_disable_queue(dev, 0);
 	}
-	nvme_dev_unmap(dev);
+
+	nvme_pci_dev_unmap(dev);
 
 	for (i = dev->queue_count - 1; i >= 0; i--)
 		nvme_clear_queue(dev->queues[i]);
 }
+EXPORT_SYMBOL_GPL(nvme_dev_shutdown);
 
 static void nvme_dev_remove(struct nvme_dev *dev)
 {
@@ -2886,7 +2386,6 @@ static void nvme_free_namespaces(struct nvme_dev
*dev)
 static void nvme_free_dev(struct kref *kref)
 {
 	struct nvme_dev *dev = container_of(kref, struct nvme_dev,
kref);
-	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
 
 	put_device(dev->dev);
 	put_device(dev->device);
@@ -2897,7 +2396,6 @@ static void nvme_free_dev(struct kref *kref)
 	if (dev->admin_q)
 		blk_put_queue(dev->admin_q);
 	kfree(dev->queues);
-	kfree(pdev->entry);
 	kfree(dev);
 }
 
@@ -2950,7 +2448,7 @@ static long nvme_dev_ioctl(struct file *f,
unsigned int cmd, unsigned long arg)
 		dev_warn(dev->dev, "resetting controller\n");
 		return nvme_reset(dev);
 	case NVME_IOCTL_SUBSYS_RESET:
-		return nvme_subsys_reset(dev);
+		return nvme_pci_subsys_reset(dev);
 	default:
 		return -ENOTTY;
 	}
@@ -2964,29 +2462,12 @@ static const struct file_operations
nvme_dev_fops = {
 	.compat_ioctl	= nvme_dev_ioctl,
 };
 
-static void nvme_set_irq_hints(struct nvme_dev *dev)
-{
-	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
-	struct nvme_queue *nvmeq;
-	int i;
-
-	for (i = 0; i < dev->online_queues; i++) {
-		nvmeq = dev->queues[i];
-
-		if (!nvmeq->tags || !(*nvmeq->tags))
-			continue;
-
-		irq_set_affinity_hint(pdev->entry[nvmeq
->cq_vector].vector,
-					blk_mq_tags_cpumask(*nvmeq
->tags));
-	}
-}
-
 static int nvme_dev_start(struct nvme_dev *dev)
 {
 	int result;
 	bool start_thread = false;
 
-	result = nvme_dev_map(dev);
+	result = nvme_pci_dev_map(dev);
 	if (result)
 		return result;
 
@@ -3022,8 +2503,6 @@ static int nvme_dev_start(struct nvme_dev *dev)
 	if (result)
 		goto free_tags;
 
-	nvme_set_irq_hints(dev);
-
 	dev->event_limit = 1;
 	return result;
 
@@ -3036,17 +2515,15 @@ static int nvme_dev_start(struct nvme_dev *dev)
 	nvme_disable_queue(dev, 0);
 	nvme_dev_list_remove(dev);
  unmap:
-	nvme_dev_unmap(dev);
+	nvme_pci_dev_unmap(dev);
 	return result;
 }
 
 static int nvme_remove_dead_ctrl(void *arg)
 {
 	struct nvme_dev *dev = (struct nvme_dev *)arg;
-	struct pci_dev *pci_dev = to_pci_dev(dev->dev);
 
-	if (pci_get_drvdata(pci_dev))
-		pci_stop_and_remove_bus_device_locked(pci_dev);
+	nvme_pci_remove_dead_ctrl(dev);
 	kref_put(&dev->kref, nvme_free_dev);
 	return 0;
 }
@@ -3059,7 +2536,7 @@ static void nvme_remove_disks(struct work_struct
*ws)
 	nvme_dev_remove(dev);
 }
 
-static int nvme_dev_resume(struct nvme_dev *dev)
+int nvme_dev_resume(struct nvme_dev *dev)
 {
 	int ret;
 
@@ -3074,13 +2551,17 @@ static int nvme_dev_resume(struct nvme_dev
*dev)
 	} else {
 		nvme_unfreeze_queues(dev);
 		nvme_dev_add(dev);
-		nvme_set_irq_hints(dev);
+		nvme_pci_set_irq_hints(dev);
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(nvme_dev_resume);
 
-static void nvme_dead_ctrl(struct nvme_dev *dev)
+void nvme_dead_ctrl(struct nvme_dev *dev)
 {
+	if (shutting_down)
+		return;
+
 	dev_warn(dev->dev, "Device failed to resume\n");
 	kref_get(&dev->kref);
 	if (IS_ERR(kthread_run(nvme_remove_dead_ctrl, dev, "nvme%d",
@@ -3090,8 +2571,9 @@ static void nvme_dead_ctrl(struct nvme_dev *dev)
 		kref_put(&dev->kref, nvme_free_dev);
 	}
 }
+EXPORT_SYMBOL_GPL(nvme_dead_ctrl);
 
-static void nvme_dev_reset(struct nvme_dev *dev)
+void nvme_dev_reset(struct nvme_dev *dev)
 {
 	bool in_probe = work_busy(&dev->probe_work);
 
@@ -3111,6 +2593,7 @@ static void nvme_dev_reset(struct nvme_dev *dev)
 	 * to cleanup errors that may occur during reinitialization */
 	schedule_work(&dev->probe_work);
 }
+EXPORT_SYMBOL_GPL(nvme_dev_reset);
 
 static void nvme_reset_failed_dev(struct work_struct *ws)
 {
@@ -3163,53 +2646,41 @@ static ssize_t nvme_sysfs_reset(struct device
*dev,
 }
 static DEVICE_ATTR(reset_controller, S_IWUSR, NULL, nvme_sysfs_reset);
 
-static void nvme_async_probe(struct work_struct *work);
-static int nvme_probe(struct pci_dev *pci_dev, const struct
pci_device_id *id)
+struct nvme_dev *nvme_common_create_dev(struct device *device, void
*context)
 {
 	int node, result = -ENOMEM;
 	struct nvme_dev *dev;
-	struct nvme_pci_dev *pdev;
 
-	node = dev_to_node(&pci_dev->dev);
+	node = dev_to_node(device);
 	if (node == NUMA_NO_NODE)
-		set_dev_node(&pci_dev->dev, 0);
+		set_dev_node(device, 0);
 
 	dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, node);
 	if (!dev)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
+
 	dev->queues = kzalloc_node((num_possible_cpus() + 1) *
sizeof(void *),
-							GFP_KERNEL,
node);
+				   GFP_KERNEL, node);
 	if (!dev->queues)
-		goto free_dev;
-
-	pdev = kzalloc_node(sizeof(*pdev), GFP_KERNEL, node);
-	if (!pdev)
-		goto free_dev;
-
-	dev->context = pdev;
-
-	pdev->entry = kzalloc_node(num_possible_cpus() * sizeof(*pdev
->entry),
-							GFP_KERNEL,
node);
-	if (!pdev->entry)
-		goto free_pdev;
+		goto free;
 
 	INIT_LIST_HEAD(&dev->namespaces);
+	dev->dev = device;
 	dev->reset_workfn = nvme_reset_failed_dev;
 	INIT_WORK(&dev->reset_work, nvme_reset_workfn);
-	dev->dev = get_device(&pci_dev->dev);
-	pci_set_drvdata(pci_dev, dev);
+
 	result = nvme_set_instance(dev);
 	if (result)
-		goto put_pci;
+		goto free;
 
 	result = nvme_setup_prp_pools(dev);
 	if (result)
 		goto release;
 
 	kref_init(&dev->kref);
-	dev->device = device_create(nvme_class, &pci_dev->dev,
-				MKDEV(nvme_char_major, dev->instance),
-				dev, "nvme%d", dev->instance);
+	dev->device = device_create(nvme_class, device,
+				    MKDEV(nvme_char_major, dev
->instance),
+				    dev, "nvme%d", dev->instance);
 	if (IS_ERR(dev->device)) {
 		result = PTR_ERR(dev->device);
 		goto release_pools;
@@ -3221,11 +2692,11 @@ static int nvme_probe(struct pci_dev *pci_dev,
const struct pci_device_id *id)
 	if (result)
 		goto put_dev;
 
+	dev->context = context;
+
 	INIT_LIST_HEAD(&dev->node);
-	INIT_WORK(&dev->scan_work, nvme_dev_scan);
-	INIT_WORK(&dev->probe_work, nvme_async_probe);
-	schedule_work(&dev->probe_work);
-	return 0;
+
+	return dev;
 
  put_dev:
 	device_destroy(nvme_class, MKDEV(nvme_char_major, dev
->instance));
@@ -3234,130 +2705,37 @@ static int nvme_probe(struct pci_dev *pci_dev,
const struct pci_device_id *id)
 	nvme_release_prp_pools(dev);
  release:
 	nvme_release_instance(dev);
- put_pci:
-	put_device(dev->dev);
- free_pdev:
-	kfree(pdev->entry);
-	kfree(pdev);
- free_dev:
+ free:
 	kfree(dev->queues);
 	kfree(dev);
-	return result;
-}
-
-static void nvme_async_probe(struct work_struct *work)
-{
-	struct nvme_dev *dev = container_of(work, struct nvme_dev,
probe_work);
-
-	if (nvme_dev_resume(dev) && !work_busy(&dev->reset_work))
-		nvme_dead_ctrl(dev);
-}
-
-static void nvme_reset_notify(struct pci_dev *pci_dev, bool prepare)
-{
-	struct nvme_dev *dev = pci_get_drvdata(pci_dev);
-
-	if (prepare)
-		nvme_dev_shutdown(dev);
-	else
-		nvme_dev_resume(dev);
+	return ERR_PTR(result);
 }
+EXPORT_SYMBOL_GPL(nvme_common_create_dev);
 
-static void nvme_shutdown(struct pci_dev *pci_dev)
+void nvme_remove(struct nvme_dev *dev)
 {
-	struct nvme_dev *dev = pci_get_drvdata(pci_dev);
-	nvme_dev_shutdown(dev);
-}
-
-static void nvme_remove(struct pci_dev *pci_dev)
-{
-	struct nvme_dev *dev = pci_get_drvdata(pci_dev);
-
 	spin_lock(&dev_list_lock);
 	list_del_init(&dev->node);
 	spin_unlock(&dev_list_lock);
 
-	pci_set_drvdata(pci_dev, NULL);
-	flush_work(&dev->probe_work);
-	flush_work(&dev->reset_work);
-	flush_work(&dev->scan_work);
 	device_remove_file(dev->device, &dev_attr_reset_controller);
 	nvme_dev_remove(dev);
 	nvme_dev_shutdown(dev);
 	nvme_dev_remove_admin(dev);
+	dev->admin_q = NULL;
 	device_destroy(nvme_class, MKDEV(nvme_char_major, dev
->instance));
 	nvme_free_queues(dev, 0);
-	nvme_release_cmb(dev);
 	nvme_release_prp_pools(dev);
 	kref_put(&dev->kref, nvme_free_dev);
 }
-
-/* These functions are yet to be implemented */
-#define nvme_error_detected NULL
-#define nvme_dump_registers NULL
-#define nvme_link_reset NULL
-#define nvme_slot_reset NULL
-#define nvme_error_resume NULL
-
-#ifdef CONFIG_PM_SLEEP
-static int nvme_suspend(struct device *dev)
-{
-	struct pci_dev *pci_dev = to_pci_dev(dev);
-	struct nvme_dev *ndev = pci_get_drvdata(pci_dev);
-
-	nvme_dev_shutdown(ndev);
-	return 0;
-}
-
-static int nvme_resume(struct device *dev)
-{
-	struct pci_dev *pci_dev = to_pci_dev(dev);
-	struct nvme_dev *ndev = pci_get_drvdata(pci_dev);
-
-	if (nvme_dev_resume(ndev) && !work_busy(&ndev->reset_work)) {
-		ndev->reset_workfn = nvme_reset_failed_dev;
-		queue_work(nvme_workq, &ndev->reset_work);
-	}
-	return 0;
-}
-#endif
-
-static SIMPLE_DEV_PM_OPS(nvme_dev_pm_ops, nvme_suspend, nvme_resume);
-
-static const struct pci_error_handlers nvme_err_handler = {
-	.error_detected	= nvme_error_detected,
-	.mmio_enabled	= nvme_dump_registers,
-	.link_reset	= nvme_link_reset,
-	.slot_reset	= nvme_slot_reset,
-	.resume		= nvme_error_resume,
-	.reset_notify	= nvme_reset_notify,
-};
-
-/* Move to pci_ids.h later */
-#define PCI_CLASS_STORAGE_EXPRESS	0x010802
-
-static const struct pci_device_id nvme_id_table[] = {
-	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
-	{ 0, }
-};
-MODULE_DEVICE_TABLE(pci, nvme_id_table);
-
-static struct pci_driver nvme_driver = {
-	.name		= "nvme",
-	.id_table	= nvme_id_table,
-	.probe		= nvme_probe,
-	.remove		= nvme_remove,
-	.shutdown	= nvme_shutdown,
-	.driver		= {
-		.pm	= &nvme_dev_pm_ops,
-	},
-	.err_handler	= &nvme_err_handler,
-};
+EXPORT_SYMBOL_GPL(nvme_remove);
 
 static int __init nvme_init(void)
 {
 	int result;
 
+	shutting_down = 0;
+
 	init_waitqueue_head(&nvme_kthread_wait);
 
 	nvme_workq = create_singlethread_workqueue("nvme");
@@ -3383,13 +2761,11 @@ static int __init nvme_init(void)
 		goto unregister_chrdev;
 	}
 
-	result = pci_register_driver(&nvme_driver);
-	if (result)
-		goto destroy_class;
+#ifdef CONFIG_NVME_PCI
+	nvme_pci_init();
+#endif
 	return 0;
 
- destroy_class:
-	class_destroy(nvme_class);
  unregister_chrdev:
 	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme");
  unregister_blkdev:
@@ -3401,8 +2777,16 @@ static int __init nvme_init(void)
 
 static void __exit nvme_exit(void)
 {
-	pci_unregister_driver(&nvme_driver);
+	shutting_down = 1;
+
+#ifdef CONFIG_NVME_PCI
+	schedule();
+	nvme_pci_exit();
+#endif
+
+	schedule();
 	unregister_blkdev(nvme_major, "nvme");
+	schedule();
 	destroy_workqueue(nvme_workq);
 	class_destroy(nvme_class);
 	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme");
diff --git a/drivers/nvme/host/ops.h b/drivers/nvme/host/ops.h
new file mode 100644
index 0000000..6727da2
--- /dev/null
+++ b/drivers/nvme/host/ops.h
@@ -0,0 +1,56 @@
+/*
+ * Copyright (C) 2015 Intel Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _NVME_OPS_H
+#define _NVME_OPS_H
+
+void nvme_dev_shutdown(struct nvme_dev *dev);
+int nvme_dev_resume(struct nvme_dev *dev);
+void nvme_dead_ctrl(struct nvme_dev *dev);
+void nvme_remove(struct nvme_dev *dev);
+void nvme_common_reset_failed_dev(struct nvme_dev *dev);
+struct nvme_dev *nvme_common_create_dev(struct device *device, void
*context);
+void nvme_dev_reset(struct nvme_dev *dev);
+int nvme_dev_add(struct nvme_dev *dev);
+void nvme_scan_namespaces(struct nvme_dev *dev, unsigned nn);
+int nvme_process_cq(struct nvme_queue *nvmeq);
+
+int nvme_pci_get_version(struct nvme_dev *dev);
+int nvme_pci_get_vector(struct nvme_queue *nvmeq);
+int nvme_pci_is_active(struct nvme_dev *dev);
+int nvme_pci_is_status_fatal(struct nvme_dev *dev);
+int nvme_pci_is_ready(struct nvme_dev *dev);
+int nvme_pci_subsys_reset(struct nvme_dev *dev);
+int nvme_pci_is_io_incapable(struct nvme_dev *dev);
+void nvme_pci_process_cq(struct nvme_queue *nvmeq, u16 head);
+int nvme_pci_submit_sync_cmd(struct nvme_queue *nvmeq,
+				    struct nvme_command *cmd);
+int nvme_pci_submit_async_cmd(struct nvme_queue *nvmeq,
+				     struct nvme_command *cmd,
+				     struct nvme_iod *iod);
+void nvme_pci_set_irq_hints(struct nvme_dev *dev);
+int nvme_pci_setup_io_queues(struct nvme_dev *dev, int nr_io_queues);
+int nvme_pci_disable_ctrl(struct nvme_dev *dev);
+int nvme_pci_enable_ctrl(struct nvme_dev *dev);
+int nvme_pci_shutdown_ctrl(struct nvme_dev *dev);
+void nvme_pci_init_queue(struct nvme_queue *nvmeq);
+int nvme_pci_create_queue(struct nvme_queue *nvmeq);
+int nvme_pci_setup_admin_queue(struct nvme_queue *nvmeq);
+void nvme_pci_suspend_queue(struct nvme_queue *nvmeq, int vector);
+int nvme_pci_alloc_queue(struct nvme_queue *nvmeq);
+int nvme_pci_dev_add(struct nvme_dev *dev);
+int nvme_pci_dev_map(struct nvme_dev *dev);
+void nvme_pci_dev_unmap(struct nvme_dev *dev);
+void nvme_pci_remove_dead_ctrl(struct nvme_dev *dev);
+
+#endif	/* _NVME_OPS_H */
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
new file mode 100644
index 0000000..b5de565
--- /dev/null
+++ b/drivers/nvme/host/pci.c
@@ -0,0 +1,954 @@
+/*
+ * Copyright (c) 2011-2015, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but
WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
License for
+ * more details.
+ */
+
+#include "common.h"
+#include "ops.h"
+#include "pci.h"
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+
+static int use_threaded_interrupts;
+module_param(use_threaded_interrupts, int, 0);
+
+#define SHUTDOWN_TIMEOUT	(shutdown_timeout * HZ)
+
+static unsigned char shutdown_timeout = 5;
+module_param(shutdown_timeout, byte, 0644);
+MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller
shutdown");
+
+static bool use_cmb_sqes = true;
+module_param(use_cmb_sqes, bool, 0644);
+MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O
SQes");
+
+static struct workqueue_struct *nvme_workq;
+static int shutting_down;
+
+int nvme_pci_get_version(struct nvme_dev *dev)
+{
+	struct nvme_pci_dev *pdev;
+
+	pdev = (struct nvme_pci_dev *) dev->context;
+
+	return readl(&pdev->bar->vs);
+}
+
+int nvme_pci_get_vector(struct nvme_queue *nvmeq)
+{
+	struct nvme_dev *dev = nvmeq->dev;
+	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
+
+	return pdev->entry[nvmeq->cq_vector].vector;
+}
+
+int nvme_pci_is_active(struct nvme_dev *dev)
+{
+	struct nvme_pci_dev *pdev;
+
+	pdev = (struct nvme_pci_dev *) dev->context;
+
+	return !!(pdev && pdev->bar &&
+		  readl(&pdev->bar->csts) != -1);
+}
+
+int nvme_pci_is_status_fatal(struct nvme_dev *dev)
+{
+	struct nvme_pci_dev *pdev;
+	int ret = 0;
+
+	pdev = (struct nvme_pci_dev *) dev->context;
+
+	if (pdev && pdev->bar) {
+		u32 csts = readl(&pdev->bar->csts);
+		ret = (dev->subsystem && (csts & NVME_CSTS_NSSRO)) ||
+			(csts & NVME_CSTS_CFS);
+	}
+
+	return ret;
+}
+
+int nvme_pci_is_ready(struct nvme_dev *dev)
+{
+	struct nvme_pci_dev *pdev;
+
+	pdev = (struct nvme_pci_dev *) dev->context;
+
+	return !!(pdev && pdev->bar &&
+		  readl(&pdev->bar->csts) & NVME_CSTS_RDY);
+}
+
+int nvme_pci_subsys_reset(struct nvme_dev *dev)
+{
+	struct nvme_pci_dev *pdev;
+
+	pdev = (struct nvme_pci_dev *) dev->context;
+
+	if (!dev->subsystem)
+		return -ENOTTY;
+
+	writel(0x4E564D65, &pdev->bar->nssr); /* "NVMe" */
+	return 0;
+}
+
+int nvme_pci_is_io_incapable(struct nvme_dev *dev)
+{
+	struct nvme_pci_dev *pdev;
+
+	pdev = (struct nvme_pci_dev *) dev->context;
+
+	return (!pdev || !pdev->bar ||
+		readl(&pdev->bar->csts) & NVME_CSTS_CFS ||
+		dev->online_queues < 2);
+}
+
+void nvme_pci_process_cq(struct nvme_queue *nvmeq, u16 head)
+{
+	struct nvme_pci_queue *q;
+	struct nvme_pci_dev *pdev;
+
+	q = (struct nvme_pci_queue *) (nvmeq->context);
+	pdev = (struct nvme_pci_dev *) (nvmeq->dev->context);
+
+	writel(head, q->q_db + pdev->db_stride);
+}
+
+int nvme_pci_submit_sync_cmd(struct nvme_queue *nvmeq,
+				    struct nvme_command *cmd)
+{
+	struct nvme_pci_queue *q;
+
+	q = (struct nvme_pci_queue *) nvmeq->context;
+
+	writel(nvmeq->sq_tail, q->q_db);
+
+	return 0;
+}
+
+int nvme_pci_submit_async_cmd(struct nvme_queue *nvmeq,
+				     struct nvme_command *cmd,
+				     struct nvme_iod *iod)
+{
+	struct nvme_pci_queue *q;
+
+	q = (struct nvme_pci_queue *) nvmeq->context;
+
+	writel(nvmeq->sq_tail, q->q_db);
+
+	return 0;
+}
+
+void nvme_pci_set_irq_hints(struct nvme_dev *dev)
+{
+	struct nvme_queue *nvmeq;
+	struct nvme_pci_dev *pdev;
+	int i;
+
+	pdev = (struct nvme_pci_dev *) (dev->context);
+
+	for (i = 0; i < dev->online_queues; i++) {
+		nvmeq = dev->queues[i];
+
+		if (!nvmeq->tags || !(*nvmeq->tags))
+			continue;
+
+		irq_set_affinity_hint(pdev->entry[nvmeq
->cq_vector].vector,
+				      blk_mq_tags_cpumask(*nvmeq
->tags));
+	}
+}
+
+static size_t db_bar_size(struct nvme_dev *dev, unsigned nr_io_queues)
+{
+	struct nvme_pci_dev *pdev;
+
+	pdev = (struct nvme_pci_dev *) (dev->context);
+
+	return 4096 + ((nr_io_queues + 1) * 8 * pdev->db_stride);
+}
+
+static irqreturn_t nvme_irq(int irq, void *data)
+{
+	irqreturn_t result;
+	struct nvme_queue *nvmeq = data;
+
+	spin_lock(&nvmeq->q_lock);
+	nvme_process_cq(nvmeq);
+	result = nvmeq->cqe_seen ? IRQ_HANDLED : IRQ_NONE;
+	nvmeq->cqe_seen = 0;
+	spin_unlock(&nvmeq->q_lock);
+	return result;
+}
+
+static irqreturn_t nvme_irq_check(int irq, void *data)
+{
+	struct nvme_queue *nvmeq = data;
+	struct nvme_completion cqe = nvmeq->cqes[nvmeq->cq_head];
+
+	if ((le16_to_cpu(cqe.status) & 1) != nvmeq->cq_phase)
+		return IRQ_NONE;
+	return IRQ_WAKE_THREAD;
+}
+
+static int queue_request_irq(struct nvme_dev *dev, struct nvme_queue
*nvmeq,
+			     const char *name)
+{
+	struct nvme_pci_dev *pdev;
+	int vector;
+
+	pdev = (struct nvme_pci_dev *) (dev->context);
+	vector = pdev->entry[nvmeq->cq_vector].vector;
+
+	if (use_threaded_interrupts)
+		return request_threaded_irq(vector, nvme_irq_check,
nvme_irq,
+					    IRQF_SHARED, name, nvmeq);
+
+	return request_irq(vector, nvme_irq, IRQF_SHARED, name,
nvmeq);
+}
+
+static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
+			       int entry_size)
+{
+	struct nvme_pci_dev	*pdev = (struct nvme_pci_dev *) dev
->context;
+	int			q_depth = dev->q_depth;
+	unsigned		q_size_aligned;
+
+	q_size_aligned = roundup(q_depth * entry_size, dev
->page_size);
+
+	if (q_size_aligned * nr_io_queues > pdev->cmb_size) {
+		u64 mem_per_q = div_u64(pdev->cmb_size, nr_io_queues);
+		mem_per_q = round_down(mem_per_q, dev->page_size);
+		q_depth = div_u64(mem_per_q, entry_size);
+
+		/*
+		 * Ensure the reduced q_depth is above some threshold
where it
+		 * would be better to map queues in system memory with
the
+		 * original depth
+		 */
+		if (q_depth < 64)
+			return -ENOMEM;
+	}
+
+	return q_depth;
+}
+
+static inline void nvme_release_cmb(struct nvme_dev *dev)
+{
+	struct nvme_pci_dev	*pdev = (struct nvme_pci_dev *) dev
->context;
+
+	if (pdev->cmb) {
+		iounmap(pdev->cmb);
+		pdev->cmb = NULL;
+	}
+}
+
+int nvme_pci_setup_io_queues(struct nvme_dev *dev, int nr_io_queues)
+{
+	struct nvme_queue *adminq = dev->queues[0];
+	struct nvme_pci_queue *q = (struct nvme_pci_queue *) adminq
->context;
+	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
+	struct pci_dev *pci_dev = to_pci_dev(dev->dev);
+	int result, i, vecs, size;
+
+	if (pdev->cmb && NVME_CMB_SQS(pdev->cmbsz)) {
+		result = nvme_cmb_qdepth(dev, nr_io_queues,
+					 sizeof(struct nvme_command));
+		if (result > 0)
+			dev->q_depth = result;
+		else
+			nvme_release_cmb(dev);
+	}
+
+	size = db_bar_size(dev, nr_io_queues);
+	if (size > 8192) {
+		iounmap(pdev->bar);
+		do {
+			pdev->bar =
ioremap(pci_resource_start(pci_dev, 0),
+					    size);
+			if (pdev->bar)
+				break;
+			if (!--nr_io_queues)
+				return -ENOMEM;
+			size = db_bar_size(dev, nr_io_queues);
+		} while (1);
+		pdev->dbs = ((void __iomem *)pdev->bar) + 4096;
+		q->q_db = pdev->dbs;
+	}
+
+	/* Deregister the admin queue's interrupt */
+	free_irq(pdev->entry[0].vector, adminq);
+
+	/*
+	 * If we enable msix early due to not intx, disable it again
before
+	 * setting up the full range we need.
+	 */
+	if (!pci_dev->irq)
+		pci_disable_msix(pci_dev);
+
+	for (i = 0; i < nr_io_queues; i++)
+		pdev->entry[i].entry = i;
+
+	vecs = pci_enable_msix_range(pci_dev, pdev->entry, 1,
nr_io_queues);
+	if (vecs < 0) {
+		vecs = pci_enable_msi_range(pci_dev, 1,
min(nr_io_queues, 32));
+		if (vecs < 0) {
+			vecs = 1;
+		} else {
+			for (i = 0; i < vecs; i++)
+				pdev->entry[i].vector = i + pci_dev
->irq;
+		}
+	}
+
+	/*
+	 * Should investigate if there's a performance win from
allocating
+	 * more queues than interrupt vectors; it might allow the
submission
+	 * path to scale better, even if the receive path is limited
by the
+	 * number of interrupts.
+	 */
+	nr_io_queues = vecs;
+
+	result = queue_request_irq(dev, adminq, q->irqname);
+	if (result) {
+		adminq->cq_vector = -1;
+		return result;
+	}
+
+	return nr_io_queues;
+}
+
+static int nvme_wait_ready(struct nvme_dev *dev, u64 cap, bool
enabled)
+{
+	unsigned long timeout;
+	u32 bit = enabled ? NVME_CSTS_RDY : 0;
+	struct nvme_pci_dev *pdev;
+
+	pdev = (struct nvme_pci_dev *) dev->context;
+
+	timeout = ((NVME_CAP_TIMEOUT(cap) + 1) * HZ / 2) + jiffies;
+
+	while ((readl(&pdev->bar->csts) & NVME_CSTS_RDY) != bit) {
+		if (shutting_down)
+			return -ESHUTDOWN;
+
+		schedule();
+
+		if (fatal_signal_pending(current))
+			return -EINTR;
+
+		if (time_after(jiffies, timeout)) {
+			dev_err(dev->dev, "Device not ready; aborting
%s\n",
+				enabled ?  "initialisation" :
"reset");
+			return -ENODEV;
+		}
+	}
+
+	return 0;
+}
+/*
+ * If the device has been passed off to us in an enabled state, just
clear
+ * the enabled bit.  The spec says we should set the 'shutdown
notification
+ * bits', but doing so may cause the device to complete commands to
the
+ * admin queue ... and we don't know what memory that might be
pointing at!
+ */
+static int _nvme_pci_disable_ctrl(struct nvme_dev *dev, u64 cap)
+{
+	struct nvme_pci_dev *pdev;
+
+	pdev = (struct nvme_pci_dev *) dev->context;
+
+	pdev->ctrl_config &= ~NVME_CC_SHN_MASK;
+	pdev->ctrl_config &= ~NVME_CC_ENABLE;
+	writel(pdev->ctrl_config, &pdev->bar->cc);
+
+	return nvme_wait_ready(dev, cap, false);
+}
+
+static int _nvme_pci_enable_ctrl(struct nvme_dev *dev, u64 cap)
+{
+	struct nvme_pci_dev *pdev;
+
+	pdev = (struct nvme_pci_dev *) dev->context;
+
+	pdev->ctrl_config &= ~NVME_CC_SHN_MASK;
+	pdev->ctrl_config |= NVME_CC_ENABLE;
+	writel(pdev->ctrl_config, &pdev->bar->cc);
+
+	return nvme_wait_ready(dev, cap, true);
+}
+
+int nvme_pci_disable_ctrl(struct nvme_dev *dev)
+{
+	struct nvme_pci_dev *pdev;
+	u64		     cap;
+
+	pdev = (struct nvme_pci_dev *) dev->context;
+	cap = readq(&pdev->bar->cap);
+
+	return _nvme_pci_disable_ctrl(dev, cap);
+}
+
+int nvme_pci_enable_ctrl(struct nvme_dev *dev)
+{
+	struct nvme_pci_dev *pdev;
+	u64		     cap;
+
+	pdev = (struct nvme_pci_dev *) dev->context;
+	cap = readq(&pdev->bar->cap);
+
+	return _nvme_pci_enable_ctrl(dev, cap);
+}
+
+int nvme_pci_shutdown_ctrl(struct nvme_dev *dev)
+{
+	unsigned long timeout;
+	struct nvme_pci_dev *pdev;
+
+	pdev = (struct nvme_pci_dev *) dev->context;
+
+	pdev->ctrl_config &= ~NVME_CC_SHN_MASK;
+	pdev->ctrl_config |= NVME_CC_SHN_NORMAL;
+
+	writel(pdev->ctrl_config, &pdev->bar->cc);
+
+	timeout = SHUTDOWN_TIMEOUT + jiffies;
+	while ((readl(&pdev->bar->csts) & NVME_CSTS_SHST_MASK) !=
+							NVME_CSTS_SHST
_CMPLT) {
+		msleep(100);
+		if (fatal_signal_pending(current))
+			return -EINTR;
+		if (time_after(jiffies, timeout)) {
+			dev_err(dev->dev,
+				"Device shutdown incomplete; abort
shutdown\n");
+			return -ENODEV;
+		}
+	}
+
+	return 0;
+}
+
+void nvme_pci_init_queue(struct nvme_queue *nvmeq)
+{
+	struct nvme_pci_queue *q = (struct nvme_pci_queue *) nvmeq
->context;
+	struct nvme_dev *dev = nvmeq->dev;
+	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
+
+	q->q_db = &pdev->dbs[nvmeq->qid * 2 * pdev->db_stride];
+}
+
+int nvme_pci_create_queue(struct nvme_queue *nvmeq)
+{
+	struct nvme_pci_queue *q = (struct nvme_pci_queue *) nvmeq
->context;
+	struct nvme_dev *dev = nvmeq->dev;
+
+	return queue_request_irq(dev, nvmeq, q->irqname);
+}
+
+int nvme_pci_setup_admin_queue(struct nvme_queue *nvmeq)
+{
+	struct nvme_pci_queue *q = (struct nvme_pci_queue *) nvmeq
->context;
+	struct nvme_dev *dev = nvmeq->dev;
+	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
+	u64 cap = readq(&pdev->bar->cap);
+	unsigned page_shift = PAGE_SHIFT;
+	unsigned dev_page_min = NVME_CAP_MPSMIN(cap) + 12;
+	unsigned dev_page_max = NVME_CAP_MPSMAX(cap) + 12;
+	int result, aqa;
+
+	if (page_shift < dev_page_min) {
+		dev_err(dev->dev,
+		 "Minimum device page size (%u) too large for host
(%u)\n",
+		 1 << dev_page_min, 1 << page_shift);
+		return -ENODEV;
+	}
+	if (page_shift > dev_page_max) {
+		dev_info(dev->dev,
+			 "Device max page size (%u) smaller than "
+			 "host (%u); enabling work-around\n",
+			 1 << dev_page_max, 1 << page_shift);
+		page_shift = dev_page_max;
+	}
+
+	dev->subsystem = readl(&pdev->bar->vs) >= NVME_VS(1, 1) ?
+						NVME_CAP_NSSRC(cap) :
0;
+
+	if (dev->subsystem && (readl(&pdev->bar->csts) &
NVME_CSTS_NSSRO))
+		writel(NVME_CSTS_NSSRO, &pdev->bar->csts);
+
+	result = _nvme_pci_disable_ctrl(dev, cap);
+	if (result)
+		return result;
+
+	aqa = nvmeq->q_depth - 1;
+	aqa |= aqa << 16;
+
+	dev->page_size = 1 << page_shift;
+
+	pdev->ctrl_config = NVME_CC_CSS_NVM;
+	pdev->ctrl_config |= (page_shift - 12) << NVME_CC_MPS_SHIFT;
+	pdev->ctrl_config |= NVME_CC_ARB_RR | NVME_CC_SHN_NONE;
+	pdev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
+
+	writel(aqa, &pdev->bar->aqa);
+	writeq(nvmeq->sq_dma_addr, &pdev->bar->asq);
+	writeq(nvmeq->cq_dma_addr, &pdev->bar->acq);
+
+	result = _nvme_pci_enable_ctrl(dev, cap);
+	if (result)
+		return result;
+
+	nvmeq->cq_vector = 0;
+
+	result = queue_request_irq(nvmeq->dev, nvmeq, q->irqname);
+	if (result)
+		nvmeq->cq_vector = -1;
+
+	return result;
+}
+
+void nvme_pci_suspend_queue(struct nvme_queue *nvmeq, int vector)
+{
+	irq_set_affinity_hint(vector, NULL);
+	free_irq(vector, nvmeq);
+}
+
+static void __iomem *nvme_map_cmb(struct nvme_dev *dev)
+{
+	struct pci_dev		*pci_dev = to_pci_dev(dev->dev);
+	struct nvme_pci_dev	*pdev = (struct nvme_pci_dev *) dev
->context;
+	void __iomem		*cmb;
+	dma_addr_t		dma_addr;
+	u64			szu, size, offset;
+	u32			cmbloc;
+	resource_size_t		bar_size;
+
+	if (!use_cmb_sqes)
+		return NULL;
+
+	pdev->cmbsz = readl(&pdev->bar->cmbsz);
+	if (!(NVME_CMB_SZ(pdev->cmbsz)))
+		return NULL;
+
+	cmbloc = readl(&pdev->bar->cmbloc);
+
+	szu = (u64)1 << (12 + 4 * NVME_CMB_SZU(pdev->cmbsz));
+	size = szu * NVME_CMB_SZ(pdev->cmbsz);
+	offset = szu * NVME_CMB_OFST(cmbloc);
+	bar_size = pci_resource_len(pci_dev, NVME_CMB_BIR(cmbloc));
+
+	if (offset > bar_size)
+		return NULL;
+
+	/*
+	 * Controllers may support a CMB size larger than their BAR,
+	 * for example, due to being behind a bridge. Reduce the CMB
to
+	 * the reported size of the BAR
+	 */
+	if (size > bar_size - offset)
+		size = bar_size - offset;
+
+	dma_addr = pci_resource_start(pci_dev, NVME_CMB_BIR(cmbloc)) +
offset;
+	cmb = ioremap_wc(dma_addr, size);
+	if (!cmb)
+		return NULL;
+
+	pdev->cmb_dma_addr = dma_addr;
+	pdev->cmb_size = size;
+	return cmb;
+}
+
+static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue
*nvmeq,
+			      int qid, int depth)
+{
+	struct nvme_pci_dev	*pdev = (struct nvme_pci_dev *) dev
->context;
+
+	if (qid && pdev->cmb && use_cmb_sqes && NVME_CMB_SQS(pdev
->cmbsz)) {
+		unsigned offset = (qid - 1) *
+			roundup(SQ_SIZE(depth), dev->page_size);
+		nvmeq->sq_dma_addr = pdev->cmb_dma_addr + offset;
+		nvmeq->sq_cmds_io = pdev->cmb + offset;
+	} else {
+		nvmeq->sq_cmds = dma_alloc_coherent(dev->dev,
SQ_SIZE(depth),
+						    &nvmeq
->sq_dma_addr,
+						    GFP_KERNEL);
+		if (!nvmeq->sq_cmds)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+int nvme_pci_alloc_queue(struct nvme_queue *nvmeq)
+{
+	struct nvme_pci_queue	*q;
+	struct nvme_dev		*dev = nvmeq->dev;
+	struct nvme_pci_dev	*pdev = (struct nvme_pci_dev *) dev
->context;
+
+	q = kzalloc(sizeof(*q), GFP_KERNEL);
+	if (!nvmeq)
+		goto err;
+
+	nvmeq->context = q;
+
+	if (nvme_alloc_sq_cmds(dev, nvmeq, nvmeq->qid, nvmeq
->q_depth))
+		goto freeq;
+
+	snprintf(q->irqname, sizeof(q->irqname), "nvme%dq%d",
+		 dev->instance, nvmeq->qid);
+
+	q->q_db = &pdev->dbs[nvmeq->qid * 2 * pdev->db_stride];
+
+	return 0;
+freeq:
+	kfree(q);
+err:
+	return -ENOMEM;
+}
+
+int nvme_pci_dev_add(struct nvme_dev *dev)
+{
+	struct nvme_pci_dev	*pdev = (struct nvme_pci_dev *) dev
->context;
+	struct pci_dev		*pci_dev = to_pci_dev(dev->dev);
+	int			res;
+	struct nvme_id_ctrl	*ctrl;
+	int			shift;
+
+	res = nvme_identify_ctrl(dev, &ctrl);
+	if (res) {
+		dev_err(dev->dev, "Identify Controller failed (%d)\n",
res);
+		return -EIO;
+	}
+
+	dev->oncs = le16_to_cpup(&ctrl->oncs);
+	dev->abort_limit = ctrl->acl + 1;
+	dev->vwc = ctrl->vwc;
+
+	memcpy(dev->serial, ctrl->sn, sizeof(ctrl->sn));
+	memcpy(dev->model, ctrl->mn, sizeof(ctrl->mn));
+	memcpy(dev->firmware_rev, ctrl->fr, sizeof(ctrl->fr));
+
+	shift = NVME_CAP_MPSMIN(readq(&pdev->bar->cap)) + 12;
+
+	if (ctrl->mdts)
+		dev->max_hw_sectors = 1 << (ctrl->mdts + shift - 9);
+
+	if ((pci_dev->vendor == PCI_VENDOR_ID_INTEL) &&
+	    (pci_dev->device == 0x0953) && ctrl->vs[3]) {
+		unsigned int max_hw_sectors;
+
+		dev->stripe_size = 1 << (ctrl->vs[3] + shift);
+		max_hw_sectors = dev->stripe_size >> (shift - 9);
+		if (dev->max_hw_sectors)
+			dev->max_hw_sectors = min(max_hw_sectors,
+						  dev
->max_hw_sectors);
+		else
+			dev->max_hw_sectors = max_hw_sectors;
+	}
+
+	kfree(ctrl);
+	schedule_work(&dev->scan_work);
+
+	return 0;
+}
+
+int nvme_pci_dev_map(struct nvme_dev *dev)
+{
+	u64 cap;
+	int bars, result = -ENOMEM;
+	struct pci_dev *pci_dev = to_pci_dev(dev->dev);
+	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
+
+	if (pci_enable_device_mem(pci_dev))
+		return result;
+
+	pdev->entry[0].vector = pci_dev->irq;
+
+	pci_set_master(pci_dev);
+	bars = pci_select_bars(pci_dev, IORESOURCE_MEM);
+	if (!bars)
+		goto disable_pci;
+
+	if (pci_request_selected_regions(pci_dev, bars, "nvme"))
+		goto disable_pci;
+
+	if (dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(64)) &&
+	    dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(32)))
+		goto disable;
+
+	pdev->bar = ioremap(pci_resource_start(pci_dev, 0), 8192);
+	if (!pdev->bar)
+		goto disable;
+
+	if (readl(&pdev->bar->csts) == -1) {
+		result = -ENODEV;
+		goto unmap;
+	}
+
+	/*
+	 * Some devices don't advertse INTx interrupts, pre-enable a
single
+	 * MSIX vec for setup. We'll adjust this later.
+	 */
+	if (!pci_dev->irq) {
+		result = pci_enable_msix(pci_dev, pdev->entry, 1);
+		if (result < 0)
+			goto unmap;
+	}
+
+	cap = readq(&pdev->bar->cap);
+	dev->q_depth = min_t(int, NVME_CAP_MQES(cap) + 1,
NVME_Q_DEPTH);
+	pdev->db_stride = 1 << NVME_CAP_STRIDE(cap);
+	pdev->dbs = ((void __iomem *)pdev->bar) + 4096;
+	if (readl(&pdev->bar->vs) >= NVME_VS(1, 2))
+		pdev->cmb = nvme_map_cmb(dev);
+
+	nvme_pci_set_irq_hints(dev);
+
+	return 0;
+
+ unmap:
+	iounmap(pdev->bar);
+	pdev->bar = NULL;
+ disable:
+	pci_release_regions(pci_dev);
+ disable_pci:
+	pci_disable_device(pci_dev);
+	return result;
+}
+
+void nvme_pci_dev_unmap(struct nvme_dev *dev)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev->dev);
+	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
+
+	if (!pdev)
+		return;
+
+	if (pci_dev->msi_enabled)
+		pci_disable_msi(pci_dev);
+	else if (pci_dev->msix_enabled)
+		pci_disable_msix(pci_dev);
+
+	if (!pdev->bar)
+		return;
+
+	iounmap(pdev->bar);
+	pdev->bar = NULL;
+	pci_release_regions(pci_dev);
+
+	if (pci_is_enabled(pci_dev))
+		pci_disable_device(pci_dev);
+}
+
+void nvme_pci_remove_dead_ctrl(struct nvme_dev *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+
+	if (pci_get_drvdata(pdev))
+		pci_stop_and_remove_bus_device_locked(pdev);
+}
+
+static void nvme_pci_reset_notify(struct pci_dev *pdev, bool prepare)
+{
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+	if (prepare)
+		nvme_dev_shutdown(dev);
+	else
+		nvme_dev_resume(dev);
+}
+
+static void nvme_pci_shutdown(struct pci_dev *pdev)
+{
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+	nvme_dev_shutdown(dev);
+}
+
+static void nvme_pci_remove(struct pci_dev *pci_dev)
+{
+	struct nvme_dev *dev = pci_get_drvdata(pci_dev);
+	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
+
+	nvme_remove(dev);
+
+	flush_work(&dev->probe_work);
+	flush_work(&dev->reset_work);
+	flush_work(&dev->scan_work);
+
+	kfree(pdev->entry);
+	kfree(pdev);
+
+	dev->context = NULL;
+
+	pci_set_drvdata(pci_dev, NULL);
+}
+
+static void nvme_dev_scan(struct work_struct *work)
+{
+	struct nvme_dev *dev = container_of(work, struct nvme_dev,
scan_work);
+	struct nvme_id_ctrl *ctrl;
+
+	if (!dev->tagset.tags)
+		return;
+	if (nvme_identify_ctrl(dev, &ctrl))
+		return;
+	nvme_scan_namespaces(dev, le32_to_cpup(&ctrl->nn));
+	kfree(ctrl);
+}
+
+static void nvme_async_probe(struct work_struct *work)
+{
+	struct nvme_dev *dev = container_of(work, struct nvme_dev,
probe_work);
+
+	if (nvme_dev_resume(dev) && !work_busy(&dev->reset_work))
+		nvme_dead_ctrl(dev);
+}
+
+static int nvme_pci_probe(struct pci_dev *pci_dev,
+			  const struct pci_device_id *id)
+{
+	struct nvme_dev *dev = NULL;
+	struct device *device = get_device(&pci_dev->dev);
+	struct nvme_pci_dev *pdev;
+	int node;
+
+	node = dev_to_node(device);
+	if (node == NUMA_NO_NODE)
+		set_dev_node(device, 0);
+
+	pdev = kzalloc_node(sizeof(*pdev), GFP_KERNEL, node);
+	if (!pdev)
+		return -ENOMEM;
+
+	pdev->entry = kzalloc_node(num_possible_cpus() * sizeof(*pdev
->entry),
+				   GFP_KERNEL, node);
+	if (!pdev->entry)
+		goto free;
+
+	dev = nvme_common_create_dev(device, pdev);
+	if (IS_ERR(dev)) {
+		pr_err("nvme_common_create_dev returned %ld",
+		       PTR_ERR(dev));
+		goto free;
+	}
+
+	pci_set_drvdata(pci_dev, dev);
+
+	INIT_WORK(&dev->scan_work, nvme_dev_scan);
+	INIT_WORK(&dev->probe_work, nvme_async_probe);
+	schedule_work(&dev->probe_work);
+	return 0;
+free:
+	kfree(pdev->entry);
+	kfree(pdev);
+	return -ENOMEM;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int nvme_pci_suspend(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct nvme_dev *ndev = pci_get_drvdata(pdev);
+
+	nvme_dev_shutdown(ndev);
+	return 0;
+}
+
+static int nvme_pci_resume(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct nvme_dev *ndev = pci_get_drvdata(pdev);
+
+	if (nvme_dev_resume(ndev))
+		nvme_common_reset_failed_dev(ndev);
+
+	return 0;
+}
+#endif
+
+/* These functions are yet to be implemented */
+#define nvme_pci_error_detected NULL
+#define nvme_pci_dump_registers NULL
+#define nvme_pci_link_reset NULL
+#define nvme_pci_slot_reset NULL
+#define nvme_pci_error_resume NULL
+
+static SIMPLE_DEV_PM_OPS(nvme_pci_dev_pm_ops, nvme_pci_suspend,
+			 nvme_pci_resume);
+
+static const struct pci_error_handlers nvme_pci_err_handler = {
+	.error_detected = nvme_pci_error_detected,
+	.mmio_enabled	= nvme_pci_dump_registers,
+	.link_reset	= nvme_pci_link_reset,
+	.slot_reset	= nvme_pci_slot_reset,
+	.resume		= nvme_pci_error_resume,
+	.reset_notify	= nvme_pci_reset_notify,
+};
+
+/* Move to pci_ids.h later */
+#define PCI_CLASS_STORAGE_EXPRESS	0x010802
+
+static const struct pci_device_id nvme_pci_id_table[] = {
+	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, nvme_pci_id_table);
+
+static struct pci_driver nvme_pci_driver = {
+	.name		= "nvme",
+	.id_table	= nvme_pci_id_table,
+	.probe		= nvme_pci_probe,
+	.remove		= nvme_pci_remove,
+	.shutdown	= nvme_pci_shutdown,
+	.driver	= {
+		.pm	= &nvme_pci_dev_pm_ops,
+	},
+	.err_handler	= &nvme_pci_err_handler,
+};
+
+int nvme_pci_init(void)
+{
+	int ret;
+
+	shutting_down = 0;
+
+	nvme_workq = alloc_workqueue("nvme_pci", WQ_MEM_RECLAIM, 1);
+	if (!nvme_workq)
+		return -ENOMEM;
+
+	ret = pci_register_driver(&nvme_pci_driver);
+	if (ret)
+		goto err1;
+
+	return 0;
+err1:
+	destroy_workqueue(nvme_workq);
+	return ret;
+}
+
+void nvme_pci_exit(void)
+{
+	shutting_down = 1;
+
+	pci_unregister_driver(&nvme_pci_driver);
+	destroy_workqueue(nvme_workq);
+}
+
+#ifdef CONFIG_NVME_PCI_MODULE
+MODULE_AUTHOR("Matthew Wilcox <willy at linux.intel.com>");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("1.0");
+
+module_init(nvme_pci_init);
+module_exit(nvme_pci_exit);
+#endif
diff --git a/drivers/nvme/host/scsi.c b/drivers/nvme/host/scsi.c
index 79342a6..f22d8b7 100644
--- a/drivers/nvme/host/scsi.c
+++ b/drivers/nvme/host/scsi.c
@@ -1,6 +1,5 @@
 /*
- * NVM Express device driver
- * Copyright (c) 2011-2014, Intel Corporation.
+ * Copyright (c) 2011-2015, Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or
modify it
  * under the terms and conditions of the GNU General Public License,
@@ -18,6 +17,7 @@
  */
 
 #include "common.h"
+#include "ops.h"
 #include "pci.h"
 
 #include <scsi/sg.h>
@@ -583,15 +583,16 @@ static int nvme_trans_device_id_page(struct
nvme_ns *ns, struct sg_io_hdr *hdr,
 					u8 *inq_response, int
alloc_len)
 {
 	struct nvme_dev *dev = ns->dev;
-	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
 	int res;
 	int nvme_sc;
 	int xfer_len;
+	int vs = nvme_pci_get_version(dev);
 	__be32 tmp_id = cpu_to_be32(ns->ns_id);
 
 	memset(inq_response, 0, alloc_len);
 	inq_response[1] = INQ_DEVICE_IDENTIFICATION_PAGE;    /* Page
Code */
-	if (readl(&pdev->bar->vs) >= NVME_VS(1, 1)) {
+
+	if (vs >= NVME_VS(1, 1)) {
 		struct nvme_id_ns *id_ns;
 		void *eui;
 		int len;
@@ -603,7 +604,8 @@ static int nvme_trans_device_id_page(struct nvme_ns
*ns, struct sg_io_hdr *hdr,
 
 		eui = id_ns->eui64;
 		len = sizeof(id_ns->eui64);
-		if (readl(&pdev->bar->vs) >= NVME_VS(1, 2)) {
+
+		if (vs >= NVME_VS(1, 2)) {
 			if (bitmap_empty(eui, len * 8)) {
 				eui = id_ns->nguid;
 				len = sizeof(id_ns->nguid);
@@ -2035,7 +2037,7 @@ static int nvme_trans_read_capacity(struct
nvme_ns *ns, struct sg_io_hdr *hdr,
 	nvme_sc = nvme_identify_ns(dev, ns->ns_id, &id_ns);
 	res = nvme_trans_status_code(hdr, nvme_sc);
 	if (res)
-		return res;	
+		return res;
 
 	response = kzalloc(resp_size, GFP_KERNEL);
 	if (response == NULL) {
@@ -2276,9 +2278,8 @@ static int nvme_trans_test_unit_ready(struct
nvme_ns *ns,
 					u8 *cmd)
 {
 	struct nvme_dev *dev = ns->dev;
-	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
 
-	if (!(readl(&pdev->bar->csts) & NVME_CSTS_RDY))
+	if (!nvme_pci_is_ready(dev))
 		return nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
 					    NOT_READY,
SCSI_ASC_LUN_NOT_READY,
 					   
 SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
-- 
1.7.1
