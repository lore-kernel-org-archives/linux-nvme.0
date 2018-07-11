From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 11 Jul 2018 12:43:16 +0300
Subject: [PATCH v2 for-4.18 1/2] nvmet: fix file discard return status
Message-ID: <20180711094317.23582-1-sagi@grimberg.me>

If nvmet_copy_from_sgl failed, we falsly return successful
completion status.

Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
Changes from v1:
- make ret type u16

 drivers/nvme/target/io-cmd-file.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 57c660e3245d..dad8d44bf90e 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -227,22 +227,24 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
 {
 	int mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
 	struct nvme_dsm_range range;
-	loff_t offset;
-	loff_t len;
-	int i, ret;
+	loff_t offset, len;
+	u16 ret;
+	int i;
 
 	for (i = 0; i <= le32_to_cpu(req->cmd->dsm.nr); i++) {
-		if (nvmet_copy_from_sgl(req, i * sizeof(range), &range,
-					sizeof(range)))
+		ret = nvmet_copy_from_sgl(req, i * sizeof(range), &range,
+					sizeof(range));
+		if (ret)
 			break;
 		offset = le64_to_cpu(range.slba) << req->ns->blksize_shift;
 		len = le32_to_cpu(range.nlb) << req->ns->blksize_shift;
-		ret = vfs_fallocate(req->ns->file, mode, offset, len);
-		if (ret)
+		if (vfs_fallocate(req->ns->file, mode, offset, len)) {
+			ret = NVME_SC_INTERNAL | NVME_SC_DNR;
 			break;
+		}
 	}
 
-	nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL | NVME_SC_DNR : 0);
+	nvmet_req_complete(req, ret);
 }
 
 static void nvmet_file_dsm_work(struct work_struct *w)
-- 
2.14.1
