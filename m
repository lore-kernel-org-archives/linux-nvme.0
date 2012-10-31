From: vishal.l.verma@intel.com (Vishal Verma)
Date: Wed, 31 Oct 2012 11:52:33 -0600
Subject: [PATCH v2 2/3] NVMe: Move dev, ns, iod structs to nvme.c
In-Reply-To: <1351705954-17531-1-git-send-email-vishal.l.verma@intel.com>
References: <1351705954-17531-1-git-send-email-vishal.l.verma@intel.com>
Message-ID: <1351705954-17531-2-git-send-email-vishal.l.verma@intel.com>

nvme-scsi.c uses nvme_dev, nvme_ns, and nvme_iod.
Move the structure definitions to nvme.h

Signed-off-by: Vishal Verma <vishal.l.verma at intel.com>
---
 drivers/block/nvme-core.c |   53 -----------------------------------
 include/linux/nvme.h      |   67 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 53 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 7df794f..f808b0a 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -59,43 +59,6 @@ static LIST_HEAD(dev_list);
 static struct task_struct *nvme_thread;
 
 /*
- * Represents an NVM Express device.  Each nvme_dev is a PCI function.
- */
-struct nvme_dev {
-	struct list_head node;
-	struct nvme_queue **queues;
-	u32 __iomem *dbs;
-	struct pci_dev *pci_dev;
-	struct dma_pool *prp_page_pool;
-	struct dma_pool *prp_small_pool;
-	int instance;
-	int queue_count;
-	int db_stride;
-	u32 ctrl_config;
-	struct msix_entry *entry;
-	struct nvme_bar __iomem *bar;
-	struct list_head namespaces;
-	char serial[20];
-	char model[40];
-	char firmware_rev[8];
-	u32 max_hw_sectors;
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
-
-	int ns_id;
-	int lba_shift;
-};
-
-/*
  * An NVM Express queue.  Each device has at least two (one for admin
  * commands and one for I/O commands).
  */
@@ -292,22 +255,6 @@ static int nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd)
 	return 0;
 }
 
-/*
- * The nvme_iod describes the data in an I/O, including the list of PRP
- * entries.  You can't see it in this data structure because C doesn't let
- * me express that.  Use nvme_alloc_iod to ensure there's enough space
- * allocated to store the PRP list.
- */
-struct nvme_iod {
-	void *private;		/* For the use of the submitter of the I/O */
-	int npages;		/* In the PRP list. 0 means small pool in use */
-	int offset;		/* Of PRP list */
-	int nents;		/* Used in scatterlist */
-	int length;		/* Of data, in bytes */
-	dma_addr_t first_dma;
-	struct scatterlist sg[0];
-};
-
 static __le64 **iod_list(struct nvme_iod *iod)
 {
 	return ((void *)iod) + iod->offset;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 1837611..f4e0649 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -461,4 +461,71 @@ struct nvme_admin_cmd {
 #define NVME_IOCTL_ADMIN_CMD	_IOWR('N', 0x41, struct nvme_admin_cmd)
 #define NVME_IOCTL_SUBMIT_IO	_IOW('N', 0x42, struct nvme_user_io)
 
+#ifdef __KERNEL__
+#include <linux/pci.h>
+
+/*
+ * Represents an NVM Express device.  Each nvme_dev is a PCI function.
+ */
+struct nvme_dev {
+	struct list_head node;
+	struct nvme_queue **queues;
+	u32 __iomem *dbs;
+	struct pci_dev *pci_dev;
+	struct dma_pool *prp_page_pool;
+	struct dma_pool *prp_small_pool;
+	int instance;
+	int queue_count;
+	int db_stride;
+	u32 ctrl_config;
+	struct msix_entry *entry;
+	struct nvme_bar __iomem *bar;
+	struct list_head namespaces;
+	char serial[20];
+	char model[40];
+	char firmware_rev[8];
+	u16 vendor_id;
+	u32 max_hw_sectors;
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
+
+	int ns_id;
+	int lba_shift;
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
+	void *private;		/* For the use of the submitter of the I/O */
+	int npages;		/* In the PRP list. 0 means small pool in use */
+	int offset;		/* Of PRP list */
+	int nents;		/* Used in scatterlist */
+	int length;		/* Of data, in bytes */
+	dma_addr_t first_dma;
+	struct scatterlist sg[0];
+};
+
+/**
+ * nvme_free_iod - frees an nvme_iod
+ * @dev: The device that the I/O was submitted to
+ * @iod: The memory to free
+ */
+
+#endif
+
 #endif /* _LINUX_NVME_H */
-- 
1.7.0.4
