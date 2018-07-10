From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 10 Jul 2018 14:17:01 +0300
Subject: [PATCH for-4.18 1/2] nvmet: fix file discard return status
Message-ID: <20180710111702.12541-1-sagi@grimberg.me>

If nvmet_copy_from_sgl failed, we falsly return successful
completion status.

Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/io-cmd-file.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 57c660e3245d..481840474314 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -232,17 +232,20 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
 	int i, ret;
 
 	for (i = 0; i <= le32_to_cpu(req->cmd->dsm.nr); i++) {
-		if (nvmet_copy_from_sgl(req, i * sizeof(range), &range,
-					sizeof(range)))
+		ret = nvmet_copy_from_sgl(req, i * sizeof(range), &range,
+					sizeof(range));
+		if (ret)
 			break;
 		offset = le64_to_cpu(range.slba) << req->ns->blksize_shift;
 		len = le32_to_cpu(range.nlb) << req->ns->blksize_shift;
 		ret = vfs_fallocate(req->ns->file, mode, offset, len);
-		if (ret)
+		if (ret) {
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
