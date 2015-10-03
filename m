From: hch@lst.de (Christoph Hellwig)
Date: Sat,  3 Oct 2015 15:51:10 +0200
Subject: [PATCH 1/3] nvme: add a local nvme.h header
In-Reply-To: <1443880272-25801-1-git-send-email-hch@lst.de>
References: <1443880272-25801-1-git-send-email-hch@lst.de>
Message-ID: <1443880272-25801-2-git-send-email-hch@lst.de>

Add a new drivers/block/nvme.h which contains all the driver internal
interface.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Acked-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   3 +-
 drivers/block/nvme-scsi.c |   2 +-
 drivers/block/nvme.h      | 133 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/nvme.h      | 114 ---------------------------------------
 4 files changed, 136 insertions(+), 116 deletions(-)
 create mode 100644 drivers/block/nvme.h

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 01a6d1b..a20f66a 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -12,7 +12,6 @@
  * more details.
  */
 
-#include <linux/nvme.h>
 #include <linux/bitops.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
@@ -43,6 +42,8 @@
 #include <scsi/sg.h>
 #include <asm-generic/io-64-nonatomic-lo-hi.h>
 
+#include "nvme.h"
+
 #define NVME_MINORS		(1U << MINORBITS)
 #define NVME_Q_DEPTH		1024
 #define NVME_AQ_DEPTH		256
diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index e5a63f0..c3d8d38 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -17,7 +17,6 @@
  * each command is translated.
  */
 
-#include <linux/nvme.h>
 #include <linux/bio.h>
 #include <linux/bitops.h>
 #include <linux/blkdev.h>
@@ -45,6 +44,7 @@
 #include <scsi/sg.h>
 #include <scsi/scsi.h>
 
+#include "nvme.h"
 
 static int sg_version_num = 30534;	/* 2 digits for each component */
 
diff --git a/drivers/block/nvme.h b/drivers/block/nvme.h
new file mode 100644
index 0000000..c1f41bf
--- /dev/null
+++ b/drivers/block/nvme.h
@@ -0,0 +1,133 @@
+/*
+ * Copyright (c) 2011-2014, Intel Corporation.
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
+#ifndef _NVME_H
+#define _NVME_H
+
+#include <linux/nvme.h>
+#include <linux/pci.h>
+#include <linux/kref.h>
+#include <linux/blk-mq.h>
+
+extern unsigned char nvme_io_timeout;
+#define NVME_IO_TIMEOUT	(nvme_io_timeout * HZ)
+
+/*
+ * Represents an NVM Express device.  Each nvme_dev is a PCI function.
+ */
+struct nvme_dev {
+	struct list_head node;
+	struct nvme_queue **queues;
+	struct request_queue *admin_q;
+	struct blk_mq_tag_set tagset;
+	struct blk_mq_tag_set admin_tagset;
+	u32 __iomem *dbs;
+	struct device *dev;
+	struct dma_pool *prp_page_pool;
+	struct dma_pool *prp_small_pool;
+	int instance;
+	unsigned queue_count;
+	unsigned online_queues;
+	unsigned max_qid;
+	int q_depth;
+	u32 db_stride;
+	u32 ctrl_config;
+	struct msix_entry *entry;
+	struct nvme_bar __iomem *bar;
+	struct list_head namespaces;
+	struct kref kref;
+	struct device *device;
+	struct work_struct reset_work;
+	struct work_struct probe_work;
+	struct work_struct scan_work;
+	char name[12];
+	char serial[20];
+	char model[40];
+	char firmware_rev[8];
+	bool subsystem;
+	u32 max_hw_sectors;
+	u32 stripe_size;
+	u32 page_size;
+	void __iomem *cmb;
+	dma_addr_t cmb_dma_addr;
+	u64 cmb_size;
+	u32 cmbsz;
+	u16 oncs;
+	u16 abort_limit;
+	u8 event_limit;
+	u8 vwc;
+};
+
+/*
+ * An NVM Express namespace is equivalent to a SCSI LUN
+ */
+struct nvme_ns {
+	struct list_head list;
+
+	struct nvme_dev *dev;
+	struct request_queue *queue;
+	struct gendisk *disk;
+	struct kref kref;
+
+	unsigned ns_id;
+	int lba_shift;
+	u16 ms;
+	bool ext;
+	u8 pi_type;
+	u64 mode_select_num_blocks;
+	u32 mode_select_block_len;
+};
+
+/*
+ * The nvme_iod describes the data in an I/O, including the list of PRP
+ * entries.  You can't see it in this data structure because C doesn't let
+ * me express that.  Use nvme_alloc_iod to ensure there's enough space
+ * allocated to store the PRP list.
+ */
+struct nvme_iod {
+	unsigned long private;	/* For the use of the submitter of the I/O */
+	int npages;		/* In the PRP list. 0 means small pool in use */
+	int offset;		/* Of PRP list */
+	int nents;		/* Used in scatterlist */
+	int length;		/* Of data, in bytes */
+	dma_addr_t first_dma;
+	struct scatterlist meta_sg[1]; /* metadata requires single contiguous buffer */
+	struct scatterlist sg[0];
+};
+
+static inline u64 nvme_block_nr(struct nvme_ns *ns, sector_t sector)
+{
+	return (sector >> (ns->lba_shift - 9));
+}
+
+int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
+		void *buf, unsigned bufflen);
+int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
+		void *buffer, void __user *ubuffer, unsigned bufflen,
+		u32 *result, unsigned timeout);
+int nvme_identify_ctrl(struct nvme_dev *dev, struct nvme_id_ctrl **id);
+int nvme_identify_ns(struct nvme_dev *dev, unsigned nsid,
+		struct nvme_id_ns **id);
+int nvme_get_log_page(struct nvme_dev *dev, struct nvme_smart_log **log);
+int nvme_get_features(struct nvme_dev *dev, unsigned fid, unsigned nsid,
+			dma_addr_t dma_addr, u32 *result);
+int nvme_set_features(struct nvme_dev *dev, unsigned fid, unsigned dword11,
+			dma_addr_t dma_addr, u32 *result);
+
+struct sg_io_hdr;
+
+int nvme_sg_io(struct nvme_ns *ns, struct sg_io_hdr __user *u_hdr);
+int nvme_sg_io32(struct nvme_ns *ns, unsigned long arg);
+int nvme_sg_get_version_num(int __user *ip);
+
+#endif /* _NVME_H */
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 7725b4c..364cb9a 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -16,9 +16,6 @@
 #define _LINUX_NVME_H
 
 #include <uapi/linux/nvme.h>
-#include <linux/pci.h>
-#include <linux/kref.h>
-#include <linux/blk-mq.h>
 
 struct nvme_bar {
 	__u64			cap;	/* Controller Capabilities */
@@ -76,115 +73,4 @@ enum {
 	NVME_CSTS_SHST_MASK	= 3 << 2,
 };
 
-extern unsigned char nvme_io_timeout;
-#define NVME_IO_TIMEOUT	(nvme_io_timeout * HZ)
-
-/*
- * Represents an NVM Express device.  Each nvme_dev is a PCI function.
- */
-struct nvme_dev {
-	struct list_head node;
-	struct nvme_queue **queues;
-	struct request_queue *admin_q;
-	struct blk_mq_tag_set tagset;
-	struct blk_mq_tag_set admin_tagset;
-	u32 __iomem *dbs;
-	struct device *dev;
-	struct dma_pool *prp_page_pool;
-	struct dma_pool *prp_small_pool;
-	int instance;
-	unsigned queue_count;
-	unsigned online_queues;
-	unsigned max_qid;
-	int q_depth;
-	u32 db_stride;
-	u32 ctrl_config;
-	struct msix_entry *entry;
-	struct nvme_bar __iomem *bar;
-	struct list_head namespaces;
-	struct kref kref;
-	struct device *device;
-	struct work_struct reset_work;
-	struct work_struct probe_work;
-	struct work_struct scan_work;
-	char name[12];
-	char serial[20];
-	char model[40];
-	char firmware_rev[8];
-	bool subsystem;
-	u32 max_hw_sectors;
-	u32 stripe_size;
-	u32 page_size;
-	void __iomem *cmb;
-	dma_addr_t cmb_dma_addr;
-	u64 cmb_size;
-	u32 cmbsz;
-	u16 oncs;
-	u16 abort_limit;
-	u8 event_limit;
-	u8 vwc;
-};
-
-/*
- * An NVM Express namespace is equivalent to a SCSI LUN
- */
-struct nvme_ns {
-	struct list_head list;
-
-	struct nvme_dev *dev;
-	struct request_queue *queue;
-	struct gendisk *disk;
-	struct kref kref;
-
-	unsigned ns_id;
-	int lba_shift;
-	u16 ms;
-	bool ext;
-	u8 pi_type;
-	u64 mode_select_num_blocks;
-	u32 mode_select_block_len;
-};
-
-/*
- * The nvme_iod describes the data in an I/O, including the list of PRP
- * entries.  You can't see it in this data structure because C doesn't let
- * me express that.  Use nvme_alloc_iod to ensure there's enough space
- * allocated to store the PRP list.
- */
-struct nvme_iod {
-	unsigned long private;	/* For the use of the submitter of the I/O */
-	int npages;		/* In the PRP list. 0 means small pool in use */
-	int offset;		/* Of PRP list */
-	int nents;		/* Used in scatterlist */
-	int length;		/* Of data, in bytes */
-	dma_addr_t first_dma;
-	struct scatterlist meta_sg[1]; /* metadata requires single contiguous buffer */
-	struct scatterlist sg[0];
-};
-
-static inline u64 nvme_block_nr(struct nvme_ns *ns, sector_t sector)
-{
-	return (sector >> (ns->lba_shift - 9));
-}
-
-int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
-		void *buf, unsigned bufflen);
-int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
-		void *buffer, void __user *ubuffer, unsigned bufflen,
-		u32 *result, unsigned timeout);
-int nvme_identify_ctrl(struct nvme_dev *dev, struct nvme_id_ctrl **id);
-int nvme_identify_ns(struct nvme_dev *dev, unsigned nsid,
-		struct nvme_id_ns **id);
-int nvme_get_log_page(struct nvme_dev *dev, struct nvme_smart_log **log);
-int nvme_get_features(struct nvme_dev *dev, unsigned fid, unsigned nsid,
-			dma_addr_t dma_addr, u32 *result);
-int nvme_set_features(struct nvme_dev *dev, unsigned fid, unsigned dword11,
-			dma_addr_t dma_addr, u32 *result);
-
-struct sg_io_hdr;
-
-int nvme_sg_io(struct nvme_ns *ns, struct sg_io_hdr __user *u_hdr);
-int nvme_sg_io32(struct nvme_ns *ns, unsigned long arg);
-int nvme_sg_get_version_num(int __user *ip);
-
 #endif /* _LINUX_NVME_H */
-- 
1.9.1
