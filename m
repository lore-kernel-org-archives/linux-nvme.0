From: helen.koike@collabora.com (Helen Koike)
Date: Fri, 17 Mar 2017 18:44:59 -0300
Subject: [PATCH v4 RFC] nvme: improve performance for virtual NVMe devices
In-Reply-To: <c738f3d3c14907a9074a40b1658461e008fbed9e.1471308889.git.helen.koike@collabora.co.uk>
References: <c738f3d3c14907a9074a40b1658461e008fbed9e.1471308889.git.helen.koike@collabora.co.uk>
Message-ID: <1489787099-2049-1-git-send-email-helen.koike@collabora.com>

From: Helen Koike <helen.koike@collabora.co.uk>

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
Signed-off-by: Helen Koike <helen.koike at collabora.co.uk>

---

This patch is based on git://git.infradead.org/nvme.git master
Tested through Google Cloud Engine
TPAR is ratified by the NVME working group

Changes since last version
	- Rename to dbbuf (be closer to the latest TPAR)
	- Modify the opcodes according to the latest TPAR
	- Check if the device support this feature through the OACS bit
	- little cleanups
---
 drivers/nvme/host/Kconfig  |   9 ++++
 drivers/nvme/host/Makefile |   1 +
 drivers/nvme/host/dbbuf.c  | 125 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/dbbuf.h  | 118 ++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/pci.c    |  22 +++++++-
 include/linux/nvme.h       |  13 +++++
 6 files changed, 286 insertions(+), 2 deletions(-)
 create mode 100644 drivers/nvme/host/dbbuf.c
 create mode 100644 drivers/nvme/host/dbbuf.h

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 90745a6..7ada6f3 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -59,4 +59,13 @@ config NVME_FC
 	  To configure a NVMe over Fabrics controller use the nvme-cli tool
 	  from https://github.com/linux-nvme/nvme-cli.
 
+config NVME_DBBUF
+	bool "NVM Express Doorbell Buffer Config Command"
+	depends on NVME_CORE
+	---help---
+	  This provides support for the Doorbell Buffer Config Command, which
+	  reduces the number of required MMIOs to ring doorbells, improving
+	  performance for virtualised environments where MMIO causes a high
+	  overhead.
+
 	  If unsure, say N.
diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index f1a7d94..ed9efe5 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -9,6 +9,7 @@ nvme-core-$(CONFIG_BLK_DEV_NVME_SCSI)	+= scsi.o
 nvme-core-$(CONFIG_NVM)			+= lightnvm.o
 
 nvme-y					+= pci.o
+nvme-$(CONFIG_NVME_DBBUF)		+= dbbuf.o
 
 nvme-fabrics-y				+= fabrics.o
 
diff --git a/drivers/nvme/host/dbbuf.c b/drivers/nvme/host/dbbuf.c
new file mode 100644
index 0000000..3900bb5
--- /dev/null
+++ b/drivers/nvme/host/dbbuf.c
@@ -0,0 +1,125 @@
+/*
+ * NVM Express device driver
+ * Copyright (C) 2015-2017, Google, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include "nvme.h"
+#include "dbbuf.h"
+
+static inline unsigned int nvme_dbbuf_size(u32 stride)
+{
+	return ((num_possible_cpus() + 1) * 8 * stride);
+}
+
+int nvme_dma_alloc_dbbuf(struct device *dev,
+			 struct nvme_dbbuf_dev *dbbuf_d,
+			 u32 stride)
+{
+	unsigned int mem_size = nvme_dbbuf_size(stride);
+
+	dbbuf_d->db_mem = dma_alloc_coherent(dev, mem_size, &dbbuf_d->doorbell,
+					     GFP_KERNEL);
+	if (!dbbuf_d->db_mem)
+		return -ENOMEM;
+	dbbuf_d->ei_mem = dma_alloc_coherent(dev, mem_size, &dbbuf_d->eventidx,
+					     GFP_KERNEL);
+	if (!dbbuf_d->ei_mem) {
+		dma_free_coherent(dev, mem_size,
+				  dbbuf_d->db_mem, dbbuf_d->doorbell);
+		dbbuf_d->db_mem = NULL;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void nvme_dma_free_dbbuf(struct device *dev,
+			 struct nvme_dbbuf_dev *dbbuf_d,
+			 u32 stride)
+{
+	unsigned int mem_size = nvme_dbbuf_size(stride);
+
+	if (dbbuf_d->db_mem) {
+		dma_free_coherent(dev, mem_size,
+				  dbbuf_d->db_mem, dbbuf_d->doorbell);
+		dbbuf_d->db_mem = NULL;
+	}
+	if (dbbuf_d->ei_mem) {
+		dma_free_coherent(dev, mem_size,
+				  dbbuf_d->ei_mem, dbbuf_d->eventidx);
+		dbbuf_d->ei_mem = NULL;
+	}
+}
+
+void nvme_init_dbbuf(struct nvme_dbbuf_dev *dbbuf_d,
+		     struct nvme_dbbuf_queue *dbbuf_q,
+		     int qid, u32 stride)
+{
+	if (!dbbuf_d->db_mem || !qid)
+		return;
+
+	dbbuf_q->sq_doorbell_addr = &dbbuf_d->db_mem[SQ_IDX(qid, stride)];
+	dbbuf_q->cq_doorbell_addr = &dbbuf_d->db_mem[CQ_IDX(qid, stride)];
+	dbbuf_q->sq_eventidx_addr = &dbbuf_d->ei_mem[SQ_IDX(qid, stride)];
+	dbbuf_q->cq_eventidx_addr = &dbbuf_d->ei_mem[CQ_IDX(qid, stride)];
+}
+
+void nvme_set_dbbuf(struct device *dev,
+		    struct nvme_dbbuf_dev *dbbuf_d,
+		    struct nvme_ctrl *ctrl,
+		    u32 stride)
+{
+	struct nvme_command c;
+
+	if (!dbbuf_d->db_mem)
+		return;
+
+	memset(&c, 0, sizeof(c));
+	c.dbbuf.opcode = nvme_admin_dbbuf;
+	c.dbbuf.prp1 = cpu_to_le64(dbbuf_d->doorbell);
+	c.dbbuf.prp2 = cpu_to_le64(dbbuf_d->eventidx);
+
+	if (nvme_submit_sync_cmd(ctrl->admin_q, &c, NULL, 0))
+		/* Free memory and continue on */
+		nvme_dma_free_dbbuf(dev, dbbuf_d, stride);
+}
+
+static inline int nvme_ext_need_event(u16 event_idx, u16 new_idx, u16 old)
+{
+	/* Borrowed from vring_need_event */
+	return (u16)(new_idx - event_idx - 1) < (u16)(new_idx - old);
+}
+
+void nvme_write_doorbell(u16 value,
+			 u32 __iomem *q_db,
+			 u32 *db_addr,
+			 volatile u32 *event_idx)
+{
+	u16 old_value;
+
+	if (!db_addr) {
+		writel(value, q_db);
+		return;
+	}
+
+	/*
+	 * Ensure that the queue is written before updating
+	 * the doorbell in memory
+	 */
+	wmb();
+
+	old_value = *db_addr;
+	*db_addr = value;
+
+	if (nvme_ext_need_event(*event_idx, value, old_value))
+		writel(value, q_db);
+}
diff --git a/drivers/nvme/host/dbbuf.h b/drivers/nvme/host/dbbuf.h
new file mode 100644
index 0000000..0c0a83f
--- /dev/null
+++ b/drivers/nvme/host/dbbuf.h
@@ -0,0 +1,118 @@
+/*
+ * NVM Express device driver
+ * Copyright (C) 2015-2017, Google, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#ifndef _NVME_DBBUF_H
+#define _NVME_DBBUF_H
+
+#define SQ_IDX(qid, stride) ((qid) * 2 * (stride))
+#define CQ_IDX(qid, stride) (((qid) * 2 + 1) * (stride))
+
+#ifdef CONFIG_NVME_DBBUF
+
+struct nvme_dbbuf_dev {
+	u32 *db_mem;
+	dma_addr_t doorbell;
+	u32 *ei_mem;
+	dma_addr_t eventidx;
+};
+
+struct nvme_dbbuf_queue {
+	u32 *sq_doorbell_addr;
+	u32 *sq_eventidx_addr;
+	u32 *cq_doorbell_addr;
+	u32 *cq_eventidx_addr;
+};
+
+int nvme_dma_alloc_dbbuf(struct device *dev,
+			 struct nvme_dbbuf_dev *dbbuf_d,
+			 u32 stride);
+
+void nvme_dma_free_dbbuf(struct device *dev,
+			 struct nvme_dbbuf_dev *dbbuf_d,
+			 u32 stride);
+
+void nvme_init_dbbuf(struct nvme_dbbuf_dev *dbbuf_d,
+		     struct nvme_dbbuf_queue *dbbuf_q,
+		     int qid, u32 stride);
+
+void nvme_set_dbbuf(struct device *dev,
+		    struct nvme_dbbuf_dev *dbbuf_d,
+		    struct nvme_ctrl *ctrl,
+		    u32 stride);
+
+void nvme_write_doorbell(u16 value,
+			 u32 __iomem *q_db,
+			 u32 *db_addr,
+			 volatile u32 *event_idx);
+
+static inline void nvme_write_doorbell_cq(struct nvme_dbbuf_queue *dbbuf_q,
+					  u16 value, u32 __iomem *q_db)
+{
+	nvme_write_doorbell(value, q_db,
+			    dbbuf_q->cq_doorbell_addr,
+			    dbbuf_q->cq_eventidx_addr);
+}
+
+static inline void nvme_write_doorbell_sq(struct nvme_dbbuf_queue *dbbuf_q,
+					  u16 value, u32 __iomem *q_db)
+{
+	nvme_write_doorbell(value, q_db,
+			    dbbuf_q->sq_doorbell_addr,
+			    dbbuf_q->sq_eventidx_addr);
+}
+
+#else /* CONFIG_NVME_DBBUF */
+
+struct nvme_dbbuf_dev {};
+
+struct nvme_dbbuf_queue {};
+
+static inline int nvme_dma_alloc_dbbuf(struct device *dev,
+				       struct nvme_dbbuf_dev *dbbuf_d,
+				       u32 stride)
+{
+	return 0;
+}
+
+static inline void nvme_dma_free_dbbuf(struct device *dev,
+				       struct nvme_dbbuf_dev *dbbuf_d,
+				       u32 stride)
+{}
+
+static inline void nvme_set_dbbuf(struct device *dev,
+				  struct nvme_dbbuf_dev *dbbuf_d,
+				  struct nvme_ctrl *ctrl,
+				  u32 stride)
+{}
+
+static inline void nvme_init_dbbuf(struct nvme_dbbuf_dev *dbbuf_d,
+				   struct nvme_dbbuf_queue *dbbuf_q,
+				   int qid, u32 stride)
+{}
+
+static inline void nvme_write_doorbell_cq(struct nvme_dbbuf_queue *dbbuf_q,
+					  u16 value, u32 __iomem *q_db)
+{
+	writel(value, q_db);
+}
+
+static inline void nvme_write_doorbell_sq(struct nvme_dbbuf_queue *dbbuf_q,
+					  u16 value, u32 __iomem *q_db)
+{
+	writel(value, q_db);
+}
+
+#endif /* CONFIG_NVME_DBBUF */
+
+#endif /* _NVME_DBBUF_H */
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5b7bd9c..3723697 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -46,6 +46,7 @@
 #include <linux/sed-opal.h>
 
 #include "nvme.h"
+#include "dbbuf.h"
 
 #define NVME_Q_DEPTH		1024
 #define NVME_AQ_DEPTH		256
@@ -103,6 +104,7 @@ struct nvme_dev {
 	u32 cmbloc;
 	struct nvme_ctrl ctrl;
 	struct completion ioq_wait;
+	struct nvme_dbbuf_dev dbbuf_d;
 };
 
 static inline struct nvme_dev *to_nvme_dev(struct nvme_ctrl *ctrl)
@@ -133,6 +135,7 @@ struct nvme_queue {
 	u16 qid;
 	u8 cq_phase;
 	u8 cqe_seen;
+	struct nvme_dbbuf_queue dbbuf_q;
 };
 
 /*
@@ -174,6 +177,7 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_id_ns) != 4096);
 	BUILD_BUG_ON(sizeof(struct nvme_lba_range_type) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_smart_log) != 512);
+	BUILD_BUG_ON(sizeof(struct nvme_dbbuf) != 64);
 }
 
 /*
@@ -300,7 +304,7 @@ static void __nvme_submit_cmd(struct nvme_queue *nvmeq,
 
 	if (++tail == nvmeq->q_depth)
 		tail = 0;
-	writel(tail, nvmeq->q_db);
+	nvme_write_doorbell_sq(&nvmeq->dbbuf_q, tail, nvmeq->q_db);
 	nvmeq->sq_tail = tail;
 }
 
@@ -716,7 +720,8 @@ static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
 		return;
 
 	if (likely(nvmeq->cq_vector >= 0))
-		writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
+		nvme_write_doorbell_cq(&nvmeq->dbbuf_q, head,
+				       nvmeq->q_db + nvmeq->dev->db_stride);
 	nvmeq->cq_head = head;
 	nvmeq->cq_phase = phase;
 
@@ -1066,6 +1071,7 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 	nvmeq->q_depth = depth;
 	nvmeq->qid = qid;
 	nvmeq->cq_vector = -1;
+	nvme_init_dbbuf(&dev->dbbuf_d, &nvmeq->dbbuf_q, qid, dev->db_stride);
 	dev->queues[qid] = nvmeq;
 	dev->queue_count++;
 
@@ -1099,6 +1105,7 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	nvmeq->cq_phase = 1;
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
 	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq->q_depth));
+	nvme_init_dbbuf(&dev->dbbuf_d, &nvmeq->dbbuf_q, qid, dev->db_stride);
 	dev->online_queues++;
 	spin_unlock_irq(&nvmeq->q_lock);
 }
@@ -1568,6 +1575,9 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		if (blk_mq_alloc_tag_set(&dev->tagset))
 			return 0;
 		dev->ctrl.tagset = &dev->tagset;
+
+		nvme_set_dbbuf(dev->dev, &dev->dbbuf_d,
+			       &dev->ctrl, dev->db_stride);
 	} else {
 		blk_mq_update_nr_hw_queues(&dev->tagset, dev->online_queues - 1);
 
@@ -1700,6 +1710,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 		nvme_disable_admin_queue(dev, shutdown);
 	}
 	nvme_pci_disable(dev);
+	nvme_dma_free_dbbuf(dev->dev, &dev->dbbuf_d, dev->db_stride);
 
 	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_request, &dev->ctrl);
 	blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_cancel_request, &dev->ctrl);
@@ -1800,6 +1811,13 @@ static void nvme_reset_work(struct work_struct *work)
 		dev->ctrl.opal_dev = NULL;
 	}
 
+	if (dev->ctrl.oacs & NVME_CTRL_OACS_DBBUF_SUPP) {
+		result = nvme_dma_alloc_dbbuf(dev->dev, &dev->dbbuf_d,
+					      dev->db_stride);
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
