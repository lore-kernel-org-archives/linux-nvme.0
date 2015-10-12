From: hch@lst.de (Christoph Hellwig)
Date: Mon, 12 Oct 2015 09:04:12 +0200
Subject: [PATCH 1/5] nvme: move struct nvme_iod to pci.c
In-Reply-To: <1444633456-27698-1-git-send-email-hch@lst.de>
References: <1444633456-27698-1-git-send-email-hch@lst.de>
Message-ID: <1444633456-27698-2-git-send-email-hch@lst.de>

This structure is specific to the PCIe driver internals and should be moved
to pci.c.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/nvme.h | 17 -----------------
 drivers/nvme/host/pci.c  | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c1f41bf..835941b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -88,23 +88,6 @@ struct nvme_ns {
 	u32 mode_select_block_len;
 };
 
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
 static inline u64 nvme_block_nr(struct nvme_ns *ns, sector_t sector)
 {
 	return (sector >> (ns->lba_shift - 9));
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1dc5db5..f494324 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -128,6 +128,23 @@ struct nvme_queue {
 };
 
 /*
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
+/*
  * Check we didin't inadvertently grow the command struct
  */
 static inline void _nvme_check_size(void)
-- 
1.9.1
