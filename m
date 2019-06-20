From: drake@endlessm.com (Daniel Drake)
Date: Thu, 20 Jun 2019 13:13:32 +0800
Subject: [PATCH v2 4/5] nvme: move common definitions to pci.h
In-Reply-To: <20190620051333.2235-1-drake@endlessm.com>
References: <20190620051333.2235-1-drake@endlessm.com>
Message-ID: <20190620051333.2235-5-drake@endlessm.com>

From: Dan Williams <dan.j.williams@intel.com>

A platform-driver for nvme resources needs access to struct nvme_dev and
other definitions that are currently local to pci.c.

Signed-off-by: Dan Williams <dan.j.williams at intel.com>
Signed-off-by: Daniel Drake <drake at endlessm.com>
---
 drivers/nvme/host/pci.c | 125 +-----------------------------------
 drivers/nvme/host/pci.h | 136 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+), 124 deletions(-)
 create mode 100644 drivers/nvme/host/pci.h

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 23bda524f16b..bed6c91b6b7c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -26,6 +26,7 @@
 
 #include "trace.h"
 #include "nvme.h"
+#include "pci.h"
 
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
 #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
@@ -83,97 +84,9 @@ static int poll_queues = 0;
 module_param_cb(poll_queues, &queue_count_ops, &poll_queues, 0644);
 MODULE_PARM_DESC(poll_queues, "Number of queues to use for polled IO.");
 
-struct nvme_dev;
-struct nvme_queue;
-
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
 static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode);
 
-struct nvme_dev_ops {
-	/* Enable device (required) */
-	int (*enable)(struct nvme_dev *dev);
-
-	/* Disable device (required) */
-	void (*disable)(struct nvme_dev *dev);
-
-	/* Allocate IRQ vectors for given number of io queues (required) */
-	int (*setup_irqs)(struct nvme_dev *dev, int nr_io_queues);
-
-	/* Get the IRQ vector for a specific queue */
-	int (*q_irq)(struct nvme_queue *q);
-
-	/* Allocate device-specific SQ command buffer (optional) */
-	int (*cmb_alloc_sq_cmds)(struct nvme_queue *nvmeq, size_t size,
-				 struct nvme_command **sq_cmds,
-				 dma_addr_t *sq_dma_addr);
-
-	/* Free device-specific SQ command buffer (optional) */
-	void (*cmb_free_sq_cmds)(struct nvme_queue *nvmeq,
-				 struct nvme_command *sq_cmds, size_t size);
-
-	/* Device-specific mapping of blk queues to CPUs (optional) */
-	int (*map_queues)(struct nvme_dev *dev, struct blk_mq_queue_map *map,
-			  int offset);
-
-	/* Check if device is enabled on the bus (required) */
-	int (*is_enabled)(struct nvme_dev *dev);
-
-	/* Check if channel is in running state (required) */
-	int (*is_offline)(struct nvme_dev *dev);
-
-	/* Check if device is present and responding (optional) */
-	bool (*is_present)(struct nvme_dev *dev);
-
-	/* Check & log device state before it gets reset (optional) */
-	void (*warn_reset)(struct nvme_dev *dev);
-};
-
-/*
- * Represents an NVM Express device.  Each nvme_dev is a PCI function.
- */
-struct nvme_dev {
-	const struct resource *res;
-	const struct nvme_dev_ops *ops;
-	struct nvme_queue *queues;
-	struct blk_mq_tag_set tagset;
-	struct blk_mq_tag_set admin_tagset;
-	u32 __iomem *dbs;
-	struct device *dev;
-	struct dma_pool *prp_page_pool;
-	struct dma_pool *prp_small_pool;
-	unsigned online_queues;
-	unsigned max_qid;
-	unsigned io_queues[HCTX_MAX_TYPES];
-	unsigned int num_vecs;
-	int q_depth;
-	u32 db_stride;
-	void __iomem *bar;
-	unsigned long bar_mapped_size;
-	struct work_struct remove_work;
-	struct mutex shutdown_lock;
-	bool subsystem;
-	u64 cmb_size;
-	bool cmb_use_sqes;
-	u32 cmbsz;
-	u32 cmbloc;
-	struct nvme_ctrl ctrl;
-
-	mempool_t *iod_mempool;
-
-	/* shadow doorbell buffer support: */
-	u32 *dbbuf_dbs;
-	dma_addr_t dbbuf_dbs_dma_addr;
-	u32 *dbbuf_eis;
-	dma_addr_t dbbuf_eis_dma_addr;
-
-	/* host memory buffer support: */
-	u64 host_mem_size;
-	u32 nr_host_mem_descs;
-	dma_addr_t host_mem_descs_dma;
-	struct nvme_host_mem_buf_desc *host_mem_descs;
-	void **host_mem_desc_bufs;
-};
-
 static int io_queue_depth_set(const char *val, const struct kernel_param *kp)
 {
 	int n = 0, ret;
@@ -213,42 +126,6 @@ static inline struct nvme_dev *to_nvme_dev(struct nvme_ctrl *ctrl)
 	return container_of(ctrl, struct nvme_dev, ctrl);
 }
 
-/*
- * An NVM Express queue.  Each device has at least two (one for admin
- * commands and one for I/O commands).
- */
-struct nvme_queue {
-	struct nvme_dev *dev;
-	char irqname[24];	/* nvme4294967295-65535\0 */
-	spinlock_t sq_lock;
-	struct nvme_command *sq_cmds;
-	 /* only used for poll queues: */
-	spinlock_t cq_poll_lock ____cacheline_aligned_in_smp;
-	volatile struct nvme_completion *cqes;
-	struct blk_mq_tags **tags;
-	dma_addr_t sq_dma_addr;
-	dma_addr_t cq_dma_addr;
-	u32 __iomem *q_db;
-	u16 q_depth;
-	u16 cq_vector;
-	u16 sq_tail;
-	u16 last_sq_tail;
-	u16 cq_head;
-	u16 last_cq_head;
-	u16 qid;
-	u8 cq_phase;
-	unsigned long flags;
-#define NVMEQ_ENABLED		0
-#define NVMEQ_SQ_CMB		1
-#define NVMEQ_DELETE_ERROR	2
-#define NVMEQ_POLLED		3
-	u32 *dbbuf_sq_db;
-	u32 *dbbuf_cq_db;
-	u32 *dbbuf_sq_ei;
-	u32 *dbbuf_cq_ei;
-	struct completion delete_done;
-};
-
 /*
  * The nvme_iod describes the data in an I/O.
  *
diff --git a/drivers/nvme/host/pci.h b/drivers/nvme/host/pci.h
new file mode 100644
index 000000000000..7e4d73a22876
--- /dev/null
+++ b/drivers/nvme/host/pci.h
@@ -0,0 +1,136 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * NVM Express device driver
+ * Copyright (c) 2011-2014, Intel Corporation.
+ */
+
+#ifndef __NVME_PCI_H__
+#define __NVME_PCI_H__
+#include <linux/blk-mq.h>
+#include <linux/device.h>
+
+struct nvme_queue;
+struct nvme_dev;
+
+struct nvme_dev_ops {
+	/* Enable device (required) */
+	int (*enable)(struct nvme_dev *dev);
+
+	/* Disable device (required) */
+	void (*disable)(struct nvme_dev *dev);
+
+	/* Allocate IRQ vectors for given number of io queues (required) */
+	int (*setup_irqs)(struct nvme_dev *dev, int nr_io_queues);
+
+	/* Get the IRQ vector for a specific queue */
+	int (*q_irq)(struct nvme_queue *q);
+
+	/* Allocate device-specific SQ command buffer (optional) */
+	int (*cmb_alloc_sq_cmds)(struct nvme_queue *nvmeq, size_t size,
+				 struct nvme_command **sq_cmds,
+				 dma_addr_t *sq_dma_addr);
+
+	/* Free device-specific SQ command buffer (optional) */
+	void (*cmb_free_sq_cmds)(struct nvme_queue *nvmeq,
+				 struct nvme_command *sq_cmds, size_t size);
+
+	/* Device-specific mapping of blk queues to CPUs (optional) */
+	int (*map_queues)(struct nvme_dev *dev, struct blk_mq_queue_map *map,
+			  int offset);
+
+	/* Check if device is enabled on the bus (required) */
+	int (*is_enabled)(struct nvme_dev *dev);
+
+	/* Check if channel is in running state (required) */
+	int (*is_offline)(struct nvme_dev *dev);
+
+	/* Check if device is present and responding (optional) */
+	bool (*is_present)(struct nvme_dev *dev);
+
+	/* Check & log device state before it gets reset (optional) */
+	void (*warn_reset)(struct nvme_dev *dev);
+};
+
+/*
+ * Represents an NVM Express device.  Each nvme_dev is a PCI function.
+ */
+struct nvme_dev {
+	const struct resource *res;
+	const struct nvme_dev_ops *ops;
+	struct nvme_queue *queues;
+	struct blk_mq_tag_set tagset;
+	struct blk_mq_tag_set admin_tagset;
+	u32 __iomem *dbs;
+	struct device *dev;
+	struct dma_pool *prp_page_pool;
+	struct dma_pool *prp_small_pool;
+	unsigned online_queues;
+	unsigned max_qid;
+	unsigned io_queues[HCTX_MAX_TYPES];
+	unsigned int num_vecs;
+	int q_depth;
+	u32 db_stride;
+	void __iomem *bar;
+	unsigned long bar_mapped_size;
+	struct work_struct remove_work;
+	struct mutex shutdown_lock;
+	bool subsystem;
+	u64 cmb_size;
+	bool cmb_use_sqes;
+	u32 cmbsz;
+	u32 cmbloc;
+	struct nvme_ctrl ctrl;
+
+	mempool_t *iod_mempool;
+
+	/* shadow doorbell buffer support: */
+	u32 *dbbuf_dbs;
+	dma_addr_t dbbuf_dbs_dma_addr;
+	u32 *dbbuf_eis;
+	dma_addr_t dbbuf_eis_dma_addr;
+
+	/* host memory buffer support: */
+	u64 host_mem_size;
+	u32 nr_host_mem_descs;
+	dma_addr_t host_mem_descs_dma;
+	struct nvme_host_mem_buf_desc *host_mem_descs;
+	void **host_mem_desc_bufs;
+};
+
+/*
+ * An NVM Express queue.  Each device has at least two (one for admin
+ * commands and one for I/O commands).
+ */
+struct nvme_queue {
+	struct nvme_dev *dev;
+	char irqname[24];	/* nvme4294967295-65535\0 */
+	spinlock_t sq_lock;
+	struct nvme_command *sq_cmds;
+	 /* only used for poll queues: */
+	spinlock_t cq_poll_lock ____cacheline_aligned_in_smp;
+	volatile struct nvme_completion *cqes;
+	struct blk_mq_tags **tags;
+	dma_addr_t sq_dma_addr;
+	dma_addr_t cq_dma_addr;
+	u32 __iomem *q_db;
+	u16 q_depth;
+	u16 cq_vector;
+	u16 sq_tail;
+	u16 last_sq_tail;
+	u16 cq_head;
+	u16 last_cq_head;
+	u16 qid;
+	u8 cq_phase;
+	unsigned long flags;
+#define NVMEQ_ENABLED		0
+#define NVMEQ_SQ_CMB		1
+#define NVMEQ_DELETE_ERROR	2
+#define NVMEQ_POLLED		3
+	u32 *dbbuf_sq_db;
+	u32 *dbbuf_cq_db;
+	u32 *dbbuf_sq_ei;
+	u32 *dbbuf_cq_ei;
+	struct completion delete_done;
+};
+
+#endif /* __NVME_PCI_H__ */
-- 
2.20.1
