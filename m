From: sathya.m@samsung.com (Sathayavathi M)
Date: Fri, 20 Feb 2015 14:14:30 +0530
Subject: [PATCH] NVME: Splitting large i/o in the ioctl path
Message-ID: <1424421870-3151-1-git-send-email-sathya.m@samsung.com>

From: Sathyavathi M <sathya.m@samsung.com>

The NVME_IOCTL_SUBMIT_IO allows arbitrarily large i/o cmds if mdts is zero.
If the mdts has a limit, there is no check to verify if the cmd sent to device
is within the max transfer limit. This patch splits arbitrarily  large size i/o
to max_hw_sectors before submitting to device. If metadata (extended and separate)
is present then the i/o is split by considering both data+metadata.

Also addresses an issue where 128KB chunk i/o is split into 2(124KB+4KB) when
mdts is 0.

This also merges the previously submitted "Check for Extended metadata in ioctl
path" patch and addresses the comments for that patch.

Signed-off-by: Sathyavathi M <sathya.m at samsung.com>
---
 drivers/block/nvme-core.c | 210 ++++++++++++++++++++++++++++------------------
 include/linux/nvme.h      |   1 +
 include/uapi/linux/nvme.h |   4 +
 3 files changed, 133 insertions(+), 82 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index cbdfbbf..fc87b09 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1622,111 +1622,152 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	struct nvme_dev *dev = ns->dev;
 	struct nvme_user_io io;
 	struct nvme_command c;
-	unsigned length, meta_len;
-	int status, i;
-	struct nvme_iod *iod, *meta_iod = NULL;
+	unsigned tfr_len, meta_len = 0, split_length;
+	int status = 0, i, err = 0, count = 0;
+	u32 tfr_sectors;
+	u32 max_tfr_sectors, num_split_cmds, offset = 0;
+	u64 nxt_map_addr, nxt_meta_map_addr = 0;
+	struct nvme_iod *iod = NULL, *meta_iod = NULL;
 	dma_addr_t meta_dma_addr;
 	void *meta, *uninitialized_var(meta_mem);
+	bool ext_lba = ns->flbas & EXT_LBA;
 
 	if (copy_from_user(&io, uio, sizeof(io)))
 		return -EFAULT;
-	length = (io.nblocks + 1) << ns->lba_shift;
-	meta_len = (io.nblocks + 1) * ns->ms;
+	max_tfr_sectors = dev->max_hw_sectors;
 
-	if (meta_len && ((io.metadata & 3) || !io.metadata))
+	/* Check for unaligned or NULL metadata ptr for separate buffer */
+	if (ns->ms && !(ext_lba) && ((io.metadata & 3) || !io.metadata))
 		return -EINVAL;
 
-	switch (io.opcode) {
-	case nvme_cmd_write:
-	case nvme_cmd_read:
-	case nvme_cmd_compare:
-		iod = nvme_map_user_pages(dev, io.opcode & 1, io.addr, length);
-		break;
-	default:
+	if (io.opcode != nvme_cmd_write && io.opcode != nvme_cmd_read &&
+						io.opcode != nvme_cmd_compare)
 		return -EINVAL;
-	}
-
-	if (IS_ERR(iod))
-		return PTR_ERR(iod);
-
-	memset(&c, 0, sizeof(c));
-	c.rw.opcode = io.opcode;
-	c.rw.flags = io.flags;
-	c.rw.nsid = cpu_to_le32(ns->ns_id);
-	c.rw.slba = cpu_to_le64(io.slba);
-	c.rw.length = cpu_to_le16(io.nblocks);
-	c.rw.control = cpu_to_le16(io.control);
-	c.rw.dsmgmt = cpu_to_le32(io.dsmgmt);
-	c.rw.reftag = cpu_to_le32(io.reftag);
-	c.rw.apptag = cpu_to_le16(io.apptag);
-	c.rw.appmask = cpu_to_le16(io.appmask);
-
-	if (meta_len) {
-		meta_iod = nvme_map_user_pages(dev, io.opcode & 1, io.metadata,
-								meta_len);
-		if (IS_ERR(meta_iod)) {
-			status = PTR_ERR(meta_iod);
-			meta_iod = NULL;
-			goto unmap;
+	if (ext_lba || !ns->ms)
+		num_split_cmds = DIV_ROUND_UP((((io.nblocks + 1)
+			<< ns->lba_shift) + ((io.nblocks + 1) * ns->ms)),
+					(max_tfr_sectors << ns->lba_shift));
+	else
+		num_split_cmds = DIV_ROUND_UP(((io.nblocks + 1)
+			<< ns->lba_shift), (max_tfr_sectors << ns->lba_shift));
+
+	for (count = 0; count < num_split_cmds; count++) {
+		if (!ns->ms || !(ext_lba)) {
+			tfr_sectors = min(max_tfr_sectors, (io.nblocks + 1) -
+								offset);
+			tfr_len = tfr_sectors << ns->lba_shift;
+			nxt_map_addr = io.addr + ((1 << ns->lba_shift) *
+								offset);
+			if (ns->ms) {
+				nxt_meta_map_addr = io.metadata + (ns->ms
+						* offset);
+				meta_len = tfr_sectors * ns->ms;
+			}
 		}
-
-		meta_mem = dma_alloc_coherent(&dev->pci_dev->dev, meta_len,
-						&meta_dma_addr, GFP_KERNEL);
-		if (!meta_mem) {
-			status = -ENOMEM;
-			goto unmap;
+		/* ExtendedLBA */
+		else if (ns->ms && ext_lba) {
+			tfr_sectors = (max_tfr_sectors * (1 << ns->lba_shift))
+					/ ((1 << ns->lba_shift) + ns->ms);
+			tfr_sectors = min(tfr_sectors, (io.nblocks + 1) -
+								offset);
+			tfr_len = tfr_sectors * ((1 << ns->lba_shift) +
+								ns->ms);
+			nxt_map_addr = io.addr + (((1 << ns->lba_shift) +
+							ns->ms) * offset);
 		}
+		iod = nvme_map_user_pages(dev, io.opcode & 1, nxt_map_addr,
+								tfr_len);
+		if (IS_ERR(iod))
+			return PTR_ERR(iod);
 
-		if (io.opcode & 1) {
-			int meta_offset = 0;
+		memset(&c, 0, sizeof(c));
+		c.rw.opcode = io.opcode;
+		c.rw.flags = io.flags;
+		c.rw.nsid = cpu_to_le32(ns->ns_id);
+		c.rw.slba = cpu_to_le64(io.slba + offset);
+		c.rw.length = cpu_to_le16(tfr_sectors - 1);
+		c.rw.control = cpu_to_le16(io.control);
+		c.rw.dsmgmt = cpu_to_le32(io.dsmgmt);
+		c.rw.reftag = cpu_to_le32(io.reftag);
+		c.rw.apptag = cpu_to_le16(io.apptag);
+		c.rw.appmask = cpu_to_le16(io.appmask);
+
+		/* Mapping not needed for Extenede LBA */
+		if (ns->ms && !(ext_lba)) {
+			meta_iod = nvme_map_user_pages(dev, io.opcode & 1,
+					nxt_meta_map_addr, meta_len);
+			if (IS_ERR(meta_iod)) {
+				status = PTR_ERR(meta_iod);
+				meta_iod = NULL;
+				err = true;
+				goto unmap;
+			}
 
-			for (i = 0; i < meta_iod->nents; i++) {
-				meta = kmap_atomic(sg_page(&meta_iod->sg[i])) +
-						meta_iod->sg[i].offset;
-				memcpy(meta_mem + meta_offset, meta,
-						meta_iod->sg[i].length);
-				kunmap_atomic(meta);
-				meta_offset += meta_iod->sg[i].length;
+			meta_mem = dma_alloc_coherent(&dev->pci_dev->dev,
+					meta_len, &meta_dma_addr, GFP_KERNEL);
+			if (!meta_mem) {
+				status = -ENOMEM;
+				err = true;
+				goto unmap;
 			}
-		}
 
-		c.rw.metadata = cpu_to_le64(meta_dma_addr);
-	}
+			if (io.opcode & 1) {
+				int meta_offset = 0;
 
-	length = nvme_setup_prps(dev, iod, length, GFP_KERNEL);
-	c.rw.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
-	c.rw.prp2 = cpu_to_le64(iod->first_dma);
+				for (i = 0; i < meta_iod->nents; i++) {
+					meta = kmap_atomic(sg_page(
+					&meta_iod->sg[i])) + meta_iod->sg[i].
+									offset;
+					memcpy(meta_mem + meta_offset, meta,
+						meta_iod->sg[i].length);
+					kunmap_atomic(meta);
+					meta_offset += meta_iod->sg[i].length;
+				}
+			}
 
-	if (length != (io.nblocks + 1) << ns->lba_shift)
-		status = -ENOMEM;
-	else
-		status = nvme_submit_io_cmd(dev, ns, &c, NULL);
+			c.rw.metadata = cpu_to_le64(meta_dma_addr);
+		}
 
-	if (meta_len) {
-		if (status == NVME_SC_SUCCESS && !(io.opcode & 1)) {
-			int meta_offset = 0;
+		split_length = nvme_setup_prps(dev, iod, tfr_len, GFP_KERNEL);
+		c.rw.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
+		c.rw.prp2 = cpu_to_le64(iod->first_dma);
 
-			for (i = 0; i < meta_iod->nents; i++) {
-				meta = kmap_atomic(sg_page(&meta_iod->sg[i])) +
-						meta_iod->sg[i].offset;
-				memcpy(meta, meta_mem + meta_offset,
+		if (split_length != tfr_len)
+			status = -ENOMEM;
+		else {
+			status = nvme_submit_io_cmd(dev, ns, &c, NULL);
+			if (status != NVME_SC_SUCCESS)
+				err = true;
+		}
+		if (ns->ms && !(ext_lba)) {
+			if (status == NVME_SC_SUCCESS && !(io.opcode & 1)) {
+				int meta_offset = 0;
+
+				for (i = 0; i < meta_iod->nents; i++) {
+					meta = kmap_atomic(sg_page(
+					&meta_iod->sg[i])) + meta_iod->sg[i].
+									offset;
+					memcpy(meta, meta_mem + meta_offset,
 						meta_iod->sg[i].length);
-				kunmap_atomic(meta);
-				meta_offset += meta_iod->sg[i].length;
+					kunmap_atomic(meta);
+					meta_offset += meta_iod->sg[i].length;
+				}
 			}
-		}
-
-		dma_free_coherent(&dev->pci_dev->dev, meta_len, meta_mem,
-								meta_dma_addr);
-	}
 
- unmap:
-	nvme_unmap_user_pages(dev, io.opcode & 1, iod);
-	nvme_free_iod(dev, iod);
+			dma_free_coherent(&dev->pci_dev->dev, meta_len,
+						meta_mem, meta_dma_addr);
+		}
+		offset += tfr_sectors;
+unmap:
+		nvme_unmap_user_pages(dev, io.opcode & 1, iod);
+		nvme_free_iod(dev, iod);
 
-	if (meta_iod) {
-		nvme_unmap_user_pages(dev, io.opcode & 1, meta_iod);
-		nvme_free_iod(dev, meta_iod);
+		if (meta_iod) {
+			nvme_unmap_user_pages(dev, io.opcode & 1, meta_iod);
+			nvme_free_iod(dev, meta_iod);
+		}
+		if (err)
+			break;
 	}
 
 	return status;
@@ -1894,6 +1935,7 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	if (nvme_identify(dev, ns->ns_id, 0, dma_addr))
 		goto free;
 
+	ns->flbas = id->flbas;
 	lbaf = id->flbas & 0xf;
 	ns->lba_shift = id->lbaf[lbaf].ds;
 
@@ -1995,6 +2037,7 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid,
 
 	ns->ns_id = nsid;
 	ns->disk = disk;
+	ns->flbas = id->flbas;
 	lbaf = id->flbas & 0xf;
 	ns->lba_shift = id->lbaf[lbaf].ds;
 	ns->ms = le16_to_cpu(id->lbaf[lbaf].ms);
@@ -2177,8 +2220,11 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	memcpy(dev->serial, ctrl->sn, sizeof(ctrl->sn));
 	memcpy(dev->model, ctrl->mn, sizeof(ctrl->mn));
 	memcpy(dev->firmware_rev, ctrl->fr, sizeof(ctrl->fr));
+	/* Increase max transfer size if device reports MDTS=0 */
 	if (ctrl->mdts)
 		dev->max_hw_sectors = 1 << (ctrl->mdts + shift - 9);
+	else
+		dev->max_hw_sectors = BLK_DEF_MAX_SECOTRS;
 	if ((pdev->vendor == PCI_VENDOR_ID_INTEL) &&
 			(pdev->device == 0x0953) && ctrl->vs[3]) {
 		unsigned int max_hw_sectors;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 19a5d4b..9c74cbc 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -121,6 +121,7 @@ struct nvme_ns {
 	unsigned ns_id;
 	int lba_shift;
 	int ms;
+	u8 flbas;
 	u64 mode_select_num_blocks;
 	u32 mode_select_block_len;
 };
diff --git a/include/uapi/linux/nvme.h b/include/uapi/linux/nvme.h
index 26386cf..1e3b7a6 100644
--- a/include/uapi/linux/nvme.h
+++ b/include/uapi/linux/nvme.h
@@ -98,6 +98,10 @@ struct nvme_lbaf {
 	__u8			rp;
 };
 
+enum {
+	EXT_LBA		= 0x10
+};
+
 struct nvme_id_ns {
 	__le64			nsze;
 	__le64			ncap;
-- 
1.8.3.2
