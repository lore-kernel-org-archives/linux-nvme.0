From: hch@lst.de (Christoph Hellwig)
Date: Thu,  1 Jun 2017 13:27:26 +0200
Subject: [PATCH 1/4] nvme.h: add struct nvme_host_mem_buf_desc and HMB flags
In-Reply-To: <20170601112729.9726-1-hch@lst.de>
References: <20170601112729.9726-1-hch@lst.de>
Message-ID: <20170601112729.9726-2-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
---
 include/linux/nvme.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b625bacf37ef..9fd77fde4ae0 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -586,6 +586,11 @@ struct nvme_feat_auto_pst {
 	__le64 entries[32];
 };
 
+enum {
+	NVME_HOST_MEM_ENABLE	= (1 << 0),
+	NVME_HOST_MEM_RETURN	= (1 << 1),
+};
+
 /* Admin commands */
 
 enum nvme_admin_opcode {
@@ -670,6 +675,12 @@ struct nvme_features {
 	__u32			rsvd12[4];
 };
 
+struct nvme_host_mem_buf_desc {
+	__le64			addr;
+	__le32			size;
+	__u32			rsvd;
+};
+
 struct nvme_create_cq {
 	__u8			opcode;
 	__u8			flags;
-- 
2.11.0
