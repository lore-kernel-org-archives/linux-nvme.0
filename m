From: rlnelson@google.com (Rob Nelson)
Date: Mon, 31 Aug 2015 14:31:29 -0700
Subject: [PATCH] Improve performance for virtual NVMe devices.
Message-ID: <1441056689-64567-1-git-send-email-rlnelson@google.com>

This change provides a mechanism to reduce the number of MMIO doorbell
writes for the NVMe driver. When running in a virtualized environment
like QEMU, the cost of an MMIO is quite hefy here. The main idea for
the patch is provide the device two memory location locations:
 1) to store the doorbell values so they can be lookup without the doorbell
    MMIO write
 2) to store an event index.
I believe the doorbell value is obvious, the event index not so much.
Similar to the virtio specificaiton, the virtual device can tell the
driver (guest OS) not to write MMIO unless you are writing past this
value.

FYI: doorbell values are written by the nvme driver (guest OS) and the
event index is written by the virtual device (host OS).

The patch implements a new admin command that will communicate where
these two memory locations reside. If the command fails, the nvme
driver will work as before without any optimizations.

Contributions:
  Eric Northup <digitaleric at google.com>
  Frank Swiderski <fes at google.com>
  Ted Tso <tytso at mit.edu>
  Keith Busch <keith.busch at intel.com>

Just to give an idea on the performance boost with the vendor
extension: Running fio [1], a stock NVMe driver I get about 200K read
IOPs with my vendor patch I get about 1000K read IOPs. This was
running with a null device i.e. the backing device simply returned
success on every read IO request.

[1] Running on a 4 core machine:
  fio --time_based --name=benchmark --runtime=30
  --filename=/dev/nvme0n1 --nrfiles=1 --ioengine=libaio --iodepth=32
  --direct=1 --invalidate=1 --verify=0 --verify_fatal=0 --numjobs=4
  --rw=randread --blocksize=4k --randrepeat=false

Signed-off-by: Rob Nelson <rlnelson at google.com>
---
 drivers/block/nvme-core.c | 138 ++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/nvme.h      |   4 ++
 include/uapi/linux/nvme.h |   2 +
 3 files changed, 138 insertions(+), 6 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 7920c27..01fa534 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -63,6 +63,9 @@ static unsigned char shutdown_timeout = 5;
 module_param(shutdown_timeout, byte, 0644);
 MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");
 
+/* Google Vendor ID is not in include/linux/pci_ids.h */
+#define PCI_VENDOR_ID_GOOGLE 0x1AE0
+
 static int nvme_major;
 module_param(nvme_major, int, 0);
 
@@ -117,6 +120,10 @@ struct nvme_queue {
 	u8 cq_phase;
 	u8 cqe_seen;
 	struct async_cmd_info cmdinfo;
+	u32 *sq_doorbell_addr;
+	u32 *sq_eventidx_addr;
+	u32 *cq_doorbell_addr;
+	u32 *cq_eventidx_addr;
 };
 
 /*
@@ -372,6 +379,31 @@ static void *nvme_finish_cmd(struct nvme_queue *nvmeq, int tag,
 	return ctx;
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
+	smp_rmb();
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
@@ -384,9 +416,12 @@ static int __nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd)
 	u16 tail = nvmeq->sq_tail;
 
 	memcpy(&nvmeq->sq_cmds[tail], cmd, sizeof(*cmd));
+	if (nvmeq->sq_doorbell_addr)
+		smp_wmb();
 	if (++tail == nvmeq->q_depth)
 		tail = 0;
-	writel(tail, nvmeq->q_db);
+	write_doorbell(tail, nvmeq->q_db,
+		       nvmeq->sq_doorbell_addr, nvmeq->sq_eventidx_addr);
 	nvmeq->sq_tail = tail;
 
 	return 0;
@@ -767,10 +802,12 @@ static void nvme_submit_discard(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 	cmnd->dsm.prp1 = cpu_to_le64(iod->first_dma);
 	cmnd->dsm.nr = 0;
 	cmnd->dsm.attributes = cpu_to_le32(NVME_DSMGMT_AD);
+	if (nvmeq->sq_doorbell_addr)
+		smp_wmb();
 
 	if (++nvmeq->sq_tail == nvmeq->q_depth)
 		nvmeq->sq_tail = 0;
-	writel(nvmeq->sq_tail, nvmeq->q_db);
+	write_doorbell(nvmeq->sq_tail, nvmeq->q_db, nvmeq->sq_doorbell_addr, nvmeq->sq_eventidx_addr);
 }
 
 static void nvme_submit_flush(struct nvme_queue *nvmeq, struct nvme_ns *ns,
@@ -782,10 +819,12 @@ static void nvme_submit_flush(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 	cmnd->common.opcode = nvme_cmd_flush;
 	cmnd->common.command_id = cmdid;
 	cmnd->common.nsid = cpu_to_le32(ns->ns_id);
+	if (nvmeq->sq_doorbell_addr)
+		smp_wmb();
 
 	if (++nvmeq->sq_tail == nvmeq->q_depth)
 		nvmeq->sq_tail = 0;
-	writel(nvmeq->sq_tail, nvmeq->q_db);
+	write_doorbell(nvmeq->sq_tail, nvmeq->q_db, nvmeq->sq_doorbell_addr, nvmeq->sq_eventidx_addr);
 }
 
 static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod,
@@ -834,10 +873,13 @@ static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod,
 
 	cmnd->rw.control = cpu_to_le16(control);
 	cmnd->rw.dsmgmt = cpu_to_le32(dsmgmt);
+	if (nvmeq->sq_doorbell_addr)
+		smp_wmb();
 
 	if (++nvmeq->sq_tail == nvmeq->q_depth)
 		nvmeq->sq_tail = 0;
-	writel(nvmeq->sq_tail, nvmeq->q_db);
+	write_doorbell(nvmeq->sq_tail, nvmeq->q_db,
+		       nvmeq->sq_doorbell_addr, nvmeq->sq_eventidx_addr);
 
 	return 0;
 }
@@ -953,7 +995,10 @@ static int nvme_process_cq(struct nvme_queue *nvmeq)
 	for (;;) {
 		void *ctx;
 		nvme_completion_fn fn;
-		struct nvme_completion cqe = nvmeq->cqes[head];
+		struct nvme_completion cqe;
+		if (nvmeq->dev->pci_dev->vendor == PCI_VENDOR_ID_GOOGLE)
+			smp_rmb();
+		cqe = nvmeq->cqes[head];
 		if ((le16_to_cpu(cqe.status) & 1) != phase)
 			break;
 		nvmeq->sq_head = le16_to_cpu(cqe.sq_head);
@@ -974,7 +1019,8 @@ static int nvme_process_cq(struct nvme_queue *nvmeq)
 	if (head == nvmeq->cq_head && phase == nvmeq->cq_phase)
 		return 0;
 
-	writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
+	write_doorbell(head, nvmeq->q_db + nvmeq->dev->db_stride,
+		       nvmeq->cq_doorbell_addr, nvmeq->cq_eventidx_addr);
 	nvmeq->cq_head = head;
 	nvmeq->cq_phase = phase;
 
@@ -1210,6 +1256,18 @@ int nvme_identify_ns(struct nvme_dev *dev, unsigned nsid,
 	return error;
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
@@ -1423,6 +1481,10 @@ static void nvme_clear_queue(struct nvme_queue *nvmeq)
 	spin_lock_irq(&nvmeq->q_lock);
 	if (nvmeq->tags && *nvmeq->tags)
 		blk_mq_all_tag_busy_iter(*nvmeq->tags, nvme_cancel_queue_ios, nvmeq);
+	nvmeq->sq_doorbell_addr = NULL;
+	nvmeq->cq_doorbell_addr = NULL;
+	nvmeq->sq_eventidx_addr = NULL;
+	nvmeq->cq_eventidx_addr = NULL;
 	spin_unlock_irq(&nvmeq->q_lock);
 }
 
@@ -1511,6 +1573,16 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
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
 	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq->q_depth));
 	dev->online_queues++;
 	spin_unlock_irq(&nvmeq->q_lock);
@@ -2232,6 +2304,23 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 
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
+		if (res) { /* Free memory and continue on. */
+			dma_free_coherent(&pdev->dev, 8192, dev->db_mem,
+					  dev->doorbell);
+			dma_free_coherent(&pdev->dev, 8192, dev->ei_mem,
+					  dev->doorbell);
+			dev->db_mem = NULL;
+			dev->ei_mem = NULL;
+		}
+	}
 	nvme_create_io_queues(dev);
 
 	return 0;
@@ -2395,6 +2484,11 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	return 0;
 }
 
+static int nvme_vendor_memory_size(struct nvme_dev *dev)
+{
+	return ((num_possible_cpus() + 1) * 8 * dev->db_stride);
+}
+
 static int nvme_dev_map(struct nvme_dev *dev)
 {
 	u64 cap;
@@ -2441,8 +2535,28 @@ static int nvme_dev_map(struct nvme_dev *dev)
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
@@ -2456,6 +2570,18 @@ static int nvme_dev_map(struct nvme_dev *dev)
 static void nvme_dev_unmap(struct nvme_dev *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	int mem_size = nvme_vendor_memory_size(dev);
+
+	if (!dev->db_mem) {
+		dma_free_coherent(&dev->pci_dev->dev, mem_size, dev->db_mem,
+				  dev->doorbell);
+		dev->db_mem = NULL;
+	}
+	if (!dev->ei_mem) {
+		dma_free_coherent(&dev->pci_dev->dev, mem_size, dev->ei_mem,
+				  dev->eventidx);
+		dev->ei_mem = NULL;
+	}
 
 	if (pdev->msi_enabled)
 		pci_disable_msi(pdev);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index c0d94ed..ca71490 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -104,6 +104,10 @@ struct nvme_dev {
 	u16 abort_limit;
 	u8 event_limit;
 	u8 vwc;
+	u32 *db_mem;
+	dma_addr_t doorbell;
+	u32 *ei_mem;
+	dma_addr_t eventidx;
 };
 
 /*
diff --git a/include/uapi/linux/nvme.h b/include/uapi/linux/nvme.h
index 732b32e..29a66d2 100644
--- a/include/uapi/linux/nvme.h
+++ b/include/uapi/linux/nvme.h
@@ -332,6 +332,7 @@ enum nvme_admin_opcode {
 	nvme_admin_format_nvm		= 0x80,
 	nvme_admin_security_send	= 0x81,
 	nvme_admin_security_recv	= 0x82,
+	nvme_admin_doorbell_memory	= 0xC0,
 };
 
 enum {
@@ -520,6 +521,7 @@ enum {
 	NVME_SC_BAD_ATTRIBUTES		= 0x180,
 	NVME_SC_INVALID_PI		= 0x181,
 	NVME_SC_READ_ONLY		= 0x182,
+	NVME_SC_DOORBELL_MEMORY_INVALID	= 0x1C0,
 	NVME_SC_WRITE_FAULT		= 0x280,
 	NVME_SC_READ_ERROR		= 0x281,
 	NVME_SC_GUARD_CHECK		= 0x282,
-- 
2.5.0.457.gab17608
