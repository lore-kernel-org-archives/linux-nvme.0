From: rlnelson@google.com (Rob Nelson)
Date: Fri, 10 Oct 2014 14:20:49 -0700
Subject: [PATCH v2] Improve performance for virtual NVMe devices.
Message-ID: <1412976049-30301-1-git-send-email-rlnelson@google.com>

From: Robert Nelson <rlnelson@google.com>

Changes from v1
 - Applied comments from Keith.
  * Fixed error handling for doorbell and event index memory reference.
  * Move doorbell command to io queue setup call.

Signed-off-by: Robert Nelson <rlnelson at google.com>
---
 drivers/block/nvme-core.c | 142 +++++++++++++++++++++++++++++++++++++++++++---
 include/linux/nvme.h      |   4 ++
 include/uapi/linux/nvme.h |   2 +
 3 files changed, 140 insertions(+), 8 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 28aec2d..6ddbd6a 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -62,6 +62,9 @@ static unsigned char retry_time = 30;
 module_param(retry_time, byte, 0644);
 MODULE_PARM_DESC(retry_time, "time in seconds to retry failed I/O");
 
+/* Google Vendor ID is not in include/linux/pci_ids.h */
+#define PCI_VENDOR_ID_GOOGLE 0x1AE0
+
 static int nvme_major;
 module_param(nvme_major, int, 0);
 
@@ -114,12 +117,16 @@ struct nvme_queue {
 	u8 cqe_seen;
 	u8 q_suspended;
 	cpumask_var_t cpu_mask;
+	u32 *sq_doorbell_addr;
+	u32 *sq_eventidx_addr;
+	u32 *cq_doorbell_addr;
+	u32 *cq_eventidx_addr;
 	struct async_cmd_info cmdinfo;
 	unsigned long cmdid_data[];
 };
 
 /*
- * Check we didin't inadvertently grow the command struct
+ * Check we didn't inadvertently grow the command struct
  */
 static inline void _nvme_check_size(void)
 {
@@ -336,6 +343,31 @@ static void unlock_nvmeq(struct nvme_queue *nvmeq) __releases(RCU)
 	rcu_read_unlock();
 }
 
+static inline int nvme_need_event(u16 event_idx, u16 new_idx, u16 old)
+{
+	/* Borrowed from vring_need_event */
+	return (u16)(new_idx - event_idx - 1) < (u16)(new_idx - old);
+}
+
+static void write_doorbell(u16 value, u32 __iomem *q_db,
+			   u32 *db_addr, volatile u32 *event_idx) {
+	u16 old_value;
+	if (!db_addr)
+		goto ring_doorbell;
+
+	old_value = *db_addr;
+	*db_addr = value;
+
+	rmb();
+	if (!nvme_need_event(*event_idx, value, old_value))
+		goto no_doorbell;
+
+ring_doorbell:
+	writel(value, q_db);
+no_doorbell:
+	return;
+}
+
 /**
  * nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
  * @nvmeq: The queue to use
@@ -354,9 +386,12 @@ static int nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd)
 	}
 	tail = nvmeq->sq_tail;
 	memcpy(&nvmeq->sq_cmds[tail], cmd, sizeof(*cmd));
+	if (nvmeq->sq_doorbell_addr)
+		wmb();
 	if (++tail == nvmeq->q_depth)
 		tail = 0;
-	writel(tail, nvmeq->q_db);
+	write_doorbell(tail, nvmeq->q_db,
+		       nvmeq->sq_doorbell_addr, nvmeq->sq_eventidx_addr);
 	nvmeq->sq_tail = tail;
 	spin_unlock_irqrestore(&nvmeq->q_lock, flags);
 
@@ -643,11 +678,13 @@ static int nvme_submit_discard(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 	cmnd->dsm.prp1 = cpu_to_le64(iod->first_dma);
 	cmnd->dsm.nr = 0;
 	cmnd->dsm.attributes = cpu_to_le32(NVME_DSMGMT_AD);
+	if (nvmeq->sq_doorbell_addr)
+		wmb();
 
 	if (++nvmeq->sq_tail == nvmeq->q_depth)
 		nvmeq->sq_tail = 0;
-	writel(nvmeq->sq_tail, nvmeq->q_db);
-
+	write_doorbell(nvmeq->sq_tail, nvmeq->q_db,
+		       nvmeq->sq_doorbell_addr, nvmeq->sq_eventidx_addr);
 	return 0;
 }
 
@@ -660,10 +697,13 @@ static int nvme_submit_flush(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 	cmnd->common.opcode = nvme_cmd_flush;
 	cmnd->common.command_id = cmdid;
 	cmnd->common.nsid = cpu_to_le32(ns->ns_id);
+	if (nvmeq->dev->pci_dev->vendor == PCI_VENDOR_ID_GOOGLE)
+		wmb();
 
 	if (++nvmeq->sq_tail == nvmeq->q_depth)
 		nvmeq->sq_tail = 0;
-	writel(nvmeq->sq_tail, nvmeq->q_db);
+	write_doorbell(nvmeq->sq_tail, nvmeq->q_db,
+		       nvmeq->sq_doorbell_addr, nvmeq->sq_eventidx_addr);
 
 	return 0;
 }
@@ -709,10 +749,13 @@ static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod)
 		cpu_to_le16((bio->bi_iter.bi_size >> ns->lba_shift) - 1);
 	cmnd->rw.control = cpu_to_le16(control);
 	cmnd->rw.dsmgmt = cpu_to_le32(dsmgmt);
+	if (nvmeq->dev->pci_dev->vendor == PCI_VENDOR_ID_GOOGLE)
+		wmb();
 
 	if (++nvmeq->sq_tail == nvmeq->q_depth)
 		nvmeq->sq_tail = 0;
-	writel(nvmeq->sq_tail, nvmeq->q_db);
+	write_doorbell(nvmeq->sq_tail, nvmeq->q_db,
+		       nvmeq->sq_doorbell_addr, nvmeq->sq_eventidx_addr);
 
 	return 0;
 }
@@ -806,6 +849,8 @@ static int nvme_process_cq(struct nvme_queue *nvmeq)
 	for (;;) {
 		void *ctx;
 		nvme_completion_fn fn;
+		if (nvmeq->dev->pci_dev->vendor == PCI_VENDOR_ID_GOOGLE)
+			rmb();
 		struct nvme_completion cqe = nvmeq->cqes[head];
 		if ((le16_to_cpu(cqe.status) & 1) != phase)
 			break;
@@ -828,7 +873,8 @@ static int nvme_process_cq(struct nvme_queue *nvmeq)
 	if (head == nvmeq->cq_head && phase == nvmeq->cq_phase)
 		return 0;
 
-	writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
+	write_doorbell(head, nvmeq->q_db + nvmeq->dev->db_stride,
+		       nvmeq->cq_doorbell_addr, nvmeq->cq_eventidx_addr);
 	nvmeq->cq_head = head;
 	nvmeq->cq_phase = phase;
 
@@ -1071,6 +1117,18 @@ int nvme_identify(struct nvme_dev *dev, unsigned nsid, unsigned cns,
 	return nvme_submit_admin_cmd(dev, &c, NULL);
 }
 
+int nvme_doorbell_memory(struct nvme_dev *dev)
+{
+	struct nvme_command c;
+
+	memset(&c, 0, sizeof(c));
+	c.common.opcode = nvme_admin_doorbell_memory;
+	c.common.prp1 = cpu_to_le64(dev->doorbell);
+	c.common.prp2 = cpu_to_le64(dev->eventidx);
+
+	return nvme_submit_admin_cmd(dev, &c, NULL);
+}
+
 int nvme_get_features(struct nvme_dev *dev, unsigned fid, unsigned nsid,
 					dma_addr_t dma_addr, u32 *result)
 {
@@ -1260,6 +1318,10 @@ static void nvme_clear_queue(struct nvme_queue *nvmeq)
 	spin_lock_irq(&nvmeq->q_lock);
 	nvme_process_cq(nvmeq);
 	nvme_cancel_ios(nvmeq, false);
+	nvmeq->sq_doorbell_addr = NULL;
+	nvmeq->cq_doorbell_addr = NULL;
+	nvmeq->sq_eventidx_addr = NULL;
+	nvmeq->cq_eventidx_addr = NULL;
 	spin_unlock_irq(&nvmeq->q_lock);
 }
 
@@ -1355,6 +1417,16 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
+	if (dev->pci_dev->vendor == PCI_VENDOR_ID_GOOGLE && qid) {
+		nvmeq->sq_doorbell_addr =
+				&dev->db_mem[qid * 2 * dev->db_stride];
+		nvmeq->cq_doorbell_addr =
+				&dev->db_mem[(qid * 2 + 1) * dev->db_stride];
+		nvmeq->sq_eventidx_addr =
+				&dev->ei_mem[qid * 2 * dev->db_stride];
+		nvmeq->cq_eventidx_addr =
+				&dev->ei_mem[(qid * 2 + 1) * dev->db_stride];
+	}
 	memset(nvmeq->cmdid_data, 0, extra);
 	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq->q_depth));
 	nvme_cancel_ios(nvmeq, false);
@@ -2266,6 +2338,25 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 
 	/* Free previously allocated queues that are no longer usable */
 	nvme_free_queues(dev, nr_io_queues + 1);
+
+	/*
+	 * If this is device is from Google, it's a virtual device and send
+	 * a doorbell command to use guest memory for doorbell writes. Note
+	 * this command must be called before nvme_init_queue().
+	 */
+	if (pdev->vendor == PCI_VENDOR_ID_GOOGLE) {
+		int res = nvme_doorbell_memory(dev);
+		if (res) {
+			/* Free memory and continue on. */
+			dma_free_coherent(&pdev->dev, 8192, dev->db_mem,
+					dev->doorbell);
+			dma_free_coherent(&pdev->dev, 8192, dev->ei_mem,
+					dev->doorbell);
+			dev->db_mem = NULL;
+			dev->ei_mem = NULL;
+		}
+	}
+
 	nvme_assign_io_queues(dev);
 
 	return 0;
@@ -2332,7 +2423,6 @@ static int nvme_dev_add(struct nvme_dev *dev)
 							dma_addr + 4096, NULL);
 		if (res)
 			memset(mem + 4096, 0, 4096);
-
 		ns = nvme_alloc_ns(dev, i, mem, mem + 4096);
 		if (ns)
 			list_add_tail(&ns->list, &dev->namespaces);
@@ -2346,6 +2436,11 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	return res;
 }
 
+static int nvme_vendor_memory_size(struct nvme_dev *dev)
+{
+	return ((num_possible_cpus() + 1) * 8 * dev->db_stride);
+}
+
 static int nvme_dev_map(struct nvme_dev *dev)
 {
 	u64 cap;
@@ -2377,8 +2472,28 @@ static int nvme_dev_map(struct nvme_dev *dev)
 	dev->db_stride = 1 << NVME_CAP_STRIDE(cap);
 	dev->dbs = ((void __iomem *)dev->bar) + 4096;
 
+	if (pdev->vendor == PCI_VENDOR_ID_GOOGLE) {
+		int mem_size = nvme_vendor_memory_size(dev);
+		dev->db_mem = dma_alloc_coherent(&pdev->dev, mem_size,
+						&dev->doorbell, GFP_KERNEL);
+		if (!dev->db_mem) {
+			result = -ENOMEM;
+			goto unmap;
+		}
+		dev->ei_mem = dma_alloc_coherent(&pdev->dev, mem_size,
+						&dev->eventidx, GFP_KERNEL);
+		if (!dev->ei_mem) {
+			result = -ENOMEM;
+			goto dma_free;
+		}
+	}
+
 	return 0;
 
+ dma_free:
+	dma_free_coherent(&pdev->dev, nvme_vendor_memory_size(dev),
+			dev->db_mem, dev->doorbell);
+	dev->db_mem = NULL;
  unmap:
 	iounmap(dev->bar);
 	dev->bar = NULL;
@@ -2391,6 +2506,17 @@ static int nvme_dev_map(struct nvme_dev *dev)
 
 static void nvme_dev_unmap(struct nvme_dev *dev)
 {
+	int mem_size = nvme_vendor_memory_size(dev);
+	if (!dev->db_mem) {
+		dma_free_coherent(&dev->pci_dev->dev, mem_size, dev->db_mem,
+				dev->doorbell);
+		dev->db_mem = NULL;
+	}
+	if (!dev->ei_mem) {
+		dma_free_coherent(&dev->pci_dev->dev, mem_size, dev->ei_mem,
+				dev->eventidx);
+		dev->ei_mem = NULL;
+	}
 	if (dev->pci_dev->msi_enabled)
 		pci_disable_msi(dev->pci_dev);
 	else if (dev->pci_dev->msix_enabled)
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index ed09074..2315db7 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -104,6 +104,10 @@ struct nvme_dev {
 	u8 event_limit;
 	u8 vwc;
 	u8 initialized;
+	u32 *db_mem;
+	dma_addr_t doorbell;
+	u32 *ei_mem;
+	dma_addr_t eventidx;
 };
 
 /*
diff --git a/include/uapi/linux/nvme.h b/include/uapi/linux/nvme.h
index 134518b..cf81e34 100644
--- a/include/uapi/linux/nvme.h
+++ b/include/uapi/linux/nvme.h
@@ -285,6 +285,7 @@ enum nvme_admin_opcode {
 	nvme_admin_format_nvm		= 0x80,
 	nvme_admin_security_send	= 0x81,
 	nvme_admin_security_recv	= 0x82,
+	nvme_admin_doorbell_memory	= 0xC0,
 };
 
 enum {
@@ -469,6 +470,7 @@ enum {
 	NVME_SC_BAD_ATTRIBUTES		= 0x180,
 	NVME_SC_INVALID_PI		= 0x181,
 	NVME_SC_READ_ONLY		= 0x182,
+	NVME_SC_DOORBELL_MEMORY_INVALID	= 0x1C0,
 	NVME_SC_WRITE_FAULT		= 0x280,
 	NVME_SC_READ_ERROR		= 0x281,
 	NVME_SC_GUARD_CHECK		= 0x282,
-- 
2.1.0.rc2.206.gedb03e5
