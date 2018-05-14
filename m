From: hch@lst.de (Christoph Hellwig)
Date: Mon, 14 May 2018 09:56:42 +0200
Subject: [PATCH 07/11] nvmet: add a new nvmet_zero_sgl helper
In-Reply-To: <20180514075646.28823-1-hch@lst.de>
References: <20180514075646.28823-1-hch@lst.de>
Message-ID: <20180514075646.28823-8-hch@lst.de>

Zeroes the SGL in the payload.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/target/core.c  | 7 +++++++
 drivers/nvme/target/nvmet.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 505d4267b8f1..990dbbc074d5 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -57,6 +57,13 @@ u16 nvmet_copy_from_sgl(struct nvmet_req *req, off_t off, void *buf, size_t len)
 	return 0;
 }
 
+u16 nvmet_zero_sgl(struct nvmet_req *req, off_t off, size_t len)
+{
+	if (sg_zero_buffer(req->sg, req->sg_cnt, len, off) != len)
+		return NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR;
+	return 0;
+}
+
 static unsigned int nvmet_max_nsid(struct nvmet_subsys *subsys)
 {
 	struct nvmet_ns *ns;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 15fd84ab21f8..7a93b560a370 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -316,6 +316,7 @@ u16 nvmet_copy_to_sgl(struct nvmet_req *req, off_t off, const void *buf,
 		size_t len);
 u16 nvmet_copy_from_sgl(struct nvmet_req *req, off_t off, void *buf,
 		size_t len);
+u16 nvmet_zero_sgl(struct nvmet_req *req, off_t off, size_t len);
 
 u32 nvmet_get_log_page_len(struct nvme_command *cmd);
 
-- 
2.17.0
