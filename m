From: keith.busch@intel.com (Keith Busch)
Date: Wed,  7 Dec 2016 12:39:24 -0500
Subject: [PATCH] nvme: support bi-directional commands
Message-ID: <1481132364-20583-1-git-send-email-keith.busch@intel.com>

The nvme specification defines the opcode's lower 2 bits as the
transfer direction, which allows for bi-directional commands. While
there are no standard defined opcodes that use both data directions,
this is something a vendor unique opcode may use.

This patch adds support for bi-directional user commands. The block
layer doesn't natively support a request with both directions, but we
can treat it like a read and set up rq_map_data to force copying the
user data to the kernel buffers before the transfer.

Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
The target rdma part isn't tested here, and I'm not so sure it's correct
as I don't see anything checking for DMA_BIDIRECTIONAL, but do see checks
for DMA_TO_DEVICE and DMA_FROM_DEVICE.

 drivers/nvme/host/core.c    | 26 +++++++++++++++++++++++---
 drivers/nvme/target/nvmet.h |  3 ++-
 drivers/nvme/target/rdma.c  |  5 +++--
 include/linux/nvme.h        | 21 ++++++++++++++++++---
 4 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 525d653..380f258 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -398,10 +398,12 @@ int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
 	bool write = nvme_is_write(cmd);
 	struct nvme_ns *ns = q->queuedata;
 	struct gendisk *disk = ns ? ns->disk : NULL;
+	struct rq_map_data *md = NULL, map_data;
+	struct page *pages = NULL;
 	struct request *req;
 	struct bio *bio = NULL;
 	void *meta = NULL;
-	int ret;
+	int ret, order = get_order(bufflen);
 
 	req = nvme_alloc_request(q, cmd, 0, NVME_QID_ANY);
 	if (IS_ERR(req))
@@ -409,8 +411,24 @@ int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
 
 	req->timeout = timeout ? timeout : ADMIN_TIMEOUT;
 
+	if (nvme_is_bidirection(cmd)) {
+		pages = alloc_pages(GFP_KERNEL, order);
+		if (!pages) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		md = &map_data;
+		md->pages = &pages;
+		md->page_order = order;
+		md->nr_entries = 1;
+		md->offset = 0;
+		md->null_mapped = 0;
+		md->from_user = 1;
+	}
+
 	if (ubuffer && bufflen) {
-		ret = blk_rq_map_user(q, req, NULL, ubuffer, bufflen,
+		ret = blk_rq_map_user(q, req, md, ubuffer, bufflen,
 				GFP_KERNEL);
 		if (ret)
 			goto out;
@@ -433,7 +451,7 @@ int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
 				goto out_unmap;
 			}
 
-			if (write) {
+			if (write || nvme_is_bidirection(cmd)) {
 				if (copy_from_user(meta, meta_buffer,
 						meta_len)) {
 					ret = -EFAULT;
@@ -476,6 +494,8 @@ int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
 		blk_rq_unmap_user(bio);
 	}
  out:
+	if (pages)
+		__free_pages(pages, order);
 	blk_mq_free_request(req);
 	return ret;
 }
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index f9c7644..4889fe1 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -247,7 +247,8 @@ static inline void nvmet_set_result(struct nvmet_req *req, u32 result)
 static inline enum dma_data_direction
 nvmet_data_dir(struct nvmet_req *req)
 {
-	return nvme_is_write(req->cmd) ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
+	return nvme_is_bidirection(req->cmd) ? DMA_BIDIRECTIONAL :
+		nvme_is_write(req->cmd) ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
 }
 
 struct nvmet_async_event {
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 005ef5d..7633ead 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -147,7 +147,8 @@ static inline u32 get_unaligned_le24(const u8 *p)
 
 static inline bool nvmet_rdma_need_data_in(struct nvmet_rdma_rsp *rsp)
 {
-	return nvme_is_write(rsp->req.cmd) &&
+	return (nvme_is_write(rsp->req.cmd) ||
+			nvme_is_bidirection(rsp->req.cmd)) &&
 		rsp->req.data_len &&
 		!(rsp->flags & NVMET_RDMA_REQ_INLINE_DATA);
 }
@@ -585,7 +586,7 @@ static u16 nvmet_rdma_map_sgl_inline(struct nvmet_rdma_rsp *rsp)
 	u64 off = le64_to_cpu(sgl->addr);
 	u32 len = le32_to_cpu(sgl->length);
 
-	if (!nvme_is_write(rsp->req.cmd))
+	if (!nvme_is_write(rsp->req.cmd) && !nvme_is_bidirection(rsp->req.cmd))
 		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 
 	if (off + len > NVMET_RDMA_INLINE_DATA_SIZE) {
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 5bf1d2d..ed1d147 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -885,16 +885,31 @@ struct nvme_command {
 	};
 };
 
+/*
+ * Bi-directional commands are treated like a read with the additional property
+ * that the user buffer is copied into the kernel buffers before the transfer.
+ */
 static inline bool nvme_is_write(struct nvme_command *cmd)
 {
+	u8 op = cmd->common.opcode;
+
 	/*
 	 * What a mess...
 	 *
 	 * Why can't we simply have a Fabrics In and Fabrics out command?
 	 */
-	if (unlikely(cmd->common.opcode == nvme_fabrics_command))
-		return cmd->fabrics.opcode & 1;
-	return cmd->common.opcode & 1;
+	if (unlikely(op == nvme_fabrics_command))
+		op = cmd->fabrics.opcode;
+	return (op & 3) == 1;
+}
+
+static inline bool nvme_is_bidirection(struct nvme_command *cmd)
+{
+	u8 op = cmd->common.opcode;
+
+	if (unlikely(op == nvme_fabrics_command))
+		op = cmd->fabrics.opcode;
+	return (op & 3) == 3;
 }
 
 enum {
-- 
2.5.5
