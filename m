From: keith.busch@intel.com (Keith Busch)
Date: Tue, 23 Apr 2013 17:23:59 -0600
Subject: [PATCH] NVMe: Meta-data support in NVME_IOCTL_SUBMIT_IO
Message-ID: <1366759439-16265-1-git-send-email-keith.busch@intel.com>

This adds support for namespaces with separate meta-data formats in the
submit io ioctl. The meta-data buffer has to be a contiguous, so such
a buffer is allocated and the mapped user pages are copied to/from this
buffer for write/read commands.

Signed-off-by: Keith Busch <keith.busch at intel.com>

I have a device that supports meta-data, and this should make it easier
to test.
---
 drivers/block/nvme-core.c |   71 ++++++++++++++++++++++++++++++++++++++++++--
 include/linux/nvme.h      |    1 +
 2 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 40908a0..ccd024b 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1138,13 +1138,19 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	struct nvme_queue *nvmeq;
 	struct nvme_user_io io;
 	struct nvme_command c;
-	unsigned length;
-	int status;
-	struct nvme_iod *iod;
+	unsigned length, meta_len;
+	int status, i;
+	struct nvme_iod *iod, *meta_iod = NULL;
+	dma_addr_t meta_dma_addr;
+	void *meta, *uninitialized_var(meta_mem);
 
 	if (copy_from_user(&io, uio, sizeof(io)))
 		return -EFAULT;
 	length = (io.nblocks + 1) << ns->lba_shift;
+	meta_len = (io.nblocks + 1) * ns->ms;
+
+	if (meta_len && ((io.metadata & 3) || !io.metadata))  
+		return -EINVAL;
 
 	switch (io.opcode) {
 	case nvme_cmd_write:
@@ -1170,7 +1176,38 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	c.rw.reftag = cpu_to_le32(io.reftag);
 	c.rw.apptag = cpu_to_le16(io.apptag);
 	c.rw.appmask = cpu_to_le16(io.appmask);
-	/* XXX: metadata */
+
+	if (meta_len) {
+		meta_iod = nvme_map_user_pages(dev, io.opcode & 1, io.metadata, meta_len);
+		if (IS_ERR(meta_iod)) {
+			status = PTR_ERR(meta_iod);
+			meta_iod = NULL;
+			goto unmap;
+		}
+
+		meta_mem = dma_alloc_coherent(&dev->pci_dev->dev, meta_len,
+						&meta_dma_addr, GFP_KERNEL);
+		if (!meta_mem) {
+			status = -ENOMEM;
+			goto unmap;
+		}
+
+		if (io.opcode & 1) {
+			int meta_offset = 0;
+
+			for (i = 0; i < meta_iod->nents; i++) {
+				meta = kmap_atomic(sg_page(&meta_iod->sg[i])) +
+						meta_iod->sg[i].offset;
+				memcpy(meta_mem + meta_offset, meta,
+						meta_iod->sg[i].length);
+				kunmap_atomic(meta);
+				meta_offset += meta_iod->sg[i].length;
+			}
+		}
+
+		c.rw.metadata = cpu_to_le64(meta_dma_addr);
+	}
+
 	length = nvme_setup_prps(dev, &c.common, iod, length, GFP_KERNEL);
 
 	nvmeq = get_nvmeq(dev);
@@ -1186,8 +1223,33 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	else
 		status = nvme_submit_sync_cmd(nvmeq, &c, NULL, NVME_IO_TIMEOUT);
 
+	if (meta_len) {
+		if (status == NVME_SC_SUCCESS && !(io.opcode & 1)) {
+			int meta_offset = 0;
+
+			for (i = 0; i < meta_iod->nents; i++) {
+				meta = kmap_atomic(sg_page(&meta_iod->sg[i])) +
+						meta_iod->sg[i].offset;
+				memcpy(meta, meta_mem + meta_offset,
+						meta_iod->sg[i].length);
+				kunmap_atomic(meta);
+				meta_offset += meta_iod->sg[i].length;
+			}
+		}
+
+		dma_free_coherent(&dev->pci_dev->dev, meta_len, meta_mem,
+								meta_dma_addr);
+	}
+
+ unmap:
 	nvme_unmap_user_pages(dev, io.opcode & 1, iod);
 	nvme_free_iod(dev, iod);
+
+	if (meta_iod) {
+		nvme_unmap_user_pages(dev, io.opcode & 1, meta_iod);
+		nvme_free_iod(dev, meta_iod);
+	}
+
 	return status;
 }
 
@@ -1381,6 +1443,7 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, int nsid,
 	ns->disk = disk;
 	lbaf = id->flbas & 0xf;
 	ns->lba_shift = id->lbaf[lbaf].ds;
+	ns->ms = id->lbaf[lbaf].ms;
 	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
 	if (dev->max_hw_sectors)
 		blk_queue_max_hw_sectors(ns->queue, dev->max_hw_sectors);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 9b6fba8..a348510 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -551,6 +551,7 @@ struct nvme_ns {
 
 	int ns_id;
 	int lba_shift;
+	int ms;
 	u64 mode_select_num_blocks;
 	u32 mode_select_block_len;
 };
-- 
1.7.0.4
