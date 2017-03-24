From: helen.koike@collabora.com (Helen Koike)
Date: Fri, 24 Mar 2017 01:23:43 -0300
Subject: [PATCH v5 RFC] nvme: improve performance for virtual NVMe devices
In-Reply-To: <20170317222843.GD13709@localhost.localdomain>
References: <20170317222843.GD13709@localhost.localdomain>
Message-ID: <1490329423-17152-1-git-send-email-helen.koike@collabora.com>

This change provides a mechanism to reduce the number of MMIO doorbell
writes for the NVMe driver. When running in a virtualized environment
like QEMU, the cost of an MMIO is quite hefy here. The main idea for
the patch is provide the device two memory location locations:
 1) to store the doorbell values so they can be lookup without the doorbell
    MMIO write
 2) to store an event index.
I believe the doorbell value is obvious, the event index not so much.
Similar to the virtio specification, the virtual device can tell the
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
[mlin: port for upstream]
Signed-off-by: Ming Lin <mlin at kernel.org>
[koike: updated for upstream]
Signed-off-by: Helen Koike <helen.koike at collabora.com>

---

This patch is based on git://git.infradead.org/nvme.git master
Tested through Google Cloud Engine
TPAR is ratified by the NVME working group

Changes since v4
	- Remove CONFIG_NVME_DBBUF
	- Remove dbbuf.{c,h}, move the code to pci.c
	- Coding style changes
	- Functions and vaiables renamed

Changes since v3
	- Rename to dbbuf (be closer to the latest TPAR)
	- Modify the opcodes according to the latest TPAR
	- Check if the device support this feature through the OACS bit
	- little cleanups
---
 drivers/nvme/host/pci.c | 144 +++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/nvme.h    |  13 +++++
 2 files changed, 155 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5b7bd9c..4289eb1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -51,6 +51,8 @@
 #define NVME_AQ_DEPTH		256
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
 #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
+#define SQ_IDX(qid, stride)	((qid) * 2 * (stride))
+#define CQ_IDX(qid, stride)	(((qid) * 2 + 1) * (stride))
 
 /*
  * We handle AEN commands ourselves and don't even let the
@@ -103,6 +105,12 @@ struct nvme_dev {
 	u32 cmbloc;
 	struct nvme_ctrl ctrl;
 	struct completion ioq_wait;
+	struct {
+		u32 *dbs;
+		u32 *eis;
+		dma_addr_t dbs_dma_addr;
+		dma_addr_t eis_dma_addr;
+	} dbbuf;
 };
 
 static inline struct nvme_dev *to_nvme_dev(struct nvme_ctrl *ctrl)
@@ -133,6 +141,12 @@ struct nvme_queue {
 	u16 qid;
 	u8 cq_phase;
 	u8 cqe_seen;
+	struct {
+		u32 *sq_db;
+		u32 *cq_db;
+		u32 *sq_ei;
+		u32 *cq_ei;
+	} dbbuf;
 };
 
 /*
@@ -174,6 +188,121 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_id_ns) != 4096);
 	BUILD_BUG_ON(sizeof(struct nvme_lba_range_type) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_smart_log) != 512);
+	BUILD_BUG_ON(sizeof(struct nvme_dbbuf) != 64);
+}
+
+static inline unsigned int nvme_dbbuf_size(u32 stride)
+{
+	return ((num_possible_cpus() + 1) * 8 * stride);
+}
+
+static int nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
+{
+	unsigned int mem_size = nvme_dbbuf_size(dev->db_stride);
+
+	dev->dbbuf.dbs = dma_alloc_coherent(dev->dev, mem_size,
+					    &dev->dbbuf.dbs_dma_addr,
+					    GFP_KERNEL);
+	if (!dev->dbbuf.dbs)
+		return -ENOMEM;
+	dev->dbbuf.eis = dma_alloc_coherent(dev->dev, mem_size,
+					    &dev->dbbuf.eis_dma_addr,
+					    GFP_KERNEL);
+	if (!dev->dbbuf.eis) {
+		dma_free_coherent(dev->dev, mem_size,
+				  dev->dbbuf.dbs, dev->dbbuf.dbs_dma_addr);
+		dev->dbbuf.dbs = NULL;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void nvme_dbbuf_dma_free(struct nvme_dev *dev)
+{
+	unsigned int mem_size = nvme_dbbuf_size(dev->db_stride);
+
+	if (dev->dbbuf.dbs) {
+		dma_free_coherent(dev->dev, mem_size,
+				  dev->dbbuf.dbs, dev->dbbuf.dbs_dma_addr);
+		dev->dbbuf.dbs = NULL;
+	}
+	if (dev->dbbuf.eis) {
+		dma_free_coherent(dev->dev, mem_size,
+				  dev->dbbuf.eis, dev->dbbuf.eis_dma_addr);
+		dev->dbbuf.eis = NULL;
+	}
+}
+
+static void nvme_dbbuf_init(struct nvme_dev *dev,
+			    struct nvme_queue *nvmeq, int qid)
+{
+	if (!dev->dbbuf.dbs || !qid)
+		return;
+
+	nvmeq->dbbuf.sq_db = &dev->dbbuf.dbs[SQ_IDX(qid, dev->db_stride)];
+	nvmeq->dbbuf.cq_db = &dev->dbbuf.dbs[CQ_IDX(qid, dev->db_stride)];
+	nvmeq->dbbuf.sq_ei = &dev->dbbuf.eis[SQ_IDX(qid, dev->db_stride)];
+	nvmeq->dbbuf.cq_ei = &dev->dbbuf.eis[CQ_IDX(qid, dev->db_stride)];
+}
+
+static void nvme_dbbuf_set(struct nvme_dev *dev)
+{
+	struct nvme_command c;
+
+	if (!dev->dbbuf.dbs)
+		return;
+
+	memset(&c, 0, sizeof(c));
+	c.dbbuf.opcode = nvme_admin_dbbuf;
+	c.dbbuf.prp1 = cpu_to_le64(dev->dbbuf.dbs_dma_addr);
+	c.dbbuf.prp2 = cpu_to_le64(dev->dbbuf.eis_dma_addr);
+
+	if (nvme_submit_sync_cmd(dev->ctrl.admin_q, &c, NULL, 0))
+		/* Free memory and continue on */
+		nvme_dbbuf_dma_free(dev);
+}
+
+static inline int nvme_dbbuf_need_event(u16 event_idx, u16 new_idx, u16 old)
+{
+	/* Borrowed from vring_need_event */
+	return (u16)(new_idx - event_idx - 1) < (u16)(new_idx - old);
+}
+
+static void nvme_write_doorbell(u16 value,
+				u32 __iomem *db,
+				u32 *dbbuf_db,
+				volatile u32 *dbbuf_ei)
+{
+	u16 old_value;
+
+	if (!dbbuf_db) {
+		writel(value, db);
+		return;
+	}
+
+	/*
+	 * Ensure that the queue is written before updating
+	 * the doorbell in memory
+	 */
+	wmb();
+
+	old_value = *dbbuf_db;
+	*dbbuf_db = value;
+	if (nvme_dbbuf_need_event(*dbbuf_ei, value, old_value))
+		writel(value, db);
+}
+
+static inline void nvme_write_doorbell_cq(struct nvme_queue *nvmeq, u16 value)
+{
+	nvme_write_doorbell(value, nvmeq->q_db + nvmeq->dev->db_stride,
+			    nvmeq->dbbuf.cq_db, nvmeq->dbbuf.cq_ei);
+}
+
+static inline void nvme_write_doorbell_sq(struct nvme_queue *nvmeq, u16 value)
+{
+	nvme_write_doorbell(value, nvmeq->q_db,
+			    nvmeq->dbbuf.sq_db, nvmeq->dbbuf.sq_ei);
 }
 
 /*
@@ -300,7 +429,7 @@ static void __nvme_submit_cmd(struct nvme_queue *nvmeq,
 
 	if (++tail == nvmeq->q_depth)
 		tail = 0;
-	writel(tail, nvmeq->q_db);
+	nvme_write_doorbell_sq(nvmeq, tail);
 	nvmeq->sq_tail = tail;
 }
 
@@ -716,7 +845,7 @@ static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
 		return;
 
 	if (likely(nvmeq->cq_vector >= 0))
-		writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
+		nvme_write_doorbell_cq(nvmeq, head);
 	nvmeq->cq_head = head;
 	nvmeq->cq_phase = phase;
 
@@ -1066,6 +1195,7 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 	nvmeq->q_depth = depth;
 	nvmeq->qid = qid;
 	nvmeq->cq_vector = -1;
+	nvme_dbbuf_init(dev, nvmeq, qid);
 	dev->queues[qid] = nvmeq;
 	dev->queue_count++;
 
@@ -1099,6 +1229,7 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	nvmeq->cq_phase = 1;
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
 	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq->q_depth));
+	nvme_dbbuf_init(dev, nvmeq, qid);
 	dev->online_queues++;
 	spin_unlock_irq(&nvmeq->q_lock);
 }
@@ -1568,6 +1699,8 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		if (blk_mq_alloc_tag_set(&dev->tagset))
 			return 0;
 		dev->ctrl.tagset = &dev->tagset;
+
+		nvme_dbbuf_set(dev);
 	} else {
 		blk_mq_update_nr_hw_queues(&dev->tagset, dev->online_queues - 1);
 
@@ -1700,6 +1833,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 		nvme_disable_admin_queue(dev, shutdown);
 	}
 	nvme_pci_disable(dev);
+	nvme_dbbuf_dma_free(dev);
 
 	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_request, &dev->ctrl);
 	blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_cancel_request, &dev->ctrl);
@@ -1800,6 +1934,12 @@ static void nvme_reset_work(struct work_struct *work)
 		dev->ctrl.opal_dev = NULL;
 	}
 
+	if (dev->ctrl.oacs & NVME_CTRL_OACS_DBBUF_SUPP) {
+		result = nvme_dbbuf_dma_alloc(dev);
+		if (result)
+			goto out;
+	}
+
 	result = nvme_setup_io_queues(dev);
 	if (result)
 		goto out;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index c43d435..43a6289 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -245,6 +245,7 @@ enum {
 	NVME_CTRL_ONCS_WRITE_ZEROES		= 1 << 3,
 	NVME_CTRL_VWC_PRESENT			= 1 << 0,
 	NVME_CTRL_OACS_SEC_SUPP                 = 1 << 0,
+	NVME_CTRL_OACS_DBBUF_SUPP		= 1 << 7,
 };
 
 struct nvme_lbaf {
@@ -603,6 +604,7 @@ enum nvme_admin_opcode {
 	nvme_admin_download_fw		= 0x11,
 	nvme_admin_ns_attach		= 0x15,
 	nvme_admin_keep_alive		= 0x18,
+	nvme_admin_dbbuf		= 0x7C,
 	nvme_admin_format_nvm		= 0x80,
 	nvme_admin_security_send	= 0x81,
 	nvme_admin_security_recv	= 0x82,
@@ -874,6 +876,16 @@ struct nvmf_property_get_command {
 	__u8		resv4[16];
 };
 
+struct nvme_dbbuf {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__u32			rsvd1[5];
+	__le64			prp1;
+	__le64			prp2;
+	__u32			rsvd12[6];
+};
+
 struct nvme_command {
 	union {
 		struct nvme_common_command common;
@@ -893,6 +905,7 @@ struct nvme_command {
 		struct nvmf_connect_command connect;
 		struct nvmf_property_set_command prop_set;
 		struct nvmf_property_get_command prop_get;
+		struct nvme_dbbuf dbbuf;
 	};
 };
 
-- 
2.7.4
