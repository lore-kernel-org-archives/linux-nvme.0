From: sathya.m@samsung.com (Sathyavathi M)
Date: Thu, 02 Apr 2015 11:36:56 +0530
Subject: [PATCHv3] NVMe: Spliting large i/o in the ioctl path
Message-ID: <1427954816-3394-1-git-send-email-sathya.m@samsung.com>

From: Sathyavathi M <sathya.m@samsung.com>

The NVME_IOCTL_SUBMIT_IO allows arbitrarily large i/o cmds if mdts is zero.
If the mdts has a limit, there is no check to verify if the cmd sent to device
is within the max transfer limit. This patch splits arbitrarily  large size i/o
to max_hw_sectors before submitting to device. If metadata (extended and
separate) is present then the i/o is split by considering both data+metadata.

Also addresses an issue where 128KB chunk i/o is split into 2(124KB+4KB)
when mdts is 0.

This also merges the previously submitted "Check for Extended metadata in ioctl
path" patch and addresses the comments for that patch.

This patch is generated against for-4.1 branch.

v1->v2
use of BLK_DEF_MAX_SECTORS macro is replaced with value.
v2->v3
Adressed the comments from Keith Busch

Signed-off-by: Sathyavathi M <sathya.m at samsung.com>
---
 drivers/block/nvme-core.c | 132 +++++++++++++++++++++++++++-------------------
 1 file changed, 79 insertions(+), 53 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 94832e1..0992a96 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1746,85 +1746,108 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	struct nvme_dev *dev = ns->dev;
 	struct nvme_user_io io;
 	struct nvme_command c;
-	unsigned length, meta_len;
-	int status, write;
-	struct nvme_iod *iod;
-	dma_addr_t meta_dma = 0;
+	unsigned tfr_len, meta_len = 0, split_length;
+	int status = 0, write, err = 0, count = 0, blk_sz;
+	u32 tfr_sectors;
+	u32 max_tfr_sectors, num_split_cmds, offset = 0;
+	u64 nxt_map_addr, nxt_meta_map_addr = 0;
+	struct nvme_iod *iod = NULL;
 	void *meta = NULL;
+	dma_addr_t meta_dma = 0;
 
 	if (copy_from_user(&io, uio, sizeof(io)))
 		return -EFAULT;
-	length = (io.nblocks + 1) << ns->lba_shift;
-	meta_len = (io.nblocks + 1) * ns->ms;
-
-	if (meta_len && ((io.metadata & 3) || !io.metadata) && !ns->ext)
+	max_tfr_sectors = dev->max_hw_sectors;
+	if (ns->ms && ((io.metadata & 3) || !io.metadata) && !ns->ext)
 		return -EINVAL;
-	else if (meta_len && ns->ext) {
-		length += meta_len;
-		meta_len = 0;
-	}
-
 	write = io.opcode & 1;
 
 	switch (io.opcode) {
 	case nvme_cmd_write:
 	case nvme_cmd_read:
 	case nvme_cmd_compare:
-		iod = nvme_map_user_pages(dev, write, io.addr, length);
 		break;
 	default:
 		return -EINVAL;
 	}
+	blk_sz = (1 << ns->lba_shift) + ((ns->ext && ns->ms) ? ns->ms : 0);
+	tfr_sectors = (max_tfr_sectors * 512) / blk_sz;
+
+	num_split_cmds = DIV_ROUND_UP((io.nblocks + 1), tfr_sectors);
 
-	if (IS_ERR(iod))
-		return PTR_ERR(iod);
+	for (count = 0; count < num_split_cmds; count++) {
+		tfr_sectors = min(tfr_sectors, (io.nblocks + 1) - offset);
+		tfr_len = tfr_sectors * blk_sz;
+		nxt_map_addr = io.addr + (blk_sz * offset);
+		if (ns->ms && !ns->ext) {
+			nxt_meta_map_addr = io.metadata + (ns->ms * offset);
+			meta_len = tfr_sectors * ns->ms;
+		}
+		iod = nvme_map_user_pages(dev, write, nxt_map_addr, tfr_len);
+
+		if (IS_ERR(iod))
+			return PTR_ERR(iod);
 		
-	length = nvme_setup_prps(dev, iod, length, GFP_KERNEL);
-	if (length != (io.nblocks + 1) << ns->lba_shift) {
-		status = -ENOMEM;
-		goto unmap;
-	}
-	if (meta_len) {
-		meta = dma_alloc_coherent(&dev->pci_dev->dev, meta_len,
-						&meta_dma, GFP_KERNEL);
-		if (!meta) {
+		split_length = nvme_setup_prps(dev, iod, tfr_len, GFP_KERNEL);
+		if (split_length != tfr_len) {
 			status = -ENOMEM;
+			err = true;
 			goto unmap;
 		}
-		if (write) {
-			if (copy_from_user(meta, (void __user *)io.metadata,
-								meta_len)) {
-				status = -EFAULT;
+		/* Mapping not needed for Extenede LBA */
+		if (ns->ms && !ns->ext) {
+			meta = dma_alloc_coherent(&dev->pci_dev->dev, meta_len,
+						&meta_dma, GFP_KERNEL);
+			if (!meta) {
+				status = -ENOMEM;
+				err = true;
 				goto unmap;
 			}
+			if (write) {
+				if (copy_from_user(meta,
+					(void __user *)nxt_meta_map_addr,
+								meta_len)) {
+					status = -EFAULT;
+					err = true;
+					goto unmap;
+				}
+			}
 		}
-	}
 
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
-	c.rw.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
-	c.rw.prp2 = cpu_to_le64(iod->first_dma);
-	c.rw.metadata = cpu_to_le64(meta_dma);
-	status = nvme_submit_io_cmd(dev, ns, &c, NULL);
+		memset(&c, 0, sizeof(c));
+		c.rw.opcode = io.opcode;
+		c.rw.flags = io.flags;
+		c.rw.nsid = cpu_to_le32(ns->ns_id);
+		c.rw.slba = cpu_to_le64(io.slba + offset);
+		c.rw.length = cpu_to_le16(tfr_sectors - 1);
+		c.rw.control = cpu_to_le16(io.control);
+		c.rw.dsmgmt = cpu_to_le32(io.dsmgmt);
+		if (ns->pi_type) {
+			c.rw.reftag = cpu_to_le32(io.reftag + offset);
+			c.rw.apptag = cpu_to_le16(io.apptag);
+			c.rw.appmask = cpu_to_le16(io.appmask);
+		}
+		c.rw.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
+		c.rw.prp2 = cpu_to_le64(iod->first_dma);
+		c.rw.metadata = cpu_to_le64(meta_dma);
+		status = nvme_submit_io_cmd(dev, ns, &c, NULL);
+		if (status != NVME_SC_SUCCESS)
+			err = true;
  unmap:
-	nvme_unmap_user_pages(dev, write, iod);
-	nvme_free_iod(dev, iod);
-	if (meta) {
-		if (status == NVME_SC_SUCCESS && !write) {
-			if (copy_to_user((void __user *)io.metadata, meta,
-								meta_len))
-				status = -EFAULT;
+		nvme_unmap_user_pages(dev, write, iod);
+		nvme_free_iod(dev, iod);
+		if (meta) {
+			if (status == NVME_SC_SUCCESS && !write) {
+				if (copy_to_user((void __user *)io.metadata +
+					(ns->ms * offset), meta, meta_len))
+					status = -EFAULT;
+			}
+			dma_free_coherent(&dev->pci_dev->dev, meta_len, meta,
+								meta_dma);
 		}
-		dma_free_coherent(&dev->pci_dev->dev, meta_len, meta, meta_dma);
+		offset += tfr_sectors;
+		if (err)
+			break;
 	}
 	return status;
 }
@@ -2310,8 +2333,11 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	memcpy(dev->serial, ctrl->sn, sizeof(ctrl->sn));
 	memcpy(dev->model, ctrl->mn, sizeof(ctrl->mn));
 	memcpy(dev->firmware_rev, ctrl->fr, sizeof(ctrl->fr));
+	/* Increase max transfer size if device reports MDTS=0 */
 	if (ctrl->mdts)
 		dev->max_hw_sectors = 1 << (ctrl->mdts + shift - 9);
+	else
+		dev->max_hw_sectors = UINT_MAX;
 	if ((pdev->vendor == PCI_VENDOR_ID_INTEL) &&
 			(pdev->device == 0x0953) && ctrl->vs[3]) {
 		unsigned int max_hw_sectors;
-- 
1.8.4.2
