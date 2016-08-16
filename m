From: helen.koike@collabora.co.uk (Helen Koike)
Date: Mon, 15 Aug 2016 22:41:20 -0300
Subject: [PATCH v3 RFC 2/2] nvme: improve performance for virtual NVMe devices
In-Reply-To: <cover.1471308889.git.helen.koike@collabora.co.uk>
References: <1460657059-21214-1-git-send-email-helen.koike@collabora.co.uk>
 <cover.1471308889.git.helen.koike@collabora.co.uk>
Message-ID: <c738f3d3c14907a9074a40b1658461e008fbed9e.1471308889.git.helen.koike@collabora.co.uk>

From: Rob Nelson <rlnelson@google.com>

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
[mlin: port for upstream]
Signed-off-by: Ming Lin <mlin at kernel.org>
[koike: updated for upstream]
Signed-off-by: Helen Koike <helen.koike at collabora.co.uk>
---

Changes since v2:
- Add vdb.c and vdb.h, the idea is to let the code in pci.c clean and to
make it easier to integrate with the official nvme extention when nvme
consortium publishes it
- Remove rmb (I couldn't see why they were necessary here, please let me
know if I am wrong)
- Reposition wmb
- Transform specific code in helper functions
- Coding style (checkpatch, remove unecessary goto, change if statement
logic to decrease identation)
- Rename feature to CONFIG_NVME_VDB
- Remove some PCI_VENDOR_ID_GOOGLE checks

 drivers/nvme/host/Kconfig  |  11 ++++
 drivers/nvme/host/Makefile |   1 +
 drivers/nvme/host/pci.c    |  29 ++++++++++-
 drivers/nvme/host/vdb.c    | 125 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/vdb.h    | 118 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/nvme.h       |  17 ++++++
 6 files changed, 299 insertions(+), 2 deletions(-)
 create mode 100644 drivers/nvme/host/vdb.c
 create mode 100644 drivers/nvme/host/vdb.h

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index db39d53..d3f4da9 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -43,3 +43,14 @@ config NVME_RDMA
 	  from https://github.com/linux-nvme/nvme-cli.
 
 	  If unsure, say N.
+
+config NVME_VDB
+	bool "NVMe Virtual Doorbell Extension for Improved Virtualization"
+	depends on NVME_CORE
+	---help---
+	  This provides support for the Virtual Doorbell Extension which
+	  reduces the number of required MMIOs to ring doorbells, improving
+	  performance in virtualized environments where MMIO causes a high
+	  overhead.
+
+	  If unsure, say N.
diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index 47abcec..d4d0e3d 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -8,6 +8,7 @@ nvme-core-$(CONFIG_BLK_DEV_NVME_SCSI)	+= scsi.o
 nvme-core-$(CONFIG_NVM)			+= lightnvm.o
 
 nvme-y					+= pci.o
+nvme-$(CONFIG_NVME_VDB)			+= vdb.o
 
 nvme-fabrics-y				+= fabrics.o
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index cf8b3d7..20bbc33 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -44,6 +44,7 @@
 #include <asm/unaligned.h>
 
 #include "nvme.h"
+#include "vdb.h"
 
 #define NVME_Q_DEPTH		1024
 #define NVME_AQ_DEPTH		256
@@ -99,6 +100,7 @@ struct nvme_dev {
 	dma_addr_t cmb_dma_addr;
 	u64 cmb_size;
 	u32 cmbsz;
+	struct nvme_vdb_dev vdb_d;
 	struct nvme_ctrl ctrl;
 	struct completion ioq_wait;
 };
@@ -131,6 +133,7 @@ struct nvme_queue {
 	u16 qid;
 	u8 cq_phase;
 	u8 cqe_seen;
+	struct nvme_vdb_queue vdb_q;
 };
 
 /*
@@ -171,6 +174,7 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_id_ns) != 4096);
 	BUILD_BUG_ON(sizeof(struct nvme_lba_range_type) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_smart_log) != 512);
+	BUILD_BUG_ON(sizeof(struct nvme_doorbell_memory) != 64);
 }
 
 /*
@@ -285,7 +289,7 @@ static void __nvme_submit_cmd(struct nvme_queue *nvmeq,
 
 	if (++tail == nvmeq->q_depth)
 		tail = 0;
-	writel(tail, nvmeq->q_db);
+	nvme_write_doorbell_sq(&nvmeq->vdb_q, tail, nvmeq->q_db);
 	nvmeq->sq_tail = tail;
 }
 
@@ -713,7 +717,8 @@ static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
 		return;
 
 	if (likely(nvmeq->cq_vector >= 0))
-		writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
+		nvme_write_doorbell_cq(&nvmeq->vdb_q, head,
+				       nvmeq->q_db + nvmeq->dev->db_stride);
 	nvmeq->cq_head = head;
 	nvmeq->cq_phase = phase;
 
@@ -1068,6 +1073,8 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 	dev->queues[qid] = nvmeq;
 	dev->queue_count++;
 
+	nvme_init_doorbell_mem(&dev->vdb_d, &nvmeq->vdb_q, qid, dev->db_stride);
+
 	return nvmeq;
 
  free_cqdma:
@@ -1098,6 +1105,7 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
+	nvme_init_doorbell_mem(&dev->vdb_d, &nvmeq->vdb_q, qid, dev->db_stride);
 	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq->q_depth));
 	dev->online_queues++;
 	spin_unlock_irq(&nvmeq->q_lock);
@@ -1588,6 +1596,9 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		if (blk_mq_alloc_tag_set(&dev->tagset))
 			return 0;
 		dev->ctrl.tagset = &dev->tagset;
+
+		nvme_set_doorbell_memory(dev->dev, &dev->vdb_d,
+					 &dev->ctrl, dev->db_stride);
 	} else {
 		blk_mq_update_nr_hw_queues(&dev->tagset, dev->online_queues - 1);
 
@@ -1655,6 +1666,18 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 
 	pci_enable_pcie_error_reporting(pdev);
 	pci_save_state(pdev);
+
+	/*
+	 * Google cloud support in memory doorbells extension, reducing the
+	 * number of MMIOs, optimizing performance for virtualized environments
+	 */
+	if (pdev->vendor == PCI_VENDOR_ID_GOOGLE) {
+		result = nvme_dma_alloc_doorbell_mem(dev->dev, &dev->vdb_d,
+						     dev->db_stride);
+		if (result)
+			goto disable;
+	}
+
 	return 0;
 
  disable:
@@ -1673,6 +1696,8 @@ static void nvme_pci_disable(struct nvme_dev *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
+	nvme_dma_free_doorbell_mem(dev->dev, &dev->vdb_d, dev->db_stride);
+
 	if (pdev->msi_enabled)
 		pci_disable_msi(pdev);
 	else if (pdev->msix_enabled)
diff --git a/drivers/nvme/host/vdb.c b/drivers/nvme/host/vdb.c
new file mode 100644
index 0000000..e0c3fef
--- /dev/null
+++ b/drivers/nvme/host/vdb.c
@@ -0,0 +1,125 @@
+/*
+ * NVM Express device driver
+ * Copyright (C) 2015-2016, Google, Inc.
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
+#include "vdb.h"
+
+static inline unsigned int nvme_doorbell_memory_size(u32 stride)
+{
+	return ((num_possible_cpus() + 1) * 8 * stride);
+}
+
+int nvme_dma_alloc_doorbell_mem(struct device *dev,
+				struct nvme_vdb_dev *vdb_d,
+				u32 stride)
+{
+	unsigned int mem_size = nvme_doorbell_memory_size(stride);
+
+	vdb_d->db_mem = dma_alloc_coherent(dev, mem_size, &vdb_d->doorbell,
+					   GFP_KERNEL);
+	if (!vdb_d->db_mem)
+		return -ENOMEM;
+	vdb_d->ei_mem = dma_alloc_coherent(dev, mem_size, &vdb_d->eventidx,
+					   GFP_KERNEL);
+	if (!vdb_d->ei_mem) {
+		dma_free_coherent(dev, mem_size,
+				  vdb_d->db_mem, vdb_d->doorbell);
+		vdb_d->db_mem = NULL;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void nvme_dma_free_doorbell_mem(struct device *dev,
+				struct nvme_vdb_dev *vdb_d,
+				u32 stride)
+{
+	unsigned int mem_size = nvme_doorbell_memory_size(stride);
+
+	if (vdb_d->db_mem) {
+		dma_free_coherent(dev, mem_size,
+				  vdb_d->db_mem, vdb_d->doorbell);
+		vdb_d->db_mem = NULL;
+	}
+	if (vdb_d->ei_mem) {
+		dma_free_coherent(dev, mem_size,
+				  vdb_d->ei_mem, vdb_d->eventidx);
+		vdb_d->ei_mem = NULL;
+	}
+}
+
+void nvme_init_doorbell_mem(struct nvme_vdb_dev *vdb_d,
+			    struct nvme_vdb_queue *vdb_q,
+			    int qid, u32 stride)
+{
+	if (!vdb_d->db_mem || !qid)
+		return;
+
+	vdb_q->sq_doorbell_addr = &vdb_d->db_mem[SQ_IDX(qid, stride)];
+	vdb_q->cq_doorbell_addr = &vdb_d->db_mem[CQ_IDX(qid, stride)];
+	vdb_q->sq_eventidx_addr = &vdb_d->ei_mem[SQ_IDX(qid, stride)];
+	vdb_q->cq_eventidx_addr = &vdb_d->ei_mem[CQ_IDX(qid, stride)];
+}
+
+void nvme_set_doorbell_memory(struct device *dev,
+			      struct nvme_vdb_dev *vdb_d,
+			      struct nvme_ctrl *ctrl,
+			      u32 stride)
+{
+	struct nvme_command c;
+
+	if (!vdb_d->db_mem)
+		return;
+
+	memset(&c, 0, sizeof(c));
+	c.doorbell_memory.opcode = nvme_admin_doorbell_memory;
+	c.doorbell_memory.prp1 = cpu_to_le64(vdb_d->doorbell);
+	c.doorbell_memory.prp2 = cpu_to_le64(vdb_d->eventidx);
+
+	if (nvme_submit_sync_cmd(ctrl->admin_q, &c, NULL, 0))
+		/* Free memory and continue on */
+		nvme_dma_free_doorbell_mem(dev, vdb_d, stride);
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
diff --git a/drivers/nvme/host/vdb.h b/drivers/nvme/host/vdb.h
new file mode 100644
index 0000000..37edd75
--- /dev/null
+++ b/drivers/nvme/host/vdb.h
@@ -0,0 +1,118 @@
+/*
+ * NVM Express device driver
+ * Copyright (C) 2015-2016, Google, Inc.
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
+#ifndef _NVME_VDB_H
+#define _NVME_VDB_H
+
+#ifdef CONFIG_NVME_VDB
+
+#define SQ_IDX(qid, stride) ((qid) * 2 * (stride))
+#define CQ_IDX(qid, stride) (((qid) * 2 + 1) * (stride))
+
+struct nvme_vdb_dev {
+	u32 *db_mem;
+	dma_addr_t doorbell;
+	u32 *ei_mem;
+	dma_addr_t eventidx;
+};
+
+struct nvme_vdb_queue {
+	u32 *sq_doorbell_addr;
+	u32 *sq_eventidx_addr;
+	u32 *cq_doorbell_addr;
+	u32 *cq_eventidx_addr;
+};
+
+int nvme_dma_alloc_doorbell_mem(struct device *dev,
+				struct nvme_vdb_dev *vdb_d,
+				u32 stride);
+
+void nvme_dma_free_doorbell_mem(struct device *dev,
+				struct nvme_vdb_dev *vdb_d,
+				u32 stride);
+
+void nvme_init_doorbell_mem(struct nvme_vdb_dev *vdb_d,
+			    struct nvme_vdb_queue *vdb_q,
+			    int qid, u32 stride);
+
+void nvme_set_doorbell_memory(struct device *dev,
+			      struct nvme_vdb_dev *vdb_d,
+			      struct nvme_ctrl *ctrl,
+			      u32 stride);
+
+void nvme_write_doorbell(u16 value,
+			 u32 __iomem *q_db,
+			 u32 *db_addr,
+			 volatile u32 *event_idx);
+
+static inline void nvme_write_doorbell_cq(struct nvme_vdb_queue *vdb_q,
+					  u16 value, u32 __iomem *q_db)
+{
+	nvme_write_doorbell(value, q_db,
+			    vdb_q->cq_doorbell_addr,
+			    vdb_q->cq_eventidx_addr);
+}
+
+static inline void nvme_write_doorbell_sq(struct nvme_vdb_queue *vdb_q,
+					  u16 value, u32 __iomem *q_db)
+{
+	nvme_write_doorbell(value, q_db,
+			    vdb_q->sq_doorbell_addr,
+			    vdb_q->sq_eventidx_addr);
+}
+
+#else /* CONFIG_NVME_VDB */
+
+struct nvme_vdb_dev {};
+
+struct nvme_vdb_queue {};
+
+static inline int nvme_dma_alloc_doorbell_mem(struct device *dev,
+					      struct nvme_vdb_dev *vdb_d,
+					      u32 stride)
+{
+	return 0;
+}
+
+static inline void nvme_dma_free_doorbell_mem(struct device *dev,
+					      struct nvme_vdb_dev *vdb_d,
+					      u32 stride)
+{}
+
+static inline void nvme_set_doorbell_memory(struct device *dev,
+					    struct nvme_vdb_dev *vdb_d,
+					    struct nvme_ctrl *ctrl,
+					    u32 stride)
+{}
+
+static inline void nvme_init_doorbell_mem(struct nvme_vdb_dev *vdb_d,
+					  struct nvme_vdb_queue *vdb_q,
+					  int qid, u32 stride)
+{}
+
+static inline void nvme_write_doorbell_cq(struct nvme_vdb_queue *vdb_q,
+					  u16 value, u32 __iomem *q_db)
+{
+	writel(value, q_db);
+}
+
+static inline void nvme_write_doorbell_sq(struct nvme_vdb_queue *vdb_q,
+					  u16 value, u32 __iomem *q_db)
+{
+	writel(value, q_db);
+}
+
+#endif /* CONFIG_NVME_VDB */
+
+#endif /* _NVME_VDB_H */
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index d8b37ba..46d0412 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -562,6 +562,9 @@ enum nvme_admin_opcode {
 	nvme_admin_format_nvm		= 0x80,
 	nvme_admin_security_send	= 0x81,
 	nvme_admin_security_recv	= 0x82,
+#ifdef CONFIG_NVME_VDB
+	nvme_admin_doorbell_memory	= 0xC0,
+#endif
 };
 
 enum {
@@ -827,6 +830,16 @@ struct nvmf_property_get_command {
 	__u8		resv4[16];
 };
 
+struct nvme_doorbell_memory {
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
@@ -845,6 +858,7 @@ struct nvme_command {
 		struct nvmf_connect_command connect;
 		struct nvmf_property_set_command prop_set;
 		struct nvmf_property_get_command prop_get;
+		struct nvme_doorbell_memory doorbell_memory;
 	};
 };
 
@@ -934,6 +948,9 @@ enum {
 	/*
 	 * Media and Data Integrity Errors:
 	 */
+#ifdef CONFIG_NVME_VDB
+	NVME_SC_DOORBELL_MEMORY_INVALID	= 0x1C0,
+#endif
 	NVME_SC_WRITE_FAULT		= 0x280,
 	NVME_SC_READ_ERROR		= 0x281,
 	NVME_SC_GUARD_CHECK		= 0x282,
-- 
1.9.1
