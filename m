From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Mon, 28 Sep 2015 19:20:17 -0700
Subject: [PATCH 2/4] nvme: split pci specifics out of nvme_dev and
 nvme_queue structures
Message-ID: <1443493217.3449.14.camel@linux.intel.com>

>From f8a686150998471ea28347a946753cabc73bb79a Mon Sep 17 00:00:00 2001
From: Jay Sternberg <jay.e.sternberg@intel.com>
Date: Fri, 25 Sep 2015 12:20:59 -0700
Subject: [PATCH 2/4] nvme: split pci specifics out of nvme_dev and
nvme_queue structures

Signed-off-by: Jay Sternberg <jay.e.sternberg at intel.com>
---
 include/linux/nvme.h => drivers/nvme/host/common.h |  115 ++---
 drivers/nvme/host/core.c                           |  442 ++++++++++--
--------
 drivers/nvme/host/pci.h                            |  103 +++++
 drivers/nvme/host/scsi.c                           |   39 +--
 4 files changed, 392 insertions(+), 307 deletions(-)
 rename include/linux/nvme.h => drivers/nvme/host/common.h (61%)
 create mode 100644 drivers/nvme/host/pci.h

diff --git a/include/linux/nvme.h b/drivers/nvme/host/common.h
similarity index 61%
rename from include/linux/nvme.h
rename to drivers/nvme/host/common.h
index b5812c3..0c1ca8a 100644
--- a/include/linux/nvme.h
+++ b/drivers/nvme/host/common.h
@@ -12,83 +12,70 @@
  * more details.
  */
 
-#ifndef _LINUX_NVME_H
-#define _LINUX_NVME_H
+#ifndef _NVME_COMMON_H
+#define _NVME_COMMON_H
 
 #include <uapi/linux/nvme.h>
-#include <linux/pci.h>
 #include <linux/kref.h>
+#include <linux/kthread.h>
 #include <linux/blk-mq.h>
 
-struct nvme_bar {
-	__u64			cap;	/* Controller Capabilities */
-	__u32			vs;	/* Version */
-	__u32			intms;	/* Interrupt Mask Set */
-	__u32			intmc;	/* Interrupt Mask Clear */
-	__u32			cc;	/* Controller Configuration */
-	__u32			rsvd1;	/* Reserved */
-	__u32			csts;	/* Controller Status */
-	__u32			nssr;	/* Subsystem Reset */
-	__u32			aqa;	/* Admin Queue Attributes */
-	__u64			asq;	/* Admin SQ Base Address */
-	__u64			acq;	/* Admin CQ Base Address */
-	__u32			cmbloc; /* Controller Memory Buffer
Location */
-	__u32			cmbsz;  /* Controller Memory Buffer
Size */
-};
+#define NVME_MINORS		(1U << MINORBITS)
+#define ADMIN_TIMEOUT		(admin_timeout * HZ)
+#define NVME_IO_TIMEOUT		(nvme_io_timeout * HZ)
+#define SHUTDOWN_TIMEOUT	(shutdown_timeout * HZ)
+#define NVME_AQ_DEPTH		256
+#define NVME_Q_DEPTH		1024
+#define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
+#define CQ_SIZE(depth)		(depth * sizeof(struct
nvme_completion))
+
+extern unsigned char nvme_io_timeout;
 
-#define NVME_CAP_MQES(cap)	((cap) & 0xffff)
-#define NVME_CAP_TIMEOUT(cap)	(((cap) >> 24) & 0xff)
-#define NVME_CAP_STRIDE(cap)	(((cap) >> 32) & 0xf)
-#define NVME_CAP_NSSRC(cap)	(((cap) >> 36) & 0x1)
-#define NVME_CAP_MPSMIN(cap)	(((cap) >> 48) & 0xf)
-#define NVME_CAP_MPSMAX(cap)	(((cap) >> 52) & 0xf)
-
-#define NVME_CMB_BIR(cmbloc)	((cmbloc) & 0x7)
-#define NVME_CMB_OFST(cmbloc)	(((cmbloc) >> 12) & 0xfffff)
-#define NVME_CMB_SZ(cmbsz)	(((cmbsz) >> 12) & 0xfffff)
-#define NVME_CMB_SZU(cmbsz)	(((cmbsz) >> 8) & 0xf)
-
-#define NVME_CMB_WDS(cmbsz)	((cmbsz) & 0x10)
-#define NVME_CMB_RDS(cmbsz)	((cmbsz) & 0x8)
-#define NVME_CMB_LISTS(cmbsz)	((cmbsz) & 0x4)
-#define NVME_CMB_CQS(cmbsz)	((cmbsz) & 0x2)
-#define NVME_CMB_SQS(cmbsz)	((cmbsz) & 0x1)
-
-enum {
-	NVME_CC_ENABLE		= 1 << 0,
-	NVME_CC_CSS_NVM		= 0 << 4,
-	NVME_CC_MPS_SHIFT	= 7,
-	NVME_CC_ARB_RR		= 0 << 11,
-	NVME_CC_ARB_WRRU	= 1 << 11,
-	NVME_CC_ARB_VS		= 7 << 11,
-	NVME_CC_SHN_NONE	= 0 << 14,
-	NVME_CC_SHN_NORMAL	= 1 << 14,
-	NVME_CC_SHN_ABRUPT	= 2 << 14,
-	NVME_CC_SHN_MASK	= 3 << 14,
-	NVME_CC_IOSQES		= 6 << 16,
-	NVME_CC_IOCQES		= 4 << 20,
-	NVME_CSTS_RDY		= 1 << 0,
-	NVME_CSTS_CFS		= 1 << 1,
-	NVME_CSTS_NSSRO		= 1 << 4,
-	NVME_CSTS_SHST_NORMAL	= 0 << 2,
-	NVME_CSTS_SHST_OCCUR	= 1 << 2,
-	NVME_CSTS_SHST_CMPLT	= 2 << 2,
-	NVME_CSTS_SHST_MASK	= 3 << 2,
+struct async_cmd_info {
+	struct kthread_work work;
+	struct kthread_worker *worker;
+	struct request *req;
+	u32 result;
+	int status;
+	void *ctx;
 };
 
-extern unsigned char nvme_io_timeout;
-#define NVME_IO_TIMEOUT	(nvme_io_timeout * HZ)
+/*
+ * An NVM Express queue.  Each device has at least two (one for admin
+ * commands and one for I/O commands).
+ */
+struct nvme_queue {
+	struct device *q_dmadev;
+	struct nvme_dev *dev;
+	void *context;
+	spinlock_t q_lock;
+	struct nvme_command *sq_cmds;
+	struct nvme_command __iomem *sq_cmds_io;
+	volatile struct nvme_completion *cqes;
+	struct blk_mq_tags **tags;
+	dma_addr_t sq_dma_addr;
+	dma_addr_t cq_dma_addr;
+	u16 q_depth;
+	s16 cq_vector;
+	u16 sq_head;
+	u16 sq_tail;
+	u16 cq_head;
+	u16 qid;
+	u8 cq_phase;
+	u8 cqe_seen;
+	struct async_cmd_info cmdinfo;
+};
 
 /*
  * Represents an NVM Express device.  Each nvme_dev is a PCI function.
  */
 struct nvme_dev {
 	struct list_head node;
+	void *context;
 	struct nvme_queue **queues;
 	struct request_queue *admin_q;
 	struct blk_mq_tag_set tagset;
 	struct blk_mq_tag_set admin_tagset;
-	u32 __iomem *dbs;
 	struct device *dev;
 	struct dma_pool *prp_page_pool;
 	struct dma_pool *prp_small_pool;
@@ -97,10 +84,6 @@ struct nvme_dev {
 	unsigned online_queues;
 	unsigned max_qid;
 	int q_depth;
-	u32 db_stride;
-	u32 ctrl_config;
-	struct msix_entry *entry;
-	struct nvme_bar __iomem *bar;
 	struct list_head namespaces;
 	struct kref kref;
 	struct device *device;
@@ -116,10 +99,6 @@ struct nvme_dev {
 	u32 max_hw_sectors;
 	u32 stripe_size;
 	u32 page_size;
-	void __iomem *cmb;
-	dma_addr_t cmb_dma_addr;
-	u64 cmb_size;
-	u32 cmbsz;
 	u16 oncs;
 	u16 abort_limit;
 	u8 event_limit;
@@ -187,4 +166,4 @@ int nvme_sg_io(struct nvme_ns *ns, struct sg_io_hdr
__user *u_hdr);
 int nvme_sg_io32(struct nvme_ns *ns, unsigned long arg);
 int nvme_sg_get_version_num(int __user *ip);
 
-#endif /* _LINUX_NVME_H */
+#endif /* _NVME_COMMON_H */
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b97fc3f..dec3961 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -12,44 +12,22 @@
  * more details.
  */
 
-#include <linux/nvme.h>
-#include <linux/bitops.h>
-#include <linux/blkdev.h>
-#include <linux/blk-mq.h>
-#include <linux/cpu.h>
-#include <linux/delay.h>
-#include <linux/errno.h>
-#include <linux/fs.h>
-#include <linux/genhd.h>
+#include "common.h"
+#include "pci.h"
+
 #include <linux/hdreg.h>
-#include <linux/idr.h>
-#include <linux/init.h>
 #include <linux/interrupt.h>
-#include <linux/io.h>
-#include <linux/kdev_t.h>
-#include <linux/kthread.h>
 #include <linux/kernel.h>
 #include <linux/list_sort.h>
-#include <linux/mm.h>
 #include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/pci.h>
-#include <linux/poison.h>
+#include <linux/dmapool.h>
+#include <linux/dma-mapping.h>
+#include <linux/scatterlist.h>
 #include <linux/ptrace.h>
-#include <linux/sched.h>
-#include <linux/slab.h>
 #include <linux/t10-pi.h>
-#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
 #include <scsi/sg.h>
-#include <asm-generic/io-64-nonatomic-lo-hi.h>
-
-#define NVME_MINORS		(1U << MINORBITS)
-#define NVME_Q_DEPTH		1024
-#define NVME_AQ_DEPTH		256
-#define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
-#define CQ_SIZE(depth)		(depth * sizeof(struct
nvme_completion))
-#define ADMIN_TIMEOUT		(admin_timeout * HZ)
-#define SHUTDOWN_TIMEOUT	(shutdown_timeout * HZ)
 
 static unsigned char admin_timeout = 60;
 module_param(admin_timeout, byte, 0644);
@@ -88,42 +66,6 @@ static void nvme_reset_failed_dev(struct work_struct
*ws);
 static int nvme_reset(struct nvme_dev *dev);
 static int nvme_process_cq(struct nvme_queue *nvmeq);
 
-struct async_cmd_info {
-	struct kthread_work work;
-	struct kthread_worker *worker;
-	struct request *req;
-	u32 result;
-	int status;
-	void *ctx;
-};
-
-/*
- * An NVM Express queue.  Each device has at least two (one for admin
- * commands and one for I/O commands).
- */
-struct nvme_queue {
-	struct device *q_dmadev;
-	struct nvme_dev *dev;
-	char irqname[24];	/* nvme4294967295-65535\0 */
-	spinlock_t q_lock;
-	struct nvme_command *sq_cmds;
-	struct nvme_command __iomem *sq_cmds_io;
-	volatile struct nvme_completion *cqes;
-	struct blk_mq_tags **tags;
-	dma_addr_t sq_dma_addr;
-	dma_addr_t cq_dma_addr;
-	u32 __iomem *q_db;
-	u16 q_depth;
-	s16 cq_vector;
-	u16 sq_head;
-	u16 sq_tail;
-	u16 cq_head;
-	u16 qid;
-	u8 cq_phase;
-	u8 cqe_seen;
-	struct async_cmd_info cmdinfo;
-};
-
 /*
  * Check we didin't inadvertently grow the command struct
  */
@@ -387,6 +329,7 @@ static void *nvme_finish_cmd(struct nvme_queue
*nvmeq, int tag,
 static void __nvme_submit_cmd(struct nvme_queue *nvmeq,
 						struct nvme_command
*cmd)
 {
+	struct nvme_pci_queue *q = (struct nvme_pci_queue *) nvmeq
->context;
 	u16 tail = nvmeq->sq_tail;
 
 	if (nvmeq->sq_cmds_io)
@@ -396,7 +339,7 @@ static void __nvme_submit_cmd(struct nvme_queue
*nvmeq,
 
 	if (++tail == nvmeq->q_depth)
 		tail = 0;
-	writel(tail, nvmeq->q_db);
+	writel(tail, q->q_db);
 	nvmeq->sq_tail = tail;
 }
 
@@ -944,6 +887,9 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx
*hctx,
 
 static int nvme_process_cq(struct nvme_queue *nvmeq)
 {
+	struct nvme_pci_queue *q = (struct nvme_pci_queue *) nvmeq
->context;
+	struct nvme_dev *dev = nvmeq->dev;
+        struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
 	u16 head, phase;
 
 	head = nvmeq->cq_head;
@@ -973,7 +919,7 @@ static int nvme_process_cq(struct nvme_queue
*nvmeq)
 	if (head == nvmeq->cq_head && phase == nvmeq->cq_phase)
 		return 0;
 
-	writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
+	writel(head, q->q_db + pdev->db_stride);
 	nvmeq->cq_head = head;
 	nvmeq->cq_phase = phase;
 
@@ -1394,6 +1340,8 @@ static void nvme_free_queues(struct nvme_dev
*dev, int lowest)
  */
 static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 {
+	struct nvme_dev *dev = nvmeq->dev;
+        struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
 	int vector;
 
 	spin_lock_irq(&nvmeq->q_lock);
@@ -1401,13 +1349,13 @@ static int nvme_suspend_queue(struct nvme_queue
*nvmeq)
 		spin_unlock_irq(&nvmeq->q_lock);
 		return 1;
 	}
-	vector = nvmeq->dev->entry[nvmeq->cq_vector].vector;
-	nvmeq->dev->online_queues--;
+	vector = pdev->entry[nvmeq->cq_vector].vector;
+	dev->online_queues--;
 	nvmeq->cq_vector = -1;
 	spin_unlock_irq(&nvmeq->q_lock);
 
-	if (!nvmeq->qid && nvmeq->dev->admin_q)
-		blk_mq_freeze_queue_start(nvmeq->dev->admin_q);
+	if (!nvmeq->qid && dev->admin_q)
+		blk_mq_freeze_queue_start(dev->admin_q);
 
 	irq_set_affinity_hint(vector, NULL);
 	free_irq(vector, nvmeq);
@@ -1426,6 +1374,7 @@ static void nvme_clear_queue(struct nvme_queue
*nvmeq)
 static void nvme_disable_queue(struct nvme_dev *dev, int qid)
 {
 	struct nvme_queue *nvmeq = dev->queues[qid];
+        struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
 
 	if (!nvmeq)
 		return;
@@ -1434,7 +1383,7 @@ static void nvme_disable_queue(struct nvme_dev
*dev, int qid)
 
 	/* Don't tell the adapter to delete the admin queue.
 	 * Don't tell a removed adapter to delete IO queues. */
-	if (qid && readl(&dev->bar->csts) != -1) {
+	if (qid && readl(&pdev->bar->csts) != -1) {
 		adapter_delete_sq(dev, qid);
 		adapter_delete_cq(dev, qid);
 	}
@@ -1447,11 +1396,12 @@ static void nvme_disable_queue(struct nvme_dev
*dev, int qid)
 static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
 				int entry_size)
 {
+	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
 	int q_depth = dev->q_depth;
 	unsigned q_size_aligned = roundup(q_depth * entry_size, dev
->page_size);
 
-	if (q_size_aligned * nr_io_queues > dev->cmb_size) {
-		u64 mem_per_q = div_u64(dev->cmb_size, nr_io_queues);
+	if (q_size_aligned * nr_io_queues > pdev->cmb_size) {
+		u64 mem_per_q = div_u64(pdev->cmb_size, nr_io_queues);
 		mem_per_q = round_down(mem_per_q, dev->page_size);
 		q_depth = div_u64(mem_per_q, entry_size);
 
@@ -1470,11 +1420,13 @@ static int nvme_cmb_qdepth(struct nvme_dev
*dev, int nr_io_queues,
 static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue
*nvmeq,
 				int qid, int depth)
 {
-	if (qid && dev->cmb && use_cmb_sqes && NVME_CMB_SQS(dev
->cmbsz)) {
+	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
+
+	if (qid && pdev->cmb && use_cmb_sqes && NVME_CMB_SQS(pdev
->cmbsz)) {
 		unsigned offset = (qid - 1) *
 					roundup(SQ_SIZE(depth), dev
->page_size);
-		nvmeq->sq_dma_addr = dev->cmb_dma_addr + offset;
-		nvmeq->sq_cmds_io = dev->cmb + offset;
+		nvmeq->sq_dma_addr = pdev->cmb_dma_addr + offset;
+		nvmeq->sq_cmds_io = pdev->cmb + offset;
 	} else {
 		nvmeq->sq_cmds = dma_alloc_coherent(dev->dev,
SQ_SIZE(depth),
 					&nvmeq->sq_dma_addr,
GFP_KERNEL);
@@ -1488,31 +1440,48 @@ static int nvme_alloc_sq_cmds(struct nvme_dev
*dev, struct nvme_queue *nvmeq,
 static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int
qid,
 							int depth)
 {
-	struct nvme_queue *nvmeq = kzalloc(sizeof(*nvmeq),
GFP_KERNEL);
+	struct nvme_queue *nvmeq;
+	struct nvme_pci_queue *q;
+	struct nvme_pci_dev *pdev;
+
+	nvmeq = kzalloc(sizeof(*nvmeq), GFP_KERNEL);
 	if (!nvmeq)
 		return NULL;
 
+	q = kzalloc(sizeof(*q), GFP_KERNEL);
+	if (!q)
+		goto free_nvmeq;
+
+	nvmeq->context = q;
+
+	pdev = kzalloc(sizeof(*q), GFP_KERNEL);
+	if (!pdev)
+		goto free_pci_queue;
+
+	dev->context = pdev;
+
 	nvmeq->cqes = dma_zalloc_coherent(dev->dev, CQ_SIZE(depth),
 					  &nvmeq->cq_dma_addr,
GFP_KERNEL);
 	if (!nvmeq->cqes)
-		goto free_nvmeq;
+		goto free_pci_dev;
 
 	if (nvme_alloc_sq_cmds(dev, nvmeq, qid, depth))
 		goto free_cqdma;
 
 	nvmeq->q_dmadev = dev->dev;
 	nvmeq->dev = dev;
-	snprintf(nvmeq->irqname, sizeof(nvmeq->irqname), "nvme%dq%d",
-			dev->instance, qid);
 	spin_lock_init(&nvmeq->q_lock);
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
-	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
 	nvmeq->q_depth = depth;
 	nvmeq->qid = qid;
 	nvmeq->cq_vector = -1;
 	dev->queues[qid] = nvmeq;
 
+	q->q_db = &pdev->dbs[qid * 2 * pdev->db_stride];
+	snprintf(q->irqname, sizeof(q->irqname), "nvme%dq%d",
+			dev->instance, qid);
+
 	/* make sure queue descriptor is set before queue count, for
kthread */
 	mb();
 	dev->queue_count++;
@@ -1522,6 +1491,10 @@ static struct nvme_queue
*nvme_alloc_queue(struct nvme_dev *dev, int qid,
  free_cqdma:
 	dma_free_coherent(dev->dev, CQ_SIZE(depth), (void *)nvmeq
->cqes,
 							nvmeq
->cq_dma_addr);
+ free_pci_dev:
+	kfree(pdev);
+ free_pci_queue:
+	kfree(q);
  free_nvmeq:
 	kfree(nvmeq);
 	return NULL;
@@ -1530,23 +1503,29 @@ static struct nvme_queue
*nvme_alloc_queue(struct nvme_dev *dev, int qid,
 static int queue_request_irq(struct nvme_dev *dev, struct nvme_queue
*nvmeq,
 							const char
*name)
 {
+	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
+
 	if (use_threaded_interrupts)
-		return request_threaded_irq(dev->entry[nvmeq
->cq_vector].vector,
+		return request_threaded_irq(pdev->entry[nvmeq
->cq_vector].vector,
 					nvme_irq_check, nvme_irq,
IRQF_SHARED,
 					name, nvmeq);
-	return request_irq(dev->entry[nvmeq->cq_vector].vector,
nvme_irq,
+	return request_irq(pdev->entry[nvmeq->cq_vector].vector,
nvme_irq,
 				IRQF_SHARED, name, nvmeq);
 }
 
 static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 {
 	struct nvme_dev *dev = nvmeq->dev;
+	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
+	struct nvme_pci_queue *q = (struct nvme_pci_queue *) nvmeq
->context;
 
 	spin_lock_irq(&nvmeq->q_lock);
 	nvmeq->sq_tail = 0;
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
-	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
+
+	q->q_db = &pdev->dbs[qid * 2 * pdev->db_stride];
+
 	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq->q_depth));
 	dev->online_queues++;
 	spin_unlock_irq(&nvmeq->q_lock);
@@ -1554,6 +1533,7 @@ static void nvme_init_queue(struct nvme_queue
*nvmeq, u16 qid)
 
 static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 {
+	struct nvme_pci_queue *q = (struct nvme_pci_queue *) nvmeq
->context;
 	struct nvme_dev *dev = nvmeq->dev;
 	int result;
 
@@ -1566,7 +1546,7 @@ static int nvme_create_queue(struct nvme_queue
*nvmeq, int qid)
 	if (result < 0)
 		goto release_cq;
 
-	result = queue_request_irq(dev, nvmeq, nvmeq->irqname);
+	result = queue_request_irq(dev, nvmeq, q->irqname);
 	if (result < 0)
 		goto release_sq;
 
@@ -1582,12 +1562,13 @@ static int nvme_create_queue(struct nvme_queue
*nvmeq, int qid)
 
 static int nvme_wait_ready(struct nvme_dev *dev, u64 cap, bool
enabled)
 {
+	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
 	unsigned long timeout;
 	u32 bit = enabled ? NVME_CSTS_RDY : 0;
 
 	timeout = ((NVME_CAP_TIMEOUT(cap) + 1) * HZ / 2) + jiffies;
 
-	while ((readl(&dev->bar->csts) & NVME_CSTS_RDY) != bit) {
+	while ((readl(&pdev->bar->csts) & NVME_CSTS_RDY) != bit) {
 		msleep(100);
 		if (fatal_signal_pending(current))
 			return -EINTR;
@@ -1610,33 +1591,38 @@ static int nvme_wait_ready(struct nvme_dev
*dev, u64 cap, bool enabled)
  */
 static int nvme_disable_ctrl(struct nvme_dev *dev, u64 cap)
 {
-	dev->ctrl_config &= ~NVME_CC_SHN_MASK;
-	dev->ctrl_config &= ~NVME_CC_ENABLE;
-	writel(dev->ctrl_config, &dev->bar->cc);
+	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
+
+	pdev->ctrl_config &= ~NVME_CC_SHN_MASK;
+	pdev->ctrl_config &= ~NVME_CC_ENABLE;
+	writel(pdev->ctrl_config, &pdev->bar->cc);
 
 	return nvme_wait_ready(dev, cap, false);
 }
 
 static int nvme_enable_ctrl(struct nvme_dev *dev, u64 cap)
 {
-	dev->ctrl_config &= ~NVME_CC_SHN_MASK;
-	dev->ctrl_config |= NVME_CC_ENABLE;
-	writel(dev->ctrl_config, &dev->bar->cc);
+	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
+
+	pdev->ctrl_config &= ~NVME_CC_SHN_MASK;
+	pdev->ctrl_config |= NVME_CC_ENABLE;
+	writel(pdev->ctrl_config, &pdev->bar->cc);
 
 	return nvme_wait_ready(dev, cap, true);
 }
 
 static int nvme_shutdown_ctrl(struct nvme_dev *dev)
 {
+	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
 	unsigned long timeout;
 
-	dev->ctrl_config &= ~NVME_CC_SHN_MASK;
-	dev->ctrl_config |= NVME_CC_SHN_NORMAL;
+	pdev->ctrl_config &= ~NVME_CC_SHN_MASK;
+	pdev->ctrl_config |= NVME_CC_SHN_NORMAL;
 
-	writel(dev->ctrl_config, &dev->bar->cc);
+	writel(pdev->ctrl_config, &pdev->bar->cc);
 
 	timeout = SHUTDOWN_TIMEOUT + jiffies;
-	while ((readl(&dev->bar->csts) & NVME_CSTS_SHST_MASK) !=
+	while ((readl(&pdev->bar->csts) & NVME_CSTS_SHST_MASK) !=
 							NVME_CSTS_SHST
_CMPLT) {
 		msleep(100);
 		if (fatal_signal_pending(current))
@@ -1709,9 +1695,11 @@ static int nvme_alloc_admin_tags(struct nvme_dev
*dev)
 
 static int nvme_configure_admin_queue(struct nvme_dev *dev)
 {
+	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
+	struct nvme_pci_queue *q;
 	int result;
 	u32 aqa;
-	u64 cap = readq(&dev->bar->cap);
+	u64 cap = readq(&pdev->bar->cap);
 	struct nvme_queue *nvmeq;
 	unsigned page_shift = PAGE_SHIFT;
 	unsigned dev_page_min = NVME_CAP_MPSMIN(cap) + 12;
@@ -1732,11 +1720,11 @@ static int nvme_configure_admin_queue(struct
nvme_dev *dev)
 		page_shift = dev_page_max;
 	}
 
-	dev->subsystem = readl(&dev->bar->vs) >= NVME_VS(1, 1) ?
+	dev->subsystem = readl(&pdev->bar->vs) >= NVME_VS(1, 1) ?
 						NVME_CAP_NSSRC(cap) :
0;
 
-	if (dev->subsystem && (readl(&dev->bar->csts) &
NVME_CSTS_NSSRO))
-		writel(NVME_CSTS_NSSRO, &dev->bar->csts);
+	if (dev->subsystem && (readl(&pdev->bar->csts) &
NVME_CSTS_NSSRO))
+		writel(NVME_CSTS_NSSRO, &pdev->bar->csts);
 
 	result = nvme_disable_ctrl(dev, cap);
 	if (result < 0)
@@ -1754,21 +1742,23 @@ static int nvme_configure_admin_queue(struct
nvme_dev *dev)
 
 	dev->page_size = 1 << page_shift;
 
-	dev->ctrl_config = NVME_CC_CSS_NVM;
-	dev->ctrl_config |= (page_shift - 12) << NVME_CC_MPS_SHIFT;
-	dev->ctrl_config |= NVME_CC_ARB_RR | NVME_CC_SHN_NONE;
-	dev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
+	pdev->ctrl_config = NVME_CC_CSS_NVM;
+	pdev->ctrl_config |= (page_shift - 12) << NVME_CC_MPS_SHIFT;
+	pdev->ctrl_config |= NVME_CC_ARB_RR | NVME_CC_SHN_NONE;
+	pdev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
 
-	writel(aqa, &dev->bar->aqa);
-	writeq(nvmeq->sq_dma_addr, &dev->bar->asq);
-	writeq(nvmeq->cq_dma_addr, &dev->bar->acq);
+	writel(aqa, &pdev->bar->aqa);
+	writeq(nvmeq->sq_dma_addr, &pdev->bar->asq);
+	writeq(nvmeq->cq_dma_addr, &pdev->bar->acq);
 
 	result = nvme_enable_ctrl(dev, cap);
 	if (result)
 		goto free_nvmeq;
 
+	q = (struct nvme_pci_queue *) nvmeq->context;
+
 	nvmeq->cq_vector = 0;
-	result = queue_request_irq(dev, nvmeq, nvmeq->irqname);
+	result = queue_request_irq(dev, nvmeq, q->irqname);
 	if (result) {
 		nvmeq->cq_vector = -1;
 		goto free_nvmeq;
@@ -1900,10 +1890,12 @@ static int nvme_user_cmd(struct nvme_dev *dev,
struct nvme_ns *ns,
 
 static int nvme_subsys_reset(struct nvme_dev *dev)
 {
+	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
+
 	if (!dev->subsystem)
 		return -ENOTTY;
 
-	writel(0x4E564D65, &dev->bar->nssr); /* "NVMe" */
+	writel(0x4E564D65, &pdev->bar->nssr); /* "NVMe" */
 	return 0;
 }
 
@@ -2071,7 +2063,8 @@ static int nvme_kthread(void *data)
 		spin_lock(&dev_list_lock);
 		list_for_each_entry_safe(dev, next, &dev_list, node) {
 			int i;
-			u32 csts = readl(&dev->bar->csts);
+			struct nvme_pci_dev *pdev = (struct
nvme_pci_dev *) dev->context;
+			u32 csts = readl(&pdev->bar->csts);
 
 			if ((dev->subsystem && (csts &
NVME_CSTS_NSSRO)) ||
 							csts &
NVME_CSTS_CFS) {
@@ -2080,7 +2073,7 @@ static int nvme_kthread(void *data)
 				list_del_init(&dev->node);
 				dev_warn(dev->dev,
 					"Failed status: %x, reset
controller\n",
-					readl(&dev->bar->csts));
+					readl(&pdev->bar->csts));
 				dev->reset_workfn =
nvme_reset_failed_dev;
 				queue_work(nvme_workq, &dev
->reset_work);
 				continue;
@@ -2218,26 +2211,27 @@ static int set_queue_count(struct nvme_dev
*dev, int count)
 
 static void __iomem *nvme_map_cmb(struct nvme_dev *dev)
 {
+	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
 	u64 szu, size, offset;
 	u32 cmbloc;
 	resource_size_t bar_size;
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	struct pci_dev *pci_dev = to_pci_dev(dev->dev);
 	void __iomem *cmb;
 	dma_addr_t dma_addr;
 
 	if (!use_cmb_sqes)
 		return NULL;
 
-	dev->cmbsz = readl(&dev->bar->cmbsz);
-	if (!(NVME_CMB_SZ(dev->cmbsz)))
+	pdev->cmbsz = readl(&pdev->bar->cmbsz);
+	if (!(NVME_CMB_SZ(pdev->cmbsz)))
 		return NULL;
 
-	cmbloc = readl(&dev->bar->cmbloc);
+	cmbloc = readl(&pdev->bar->cmbloc);
 
-	szu = (u64)1 << (12 + 4 * NVME_CMB_SZU(dev->cmbsz));
-	size = szu * NVME_CMB_SZ(dev->cmbsz);
+	szu = (u64)1 << (12 + 4 * NVME_CMB_SZU(pdev->cmbsz));
+	size = szu * NVME_CMB_SZ(pdev->cmbsz);
 	offset = szu * NVME_CMB_OFST(cmbloc);
-	bar_size = pci_resource_len(pdev, NVME_CMB_BIR(cmbloc));
+	bar_size = pci_resource_len(pci_dev, NVME_CMB_BIR(cmbloc));
 
 	if (offset > bar_size)
 		return NULL;
@@ -2250,33 +2244,39 @@ static void __iomem *nvme_map_cmb(struct
nvme_dev *dev)
 	if (size > bar_size - offset)
 		size = bar_size - offset;
 
-	dma_addr = pci_resource_start(pdev, NVME_CMB_BIR(cmbloc)) +
offset;
+	dma_addr = pci_resource_start(pci_dev, NVME_CMB_BIR(cmbloc)) +
offset;
 	cmb = ioremap_wc(dma_addr, size);
 	if (!cmb)
 		return NULL;
 
-	dev->cmb_dma_addr = dma_addr;
-	dev->cmb_size = size;
+	pdev->cmb_dma_addr = dma_addr;
+	pdev->cmb_size = size;
 	return cmb;
 }
 
 static inline void nvme_release_cmb(struct nvme_dev *dev)
 {
-	if (dev->cmb) {
-		iounmap(dev->cmb);
-		dev->cmb = NULL;
+	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
+
+	if (pdev->cmb) {
+		iounmap(pdev->cmb);
+		pdev->cmb = NULL;
 	}
 }
 
 static size_t db_bar_size(struct nvme_dev *dev, unsigned nr_io_queues)
 {
-	return 4096 + ((nr_io_queues + 1) * 8 * dev->db_stride);
+	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
+
+	return 4096 + ((nr_io_queues + 1) * 8 * pdev->db_stride);
 }
 
 static int nvme_setup_io_queues(struct nvme_dev *dev)
 {
+	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
 	struct nvme_queue *adminq = dev->queues[0];
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	struct nvme_pci_queue *q = (struct nvme_pci_queue *) adminq
->context;
+	struct pci_dev *pci_dev = to_pci_dev(dev->dev);
 	int result, i, vecs, nr_io_queues, size;
 
 	nr_io_queues = num_possible_cpus();
@@ -2286,7 +2286,7 @@ static int nvme_setup_io_queues(struct nvme_dev
*dev)
 	if (result < nr_io_queues)
 		nr_io_queues = result;
 
-	if (dev->cmb && NVME_CMB_SQS(dev->cmbsz)) {
+	if (pdev->cmb && NVME_CMB_SQS(pdev->cmbsz)) {
 		result = nvme_cmb_qdepth(dev, nr_io_queues,
 				sizeof(struct nvme_command));
 		if (result > 0)
@@ -2297,39 +2297,40 @@ static int nvme_setup_io_queues(struct nvme_dev
*dev)
 
 	size = db_bar_size(dev, nr_io_queues);
 	if (size > 8192) {
-		iounmap(dev->bar);
+		iounmap(pdev->bar);
 		do {
-			dev->bar = ioremap(pci_resource_start(pdev,
0), size);
-			if (dev->bar)
+			pdev->bar =
ioremap(pci_resource_start(pci_dev, 0),
+					    size);
+			if (pdev->bar)
 				break;
 			if (!--nr_io_queues)
 				return -ENOMEM;
 			size = db_bar_size(dev, nr_io_queues);
 		} while (1);
-		dev->dbs = ((void __iomem *)dev->bar) + 4096;
-		adminq->q_db = dev->dbs;
+		pdev->dbs = ((void __iomem *)pdev->bar) + 4096;
+		q->q_db = pdev->dbs;
 	}
 
 	/* Deregister the admin queue's interrupt */
-	free_irq(dev->entry[0].vector, adminq);
+	free_irq(pdev->entry[0].vector, adminq);
 
 	/*
 	 * If we enable msix early due to not intx, disable it again
before
 	 * setting up the full range we need.
 	 */
-	if (!pdev->irq)
-		pci_disable_msix(pdev);
+	if (!pci_dev->irq)
+		pci_disable_msix(pci_dev);
 
 	for (i = 0; i < nr_io_queues; i++)
-		dev->entry[i].entry = i;
-	vecs = pci_enable_msix_range(pdev, dev->entry, 1,
nr_io_queues);
+		pdev->entry[i].entry = i;
+	vecs = pci_enable_msix_range(pci_dev, pdev->entry, 1,
nr_io_queues);
 	if (vecs < 0) {
-		vecs = pci_enable_msi_range(pdev, 1, min(nr_io_queues,
32));
+		vecs = pci_enable_msi_range(pci_dev, 1,
min(nr_io_queues, 32));
 		if (vecs < 0) {
 			vecs = 1;
 		} else {
 			for (i = 0; i < vecs; i++)
-				dev->entry[i].vector = i + pdev->irq;
+				pdev->entry[i].vector = i + pci_dev
->irq;
 		}
 	}
 
@@ -2342,7 +2343,7 @@ static int nvme_setup_io_queues(struct nvme_dev
*dev)
 	nr_io_queues = vecs;
 	dev->max_qid = nr_io_queues;
 
-	result = queue_request_irq(dev, adminq, adminq->irqname);
+	result = queue_request_irq(dev, adminq, q->irqname);
 	if (result) {
 		adminq->cq_vector = -1;
 		goto free_queues;
@@ -2394,7 +2395,9 @@ static struct nvme_ns *nvme_find_ns(struct
nvme_dev *dev, unsigned nsid)
 
 static inline bool nvme_io_incapable(struct nvme_dev *dev)
 {
-	return (!dev->bar || readl(&dev->bar->csts) & NVME_CSTS_CFS ||
+	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
+
+	return (!pdev->bar || readl(&pdev->bar->csts) & NVME_CSTS_CFS
||
 							dev
->online_queues < 2);
 }
 
@@ -2460,10 +2463,11 @@ static void nvme_dev_scan(struct work_struct
*work)
  */
 static int nvme_dev_add(struct nvme_dev *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
+	struct pci_dev *pci_dev = to_pci_dev(dev->dev);
 	int res;
 	struct nvme_id_ctrl *ctrl;
-	int shift = NVME_CAP_MPSMIN(readq(&dev->bar->cap)) + 12;
+	int shift = NVME_CAP_MPSMIN(readq(&pdev->bar->cap)) + 12;
 
 	res = nvme_identify_ctrl(dev, &ctrl);
 	if (res) {
@@ -2479,8 +2483,8 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	memcpy(dev->firmware_rev, ctrl->fr, sizeof(ctrl->fr));
 	if (ctrl->mdts)
 		dev->max_hw_sectors = 1 << (ctrl->mdts + shift - 9);
-	if ((pdev->vendor == PCI_VENDOR_ID_INTEL) &&
-			(pdev->device == 0x0953) && ctrl->vs[3]) {
+	if ((pci_dev->vendor == PCI_VENDOR_ID_INTEL) &&
+			(pci_dev->device == 0x0953) && ctrl->vs[3]) {
 		unsigned int max_hw_sectors;
 
 		dev->stripe_size = 1 << (ctrl->vs[3] + shift);
@@ -2515,29 +2519,30 @@ static int nvme_dev_map(struct nvme_dev *dev)
 {
 	u64 cap;
 	int bars, result = -ENOMEM;
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	struct pci_dev *pci_dev = to_pci_dev(dev->dev);
+	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
 
-	if (pci_enable_device_mem(pdev))
+	if (pci_enable_device_mem(pci_dev))
 		return result;
 
-	dev->entry[0].vector = pdev->irq;
-	pci_set_master(pdev);
-	bars = pci_select_bars(pdev, IORESOURCE_MEM);
+	pdev->entry[0].vector = pci_dev->irq;
+	pci_set_master(pci_dev);
+	bars = pci_select_bars(pci_dev, IORESOURCE_MEM);
 	if (!bars)
 		goto disable_pci;
 
-	if (pci_request_selected_regions(pdev, bars, "nvme"))
+	if (pci_request_selected_regions(pci_dev, bars, "nvme"))
 		goto disable_pci;
 
 	if (dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(64)) &&
 	    dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(32)))
 		goto disable;
 
-	dev->bar = ioremap(pci_resource_start(pdev, 0), 8192);
-	if (!dev->bar)
+	pdev->bar = ioremap(pci_resource_start(pci_dev, 0), 8192);
+	if (!pdev->bar)
 		goto disable;
 
-	if (readl(&dev->bar->csts) == -1) {
+	if (readl(&pdev->bar->csts) == -1) {
 		result = -ENODEV;
 		goto unmap;
 	}
@@ -2546,48 +2551,50 @@ static int nvme_dev_map(struct nvme_dev *dev)
 	 * Some devices don't advertse INTx interrupts, pre-enable a
single
 	 * MSIX vec for setup. We'll adjust this later.
 	 */
-	if (!pdev->irq) {
-		result = pci_enable_msix(pdev, dev->entry, 1);
+	if (!pci_dev->irq) {
+		result = pci_enable_msix(pci_dev, pdev->entry, 1);
 		if (result < 0)
 			goto unmap;
 	}
 
-	cap = readq(&dev->bar->cap);
+	cap = readq(&pdev->bar->cap);
 	dev->q_depth = min_t(int, NVME_CAP_MQES(cap) + 1,
NVME_Q_DEPTH);
-	dev->db_stride = 1 << NVME_CAP_STRIDE(cap);
-	dev->dbs = ((void __iomem *)dev->bar) + 4096;
-	if (readl(&dev->bar->vs) >= NVME_VS(1, 2))
-		dev->cmb = nvme_map_cmb(dev);
+
+	pdev->db_stride = 1 << NVME_CAP_STRIDE(cap);
+	pdev->dbs = ((void __iomem *)pdev->bar) + 4096;
+	if (readl(&pdev->bar->vs) >= NVME_VS(1, 2))
+		pdev->cmb = nvme_map_cmb(dev);
 
 	return 0;
 
  unmap:
-	iounmap(dev->bar);
-	dev->bar = NULL;
+	iounmap(pdev->bar);
+	pdev->bar = NULL;
  disable:
-	pci_release_regions(pdev);
+	pci_release_regions(pci_dev);
  disable_pci:
-	pci_disable_device(pdev);
+	pci_disable_device(pci_dev);
 	return result;
 }
 
 static void nvme_dev_unmap(struct nvme_dev *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	struct pci_dev *pci_dev = to_pci_dev(dev->dev);
+	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
 
-	if (pdev->msi_enabled)
-		pci_disable_msi(pdev);
-	else if (pdev->msix_enabled)
-		pci_disable_msix(pdev);
+	if (pci_dev->msi_enabled)
+		pci_disable_msi(pci_dev);
+	else if (pci_dev->msix_enabled)
+		pci_disable_msix(pci_dev);
 
-	if (dev->bar) {
-		iounmap(dev->bar);
-		dev->bar = NULL;
-		pci_release_regions(pdev);
+	if (pdev->bar) {
+		iounmap(pdev->bar);
+		pdev->bar = NULL;
+		pci_release_regions(pci_dev);
 	}
 
-	if (pci_is_enabled(pdev))
-		pci_disable_device(pdev);
+	if (pci_is_enabled(pci_dev))
+		pci_disable_device(pci_dev);
 }
 
 struct nvme_delq_ctx {
@@ -2598,6 +2605,8 @@ struct nvme_delq_ctx {
 
 static void nvme_wait_dq(struct nvme_delq_ctx *dq, struct nvme_dev
*dev)
 {
+	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
+
 	dq->waiter = current;
 	mb();
 
@@ -2615,7 +2624,7 @@ static void nvme_wait_dq(struct nvme_delq_ctx
*dq, struct nvme_dev *dev)
 			 * queues than admin tags.
 			 */
 			set_current_state(TASK_RUNNING);
-			nvme_disable_ctrl(dev, readq(&dev->bar->cap));
+			nvme_disable_ctrl(dev, readq(&pdev->bar
->cap));
 			nvme_clear_queue(dev->queues[0]);
 			flush_kthread_worker(dq->worker);
 			nvme_disable_queue(dev, 0);
@@ -2780,14 +2789,15 @@ static void nvme_unfreeze_queues(struct
nvme_dev *dev)
 
 static void nvme_dev_shutdown(struct nvme_dev *dev)
 {
+	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
 	int i;
 	u32 csts = -1;
 
 	nvme_dev_list_remove(dev);
 
-	if (dev->bar) {
+	if (pdev->bar) {
 		nvme_freeze_queues(dev);
-		csts = readl(&dev->bar->csts);
+		csts = readl(&pdev->bar->csts);
 	}
 	if (csts & NVME_CSTS_CFS || !(csts & NVME_CSTS_RDY)) {
 		for (i = dev->queue_count - 1; i >= 0; i--) {
@@ -2876,6 +2886,7 @@ static void nvme_free_namespaces(struct nvme_dev
*dev)
 static void nvme_free_dev(struct kref *kref)
 {
 	struct nvme_dev *dev = container_of(kref, struct nvme_dev,
kref);
+	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
 
 	put_device(dev->dev);
 	put_device(dev->device);
@@ -2886,7 +2897,7 @@ static void nvme_free_dev(struct kref *kref)
 	if (dev->admin_q)
 		blk_put_queue(dev->admin_q);
 	kfree(dev->queues);
-	kfree(dev->entry);
+	kfree(pdev->entry);
 	kfree(dev);
 }
 
@@ -2955,6 +2966,7 @@ static const struct file_operations nvme_dev_fops
= {
 
 static void nvme_set_irq_hints(struct nvme_dev *dev)
 {
+	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
 	struct nvme_queue *nvmeq;
 	int i;
 
@@ -2964,7 +2976,7 @@ static void nvme_set_irq_hints(struct nvme_dev
*dev)
 		if (!nvmeq->tags || !(*nvmeq->tags))
 			continue;
 
-		irq_set_affinity_hint(dev->entry[nvmeq
->cq_vector].vector,
+		irq_set_affinity_hint(pdev->entry[nvmeq
->cq_vector].vector,
 					blk_mq_tags_cpumask(*nvmeq
->tags));
 	}
 }
@@ -3031,10 +3043,10 @@ static int nvme_dev_start(struct nvme_dev *dev)
 static int nvme_remove_dead_ctrl(void *arg)
 {
 	struct nvme_dev *dev = (struct nvme_dev *)arg;
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	struct pci_dev *pci_dev = to_pci_dev(dev->dev);
 
-	if (pci_get_drvdata(pdev))
-		pci_stop_and_remove_bus_device_locked(pdev);
+	if (pci_get_drvdata(pci_dev))
+		pci_stop_and_remove_bus_device_locked(pci_dev);
 	kref_put(&dev->kref, nvme_free_dev);
 	return 0;
 }
@@ -3152,32 +3164,40 @@ static ssize_t nvme_sysfs_reset(struct device
*dev,
 static DEVICE_ATTR(reset_controller, S_IWUSR, NULL, nvme_sysfs_reset);
 
 static void nvme_async_probe(struct work_struct *work);
-static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id
*id)
+static int nvme_probe(struct pci_dev *pci_dev, const struct
pci_device_id *id)
 {
 	int node, result = -ENOMEM;
 	struct nvme_dev *dev;
+	struct nvme_pci_dev *pdev;
 
-	node = dev_to_node(&pdev->dev);
+	node = dev_to_node(&pci_dev->dev);
 	if (node == NUMA_NO_NODE)
-		set_dev_node(&pdev->dev, 0);
+		set_dev_node(&pci_dev->dev, 0);
 
 	dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, node);
 	if (!dev)
 		return -ENOMEM;
-	dev->entry = kzalloc_node(num_possible_cpus() * sizeof(*dev
->entry),
-							GFP_KERNEL,
node);
-	if (!dev->entry)
-		goto free;
 	dev->queues = kzalloc_node((num_possible_cpus() + 1) *
sizeof(void *),
 							GFP_KERNEL,
node);
 	if (!dev->queues)
-		goto free;
+		goto free_dev;
+
+	pdev = kzalloc_node(sizeof(*pdev), GFP_KERNEL, node);
+	if (!pdev)
+		goto free_dev;
+
+	dev->context = pdev;
+
+	pdev->entry = kzalloc_node(num_possible_cpus() * sizeof(*pdev
->entry),
+							GFP_KERNEL,
node);
+	if (!pdev->entry)
+		goto free_pdev;
 
 	INIT_LIST_HEAD(&dev->namespaces);
 	dev->reset_workfn = nvme_reset_failed_dev;
 	INIT_WORK(&dev->reset_work, nvme_reset_workfn);
-	dev->dev = get_device(&pdev->dev);
-	pci_set_drvdata(pdev, dev);
+	dev->dev = get_device(&pci_dev->dev);
+	pci_set_drvdata(pci_dev, dev);
 	result = nvme_set_instance(dev);
 	if (result)
 		goto put_pci;
@@ -3187,7 +3207,7 @@ static int nvme_probe(struct pci_dev *pdev, const
struct pci_device_id *id)
 		goto release;
 
 	kref_init(&dev->kref);
-	dev->device = device_create(nvme_class, &pdev->dev,
+	dev->device = device_create(nvme_class, &pci_dev->dev,
 				MKDEV(nvme_char_major, dev->instance),
 				dev, "nvme%d", dev->instance);
 	if (IS_ERR(dev->device)) {
@@ -3216,9 +3236,11 @@ static int nvme_probe(struct pci_dev *pdev,
const struct pci_device_id *id)
 	nvme_release_instance(dev);
  put_pci:
 	put_device(dev->dev);
- free:
+ free_pdev:
+	kfree(pdev->entry);
+	kfree(pdev);
+ free_dev:
 	kfree(dev->queues);
-	kfree(dev->entry);
 	kfree(dev);
 	return result;
 }
@@ -3231,9 +3253,9 @@ static void nvme_async_probe(struct work_struct
*work)
 		nvme_dead_ctrl(dev);
 }
 
-static void nvme_reset_notify(struct pci_dev *pdev, bool prepare)
+static void nvme_reset_notify(struct pci_dev *pci_dev, bool prepare)
 {
-	struct nvme_dev *dev = pci_get_drvdata(pdev);
+	struct nvme_dev *dev = pci_get_drvdata(pci_dev);
 
 	if (prepare)
 		nvme_dev_shutdown(dev);
@@ -3241,21 +3263,21 @@ static void nvme_reset_notify(struct pci_dev
*pdev, bool prepare)
 		nvme_dev_resume(dev);
 }
 
-static void nvme_shutdown(struct pci_dev *pdev)
+static void nvme_shutdown(struct pci_dev *pci_dev)
 {
-	struct nvme_dev *dev = pci_get_drvdata(pdev);
+	struct nvme_dev *dev = pci_get_drvdata(pci_dev);
 	nvme_dev_shutdown(dev);
 }
 
-static void nvme_remove(struct pci_dev *pdev)
+static void nvme_remove(struct pci_dev *pci_dev)
 {
-	struct nvme_dev *dev = pci_get_drvdata(pdev);
+	struct nvme_dev *dev = pci_get_drvdata(pci_dev);
 
 	spin_lock(&dev_list_lock);
 	list_del_init(&dev->node);
 	spin_unlock(&dev_list_lock);
 
-	pci_set_drvdata(pdev, NULL);
+	pci_set_drvdata(pci_dev, NULL);
 	flush_work(&dev->probe_work);
 	flush_work(&dev->reset_work);
 	flush_work(&dev->scan_work);
@@ -3280,8 +3302,8 @@ static void nvme_remove(struct pci_dev *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int nvme_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct nvme_dev *ndev = pci_get_drvdata(pdev);
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	struct nvme_dev *ndev = pci_get_drvdata(pci_dev);
 
 	nvme_dev_shutdown(ndev);
 	return 0;
@@ -3289,8 +3311,8 @@ static int nvme_suspend(struct device *dev)
 
 static int nvme_resume(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct nvme_dev *ndev = pci_get_drvdata(pdev);
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	struct nvme_dev *ndev = pci_get_drvdata(pci_dev);
 
 	if (nvme_dev_resume(ndev) && !work_busy(&ndev->reset_work)) {
 		ndev->reset_workfn = nvme_reset_failed_dev;
diff --git a/drivers/nvme/host/pci.h b/drivers/nvme/host/pci.h
new file mode 100644
index 0000000..030d29b
--- /dev/null
+++ b/drivers/nvme/host/pci.h
@@ -0,0 +1,103 @@
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
+ *
+ *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~
+ *
+ * The NVMe Fabrics project separates the NVMe (Non-Volatile Memory
express)
+ * SSD protocol from the physical technology or 'fabric' (RDMA,
ethernet,
+ * PCIe, etc) used as the bus communication mechanism between the
storage
+ * device and the rest of the system. Thus, this initial NVMe
framework
+ * makes no assumption that a technology like PCIe or RDMA is being
+ * used to carry out the protocol.
+ *
+ * This file is used to specify all pci specific data structures and
+ * functions that would implement PCI NVMe device.
+ */
+
+#ifndef _NVME_PCI_H
+#define _NVME_PCI_H
+
+#define NVME_CAP_MQES(cap)	((cap) & 0xffff)
+#define NVME_CAP_TIMEOUT(cap)	(((cap) >> 24) & 0xff)
+#define NVME_CAP_STRIDE(cap)	(((cap) >> 32) & 0xf)
+#define NVME_CAP_NSSRC(cap)	(((cap) >> 36) & 0x1)
+#define NVME_CAP_MPSMIN(cap)	(((cap) >> 48) & 0xf)
+#define NVME_CAP_MPSMAX(cap)	(((cap) >> 52) & 0xf)
+
+#define NVME_CMB_BIR(cmbloc)	((cmbloc) & 0x7)
+#define NVME_CMB_OFST(cmbloc)	(((cmbloc) >> 12) & 0xfffff)
+#define NVME_CMB_SZ(cmbsz)	(((cmbsz) >> 12) & 0xfffff)
+#define NVME_CMB_SZU(cmbsz)	(((cmbsz) >> 8) & 0xf)
+
+#define NVME_CMB_WDS(cmbsz)	((cmbsz) & 0x10)
+#define NVME_CMB_RDS(cmbsz)	((cmbsz) & 0x8)
+#define NVME_CMB_LISTS(cmbsz)	((cmbsz) & 0x4)
+#define NVME_CMB_CQS(cmbsz)	((cmbsz) & 0x2)
+#define NVME_CMB_SQS(cmbsz)	((cmbsz) & 0x1)
+
+enum {
+	NVME_CC_ENABLE		= 1 << 0,
+	NVME_CC_CSS_NVM		= 0 << 4,
+	NVME_CC_MPS_SHIFT	= 7,
+	NVME_CC_ARB_RR		= 0 << 11,
+	NVME_CC_ARB_WRRU	= 1 << 11,
+	NVME_CC_ARB_VS		= 7 << 11,
+	NVME_CC_SHN_NONE	= 0 << 14,
+	NVME_CC_SHN_NORMAL	= 1 << 14,
+	NVME_CC_SHN_ABRUPT	= 2 << 14,
+	NVME_CC_SHN_MASK	= 3 << 14,
+	NVME_CC_IOSQES		= 6 << 16,
+	NVME_CC_IOCQES		= 4 << 20,
+	NVME_CSTS_RDY		= 1 << 0,
+	NVME_CSTS_CFS		= 1 << 1,
+	NVME_CSTS_NSSRO		= 1 << 4,
+	NVME_CSTS_SHST_NORMAL	= 0 << 2,
+	NVME_CSTS_SHST_OCCUR	= 1 << 2,
+	NVME_CSTS_SHST_CMPLT	= 2 << 2,
+	NVME_CSTS_SHST_MASK	= 3 << 2,
+};
+
+struct nvme_bar {
+	__u64			cap;	/* Controller Capabilities */
+	__u32			vs;	/* Version */
+	__u32			intms;	/* Interrupt Mask Set */
+	__u32			intmc;	/* Interrupt Mask Clear */
+	__u32			cc;	/* Controller Configuration */
+	__u32			rsvd1;	/* Reserved */
+	__u32			csts;	/* Controller Status */
+	__u32			nssr;	/* Subsystem Reset */
+	__u32			aqa;	/* Admin Queue Attributes */
+	__u64			asq;	/* Admin SQ Base Address */
+	__u64			acq;	/* Admin CQ Base Address */
+	__u32			cmbloc;	/* Controller Memory
Buffer Location */
+	__u32			cmbsz;	/* Controller Memory Buffer
Size */
+};
+
+struct nvme_pci_dev {
+	struct pci_dev		*pci_dev;
+	u32			db_stride;
+	u32			ctrl_config;
+	u32 __iomem		*dbs;
+	struct msix_entry	*entry;
+	struct nvme_bar __iomem	*bar;
+        void __iomem		*cmb;
+        dma_addr_t		cmb_dma_addr;
+        u64			cmb_size;
+        u32			cmbsz;
+};
+struct nvme_pci_queue {
+	/* i.e. nvme4294967295-65535\0 */
+	char			irqname[24];
+	u32 __iomem		*q_db;
+};
+
+#endif	/* _NVME_PCI_H */
diff --git a/drivers/nvme/host/scsi.c b/drivers/nvme/host/scsi.c
index e5a63f0..79342a6 100644
--- a/drivers/nvme/host/scsi.c
+++ b/drivers/nvme/host/scsi.c
@@ -17,34 +17,13 @@
  * each command is translated.
  */
 
-#include <linux/nvme.h>
-#include <linux/bio.h>
-#include <linux/bitops.h>
-#include <linux/blkdev.h>
-#include <linux/compat.h>
-#include <linux/delay.h>
-#include <linux/errno.h>
-#include <linux/fs.h>
-#include <linux/genhd.h>
-#include <linux/idr.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
-#include <linux/kdev_t.h>
-#include <linux/kthread.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/pci.h>
-#include <linux/poison.h>
-#include <linux/sched.h>
-#include <linux/slab.h>
-#include <linux/types.h>
-#include <asm/unaligned.h>
+#include "common.h"
+#include "pci.h"
+
 #include <scsi/sg.h>
 #include <scsi/scsi.h>
-
+#include <linux/pci.h>
+#include <asm/unaligned.h>
 
 static int sg_version_num = 30534;	/* 2 digits for each component
*/
 
@@ -604,6 +583,7 @@ static int nvme_trans_device_id_page(struct nvme_ns
*ns, struct sg_io_hdr *hdr,
 					u8 *inq_response, int
alloc_len)
 {
 	struct nvme_dev *dev = ns->dev;
+	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
 	int res;
 	int nvme_sc;
 	int xfer_len;
@@ -611,7 +591,7 @@ static int nvme_trans_device_id_page(struct nvme_ns
*ns, struct sg_io_hdr *hdr,
 
 	memset(inq_response, 0, alloc_len);
 	inq_response[1] = INQ_DEVICE_IDENTIFICATION_PAGE;    /* Page
Code */
-	if (readl(&dev->bar->vs) >= NVME_VS(1, 1)) {
+	if (readl(&pdev->bar->vs) >= NVME_VS(1, 1)) {
 		struct nvme_id_ns *id_ns;
 		void *eui;
 		int len;
@@ -623,7 +603,7 @@ static int nvme_trans_device_id_page(struct nvme_ns
*ns, struct sg_io_hdr *hdr,
 
 		eui = id_ns->eui64;
 		len = sizeof(id_ns->eui64);
-		if (readl(&dev->bar->vs) >= NVME_VS(1, 2)) {
+		if (readl(&pdev->bar->vs) >= NVME_VS(1, 2)) {
 			if (bitmap_empty(eui, len * 8)) {
 				eui = id_ns->nguid;
 				len = sizeof(id_ns->nguid);
@@ -2296,8 +2276,9 @@ static int nvme_trans_test_unit_ready(struct
nvme_ns *ns,
 					u8 *cmd)
 {
 	struct nvme_dev *dev = ns->dev;
+	struct nvme_pci_dev *pdev = (struct nvme_pci_dev *) dev
->context;
 
-	if (!(readl(&dev->bar->csts) & NVME_CSTS_RDY))
+	if (!(readl(&pdev->bar->csts) & NVME_CSTS_RDY))
 		return nvme_trans_completion(hdr,
SAM_STAT_CHECK_CONDITION,
 					    NOT_READY,
SCSI_ASC_LUN_NOT_READY,
 					   
 SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
-- 
1.7.1
