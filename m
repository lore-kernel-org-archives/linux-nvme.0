From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Wed, 10 Apr 2019 23:48:59 +0900
Subject: [PATCH] nvme: rdma: Fix typo in struct comment
Message-ID: <20190410144859.25772-1-minwoo.im.dev@gmail.com>

struct nvme_rdma_cm_rej has two different attributes: recfmt and sts.
And sts will have value what this comment wanted to show.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 include/linux/nvme-rdma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nvme-rdma.h b/include/linux/nvme-rdma.h
index 3aa97b98dc89..3ec8e50efa16 100644
--- a/include/linux/nvme-rdma.h
+++ b/include/linux/nvme-rdma.h
@@ -77,7 +77,7 @@ struct nvme_rdma_cm_rep {
  * struct nvme_rdma_cm_rej - rdma connect reject
  *
  * @recfmt:        format of the RDMA Private Data
- * @fsts:          error status for the associated connect request
+ * @sts:           error status for the associated connect request
  */
 struct nvme_rdma_cm_rej {
 	__le16		recfmt;
-- 
2.17.1
