From: keith.busch@intel.com (Keith Busch)
Date: Tue,  7 Apr 2015 16:57:19 -0600
Subject: [PATCH] NVMe: Meta data handling through submit io ioctl
Message-ID: <1428447439-5182-1-git-send-email-keith.busch@intel.com>

This adds support for the extended metadata formats through the submit
IO ioctl, and simplifies the rest when using a separate metadata format.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |  123 ++++++++++++++++++---------------------------
 include/linux/nvme.h      |    5 +-
 2 files changed, 52 insertions(+), 76 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 8729266..879b030 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1745,25 +1745,31 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	struct nvme_dev *dev = ns->dev;
 	struct nvme_user_io io;
 	struct nvme_command c;
-	unsigned length, meta_len;
-	int status, i;
-	struct nvme_iod *iod, *meta_iod = NULL;
-	dma_addr_t meta_dma_addr;
-	void *meta, *uninitialized_var(meta_mem);
+	unsigned length, meta_len, prp_len;
+	int status, write;
+	struct nvme_iod *iod;
+	dma_addr_t meta_dma = 0;
+	void *meta = NULL;
 
 	if (copy_from_user(&io, uio, sizeof(io)))
 		return -EFAULT;
 	length = (io.nblocks + 1) << ns->lba_shift;
 	meta_len = (io.nblocks + 1) * ns->ms;
 
-	if (meta_len && ((io.metadata & 3) || !io.metadata))
+	if (meta_len && ((io.metadata & 3) || !io.metadata) && !ns->ext)
 		return -EINVAL;
+	else if (meta_len && ns->ext) {
+		length += meta_len;
+		meta_len = 0;
+	}
+
+	write = io.opcode & 1;
 
 	switch (io.opcode) {
 	case nvme_cmd_write:
 	case nvme_cmd_read:
 	case nvme_cmd_compare:
-		iod = nvme_map_user_pages(dev, io.opcode & 1, io.addr, length);
+		iod = nvme_map_user_pages(dev, write, io.addr, length);
 		break;
 	default:
 		return -EINVAL;
@@ -1772,6 +1778,27 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	if (IS_ERR(iod))
 		return PTR_ERR(iod);
 
+	prp_len = nvme_setup_prps(dev, iod, length, GFP_KERNEL);
+	if (length != prp_len) {
+		status = -ENOMEM;
+		goto unmap;
+	}
+	if (meta_len) {
+		meta = dma_alloc_coherent(&dev->pci_dev->dev, meta_len,
+						&meta_dma, GFP_KERNEL);
+		if (!meta) {
+			status = -ENOMEM;
+			goto unmap;
+		}
+		if (write) {
+			if (copy_from_user(meta, (void __user *)io.metadata,
+								meta_len)) {
+				status = -EFAULT;
+				goto unmap;
+			}
+		}
+	}
+
 	memset(&c, 0, sizeof(c));
 	c.rw.opcode = io.opcode;
 	c.rw.flags = io.flags;
@@ -1783,75 +1810,21 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	c.rw.reftag = cpu_to_le32(io.reftag);
 	c.rw.apptag = cpu_to_le16(io.apptag);
 	c.rw.appmask = cpu_to_le16(io.appmask);
-
-	if (meta_len) {
-		meta_iod = nvme_map_user_pages(dev, io.opcode & 1, io.metadata,
-								meta_len);
-		if (IS_ERR(meta_iod)) {
-			status = PTR_ERR(meta_iod);
-			meta_iod = NULL;
-			goto unmap;
-		}
-
-		meta_mem = dma_alloc_coherent(&dev->pci_dev->dev, meta_len,
-						&meta_dma_addr, GFP_KERNEL);
-		if (!meta_mem) {
-			status = -ENOMEM;
-			goto unmap;
-		}
-
-		if (io.opcode & 1) {
-			int meta_offset = 0;
-
-			for (i = 0; i < meta_iod->nents; i++) {
-				meta = kmap_atomic(sg_page(&meta_iod->sg[i])) +
-						meta_iod->sg[i].offset;
-				memcpy(meta_mem + meta_offset, meta,
-						meta_iod->sg[i].length);
-				kunmap_atomic(meta);
-				meta_offset += meta_iod->sg[i].length;
-			}
-		}
-
-		c.rw.metadata = cpu_to_le64(meta_dma_addr);
-	}
-
-	length = nvme_setup_prps(dev, iod, length, GFP_KERNEL);
 	c.rw.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
 	c.rw.prp2 = cpu_to_le64(iod->first_dma);
-
-	if (length != (io.nblocks + 1) << ns->lba_shift)
-		status = -ENOMEM;
-	else
-		status = nvme_submit_io_cmd(dev, ns, &c, NULL);
-
-	if (meta_len) {
-		if (status == NVME_SC_SUCCESS && !(io.opcode & 1)) {
-			int meta_offset = 0;
-
-			for (i = 0; i < meta_iod->nents; i++) {
-				meta = kmap_atomic(sg_page(&meta_iod->sg[i])) +
-						meta_iod->sg[i].offset;
-				memcpy(meta, meta_mem + meta_offset,
-						meta_iod->sg[i].length);
-				kunmap_atomic(meta);
-				meta_offset += meta_iod->sg[i].length;
-			}
-		}
-
-		dma_free_coherent(&dev->pci_dev->dev, meta_len, meta_mem,
-								meta_dma_addr);
-	}
-
+	c.rw.metadata = cpu_to_le64(meta_dma);
+	status = nvme_submit_io_cmd(dev, ns, &c, NULL);
  unmap:
-	nvme_unmap_user_pages(dev, io.opcode & 1, iod);
+	nvme_unmap_user_pages(dev, write, iod);
 	nvme_free_iod(dev, iod);
-
-	if (meta_iod) {
-		nvme_unmap_user_pages(dev, io.opcode & 1, meta_iod);
-		nvme_free_iod(dev, meta_iod);
+	if (meta) {
+		if (status == NVME_SC_SUCCESS && !write) {
+			if (copy_to_user((void __user *)io.metadata, meta,
+								meta_len))
+				status = -EFAULT;
+		}
+		dma_free_coherent(&dev->pci_dev->dev, meta_len, meta, meta_dma);
 	}
-
 	return status;
 }
 
@@ -2014,7 +1987,8 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	struct nvme_dev *dev = ns->dev;
 	struct nvme_id_ns *id;
 	dma_addr_t dma_addr;
-	int lbaf, pi_type, old_ms;
+	u8 lbaf, pi_type;
+	u16 old_ms;
 	unsigned short bs;
 
 	id = dma_alloc_coherent(&dev->pci_dev->dev, 4096, &dma_addr,
@@ -2035,6 +2009,7 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	lbaf = id->flbas & NVME_NS_FLBAS_LBA_MASK;
 	ns->lba_shift = id->lbaf[lbaf].ds;
 	ns->ms = le16_to_cpu(id->lbaf[lbaf].ms);
+	ns->ext = ns->ms && (id->flbas & NVME_NS_FLBAS_META_EXT);
 
 	/*
 	 * If identify namespace failed, use default 512 byte block size so
@@ -2051,14 +2026,14 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	if (blk_get_integrity(disk) && (ns->pi_type != pi_type ||
 				ns->ms != old_ms ||
 				bs != queue_logical_block_size(disk->queue) ||
-				(ns->ms && id->flbas & NVME_NS_FLBAS_META_EXT)))
+				(ns->ms && ns->ext)))
 		blk_integrity_unregister(disk);
 
 	ns->pi_type = pi_type;
 	blk_queue_logical_block_size(ns->queue, bs);
 
 	if (ns->ms && !blk_get_integrity(disk) && (disk->flags & GENHD_FL_UP) &&
-				!(id->flbas & NVME_NS_FLBAS_META_EXT))
+								!ns->ext)
 		nvme_init_integrity(ns);
 
 	if (id->ncap == 0 || (ns->ms && !blk_get_integrity(disk)))
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 0adad4a..8dbd05e 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -117,8 +117,9 @@ struct nvme_ns {
 
 	unsigned ns_id;
 	int lba_shift;
-	int ms;
-	int pi_type;
+	u16 ms;
+	bool ext;
+	u8 pi_type;
 	u64 mode_select_num_blocks;
 	u32 mode_select_block_len;
 };
-- 
1.7.10.4
