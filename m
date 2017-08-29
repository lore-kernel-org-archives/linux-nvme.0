From: keith.busch@intel.com (Keith Busch)
Date: Tue, 29 Aug 2017 17:46:01 -0400
Subject: [PATCHv2 1/4] nvme: factor metadata handling out of
 __nvme_submit_user_cmd
In-Reply-To: <1504043164-5398-1-git-send-email-keith.busch@intel.com>
References: <1504043164-5398-1-git-send-email-keith.busch@intel.com>
Message-ID: <1504043164-5398-2-git-send-email-keith.busch@intel.com>

From: Christoph Hellwig <hch@lst.de>

Keep the metadata code in a separate helper instead of making the
main function more complicated.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 78 +++++++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 37 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0f3d4bf..a28f181 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -704,6 +704,40 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 }
 EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
 
+static void *nvme_add_user_metadata(struct bio *bio, void __user *ubuf,
+		unsigned len, u32 seed, bool write)
+{
+	struct bio_integrity_payload *bip;
+	int ret = -ENOMEM;
+	void *buf;
+
+	buf = kmalloc(len, GFP_KERNEL);
+	if (!buf)
+		goto out;
+
+	ret = -EFAULT;
+	if (write && copy_from_user(buf, buf, len))
+		goto out_free_meta;
+
+	bip = bio_integrity_alloc(bio, GFP_KERNEL, 1);
+	if (IS_ERR(bip)) {
+		ret = PTR_ERR(bip);
+		goto out_free_meta;
+	}
+
+	bip->bip_iter.bi_size = len;
+	bip->bip_iter.bi_sector = seed;
+	ret = bio_integrity_add_page(bio, virt_to_page(buf), len,
+			offset_in_page(buf));
+	if (ret == len)
+		return buf;
+	ret = -ENOMEM;
+out_free_meta:
+	kfree(buf);
+out:
+	return ERR_PTR(ret);
+}
+
 int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void __user *ubuffer, unsigned bufflen,
 		void __user *meta_buffer, unsigned meta_len, u32 meta_seed,
@@ -729,46 +763,17 @@ int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
 		if (ret)
 			goto out;
 		bio = req->bio;
-
-		if (!disk)
-			goto submit;
 		bio->bi_disk = disk;
-
-		if (meta_buffer && meta_len) {
-			struct bio_integrity_payload *bip;
-
-			meta = kmalloc(meta_len, GFP_KERNEL);
-			if (!meta) {
-				ret = -ENOMEM;
+		if (disk && meta_buffer && meta_len) {
+			meta = nvme_add_user_metadata(bio, meta_buffer, meta_len,
+					meta_seed, write);
+			if (IS_ERR(meta)) {
+				ret = PTR_ERR(meta);
 				goto out_unmap;
 			}
-
-			if (write) {
-				if (copy_from_user(meta, meta_buffer,
-						meta_len)) {
-					ret = -EFAULT;
-					goto out_free_meta;
-				}
-			}
-
-			bip = bio_integrity_alloc(bio, GFP_KERNEL, 1);
-			if (IS_ERR(bip)) {
-				ret = PTR_ERR(bip);
-				goto out_free_meta;
-			}
-
-			bip->bip_iter.bi_size = meta_len;
-			bip->bip_iter.bi_sector = meta_seed;
-
-			ret = bio_integrity_add_page(bio, virt_to_page(meta),
-					meta_len, offset_in_page(meta));
-			if (ret != meta_len) {
-				ret = -ENOMEM;
-				goto out_free_meta;
-			}
 		}
 	}
- submit:
+
 	blk_execute_rq(req->q, disk, req, 0);
 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
 		ret = -EINTR;
@@ -779,9 +784,8 @@ int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
 	if (meta && !ret && !write) {
 		if (copy_to_user(meta_buffer, meta, meta_len))
 			ret = -EFAULT;
+		kfree(meta);
 	}
- out_free_meta:
-	kfree(meta);
  out_unmap:
 	if (bio)
 		blk_rq_unmap_user(bio);
-- 
2.5.5
