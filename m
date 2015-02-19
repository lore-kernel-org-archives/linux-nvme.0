From: sathya.m@samsung.com (Sathayavathi M)
Date: Thu, 19 Feb 2015 17:07:39 +0530
Subject: [PATCH] NVMe: Check for Extended metadata in ioctl path
Message-ID: <1424345859-4002-1-git-send-email-sathya.m@samsung.com>

From: Sathyavathi M <sathya.m@samsung.com>

In NVME_IOCTL_SUBMIT_IO the check for the extended metadata is missing.
Currently, whenever an i/o request with extended metadata is issued,
io.metadata has to be assigned a dummy addr. If this is not assigned then the
check fails and returns error. This patch fixes this issue and also adds checks
at necessary places for extended metadata.

Signed-off-by: Sathyavathi M <sathya.m at samsung.com>
---
 drivers/block/nvme-core.c | 11 ++++++++---
 include/linux/nvme.h      |  1 +
 include/uapi/linux/nvme.h |  4 ++++
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 3eaa0be..a632d78 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1595,13 +1595,15 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	struct nvme_iod *iod, *meta_iod = NULL;
 	dma_addr_t meta_dma_addr;
 	void *meta, *uninitialized_var(meta_mem);
+	bool ext_lba = ns->flbas & EXT_LBA;
 
 	if (copy_from_user(&io, uio, sizeof(io)))
 		return -EFAULT;
 	length = (io.nblocks + 1) << ns->lba_shift;
 	meta_len = (io.nblocks + 1) * ns->ms;
 
-	if (meta_len && ((io.metadata & 3) || !io.metadata))
+	/* Check for unaligned or NULL metadata ptr for separate buffer */
+	if (meta_len && !(ext_lba) && ((io.metadata & 3) || !io.metadata))
 		return -EINVAL;
 
 	switch (io.opcode) {
@@ -1629,7 +1631,8 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	c.rw.apptag = cpu_to_le16(io.apptag);
 	c.rw.appmask = cpu_to_le16(io.appmask);
 
-	if (meta_len) {
+	/* Map the Separate Buffer separately (not needed for Extenede LBA) */
+	if (meta_len && !(ext_lba)) {
 		meta_iod = nvme_map_user_pages(dev, io.opcode & 1, io.metadata,
 								meta_len);
 		if (IS_ERR(meta_iod)) {
@@ -1670,7 +1673,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	else
 		status = nvme_submit_io_cmd(dev, ns, &c, NULL);
 
-	if (meta_len) {
+	if (meta_len && !(ext_lba)) {
 		if (status == NVME_SC_SUCCESS && !(io.opcode & 1)) {
 			int meta_offset = 0;
 
@@ -1862,6 +1865,7 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	if (nvme_identify(dev, ns->ns_id, 0, dma_addr))
 		goto free;
 
+	ns->flbas = id->flbas;
 	lbaf = id->flbas & 0xf;
 	ns->lba_shift = id->lbaf[lbaf].ds;
 
@@ -1963,6 +1967,7 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid,
 
 	ns->ns_id = nsid;
 	ns->disk = disk;
+	ns->flbas = id->flbas;
 	lbaf = id->flbas & 0xf;
 	ns->lba_shift = id->lbaf[lbaf].ds;
 	ns->ms = le16_to_cpu(id->lbaf[lbaf].ms);
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
