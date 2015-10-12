From: hch@lst.de (Christoph Hellwig)
Date: Mon, 12 Oct 2015 09:10:05 +0200
Subject: [PATCH 2/8] nvme: use the block layer for userspace passthrough
 metadata
In-Reply-To: <1444633811-28319-1-git-send-email-hch@lst.de>
References: <1444633811-28319-1-git-send-email-hch@lst.de>
Message-ID: <1444633811-28319-3-git-send-email-hch@lst.de>

Use the integrity API to pass through metadata from userspace.  For PI
enabled devices this means that we now validate the reftag, which seems
like an unintentional ommission in the old code.

WARNING: This is completely untested, I don't have a metadata capable device.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 69 ++++++++++++++++++++++++++++++++++++++++++------
 drivers/nvme/host/nvme.h |  4 +++
 drivers/nvme/host/pci.c  | 40 +++++-----------------------
 3 files changed, 71 insertions(+), 42 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9d05df0..01a805f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -81,12 +81,15 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	return __nvme_submit_sync_cmd(q, cmd, buffer, bufflen, NULL, 0);
 }
 
-int nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
-		void __user *ubuffer, unsigned bufflen, u32 *result,
-		unsigned timeout)
+int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
+		void __user *ubuffer, unsigned bufflen,
+		void __user *meta_buffer, unsigned meta_len, u32 meta_seed,
+		u32 *result, unsigned timeout)
 {
-	struct bio *bio = NULL;
+	bool write = cmd->common.opcode & 1;
 	struct request *req;
+	struct bio *bio = NULL;
+	void *meta = NULL;
 	int ret;
 
 	req = nvme_alloc_request(q, cmd);
@@ -94,26 +97,76 @@ int nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
 		return PTR_ERR(req);
 
 	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
-
+	
 	if (ubuffer && bufflen) {
 		ret = blk_rq_map_user(q, req, NULL, ubuffer, bufflen,
 				__GFP_WAIT);
 		if (ret)
 			goto out;
 		bio = req->bio;
+
+		if (meta_buffer) {
+			struct bio_integrity_payload *bip;
+
+			meta = kmalloc(meta_len, GFP_KERNEL);
+			if (!meta) {
+				ret = -ENOMEM;
+				goto out_unmap;
+			}
+
+			if (write) {
+				if (copy_from_user(meta, meta_buffer,
+						meta_len)) {
+					ret = -EFAULT;
+					goto out_free_meta;
+				}
+			}
+
+			bip = bio_integrity_alloc(bio, GFP_KERNEL, 1);
+			if (!bip) {
+				ret = -ENOMEM;
+				goto out_free_meta;
+			}
+
+			bip->bip_iter.bi_size = meta_len;
+			bip->bip_iter.bi_sector = meta_seed;
+
+			ret = bio_integrity_add_page(bio, virt_to_page(meta),
+					meta_len, offset_in_page(meta));
+			if (ret != meta_len) {
+				ret = -ENOMEM;
+				goto out_free_meta;
+			}
+		}
 	}
 
 	blk_execute_rq(req->q, NULL, req, 0);
-	if (bio)
-		blk_rq_unmap_user(bio);
+	ret = req->errors;
 	if (result)
 		*result = (u32)(uintptr_t)req->special;
-	ret = req->errors;
+	if (meta && !ret && !write) {
+		if (copy_to_user(meta_buffer, meta, meta_len))
+			ret = -EFAULT;
+	}
+
+ out_free_meta:
+	kfree(meta);
+ out_unmap:
+	if (bio)
+		blk_rq_unmap_user(bio);
  out:
 	blk_mq_free_request(req);
 	return ret;
 }
 
+int nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
+		void __user *ubuffer, unsigned bufflen, u32 *result,
+		unsigned timeout)
+{
+	return __nvme_submit_user_cmd(q, cmd, ubuffer, bufflen, NULL, 0, 0,
+			result, timeout);
+}
+
 int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 {
 	struct nvme_command c = { };
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 4d13354..0d0725c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -87,6 +87,10 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 int nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void __user *ubuffer, unsigned bufflen, u32 *result,
 		unsigned timeout);
+int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
+		void __user *ubuffer, unsigned bufflen,
+		void __user *meta_buffer, unsigned meta_len, u32 meta_seed,
+		u32 *result, unsigned timeout);
 int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id);
 int nvme_identify_ns(struct nvme_ctrl *dev, unsigned nsid,
 		struct nvme_id_ns **id);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 29b48a2..21755ee 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1674,13 +1674,9 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 
 static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 {
-	struct nvme_dev *dev = to_nvme_dev(ns->ctrl);
 	struct nvme_user_io io;
 	struct nvme_command c;
 	unsigned length, meta_len;
-	int status, write;
-	dma_addr_t meta_dma = 0;
-	void *meta = NULL;
 	void __user *metadata;
 
 	if (copy_from_user(&io, uio, sizeof(io)))
@@ -1698,29 +1694,13 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	length = (io.nblocks + 1) << ns->lba_shift;
 	meta_len = (io.nblocks + 1) * ns->ms;
 	metadata = (void __user *)(unsigned long)io.metadata;
-	write = io.opcode & 1;
 
 	if (ns->ext) {
 		length += meta_len;
 		meta_len = 0;
-	}
-	if (meta_len) {
-		if (((io.metadata & 3) || !io.metadata) && !ns->ext)
+	} else if (meta_len) {
+		if ((io.metadata & 3) || !io.metadata)
 			return -EINVAL;
-
-		meta = dma_alloc_coherent(dev->dev, meta_len,
-						&meta_dma, GFP_KERNEL);
-
-		if (!meta) {
-			status = -ENOMEM;
-			goto unmap;
-		}
-		if (write) {
-			if (copy_from_user(meta, metadata, meta_len)) {
-				status = -EFAULT;
-				goto unmap;
-			}
-		}
 	}
 
 	memset(&c, 0, sizeof(c));
@@ -1734,19 +1714,11 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	c.rw.reftag = cpu_to_le32(io.reftag);
 	c.rw.apptag = cpu_to_le16(io.apptag);
 	c.rw.appmask = cpu_to_le16(io.appmask);
-	c.rw.metadata = cpu_to_le64(meta_dma);
 
-	status = nvme_submit_user_cmd(ns->queue, &c,
-			(void __user *)io.addr, length, NULL, 0);
- unmap:
-	if (meta) {
-		if (status == NVME_SC_SUCCESS && !write) {
-			if (copy_to_user(metadata, meta, meta_len))
-				status = -EFAULT;
-		}
-		dma_free_coherent(dev->dev, meta_len, meta, meta_dma);
-	}
-	return status;
+	return __nvme_submit_user_cmd(ns->queue, &c,
+			(void __user *)io.addr, length,
+			metadata, meta_len, c.rw.slba,
+			NULL, 0);
 }
 
 static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-- 
1.9.1
