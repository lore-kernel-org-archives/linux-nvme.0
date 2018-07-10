From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue, 10 Jul 2018 21:23:51 +0000
Subject: [PATCH for-4.18 1/2] nvmet: fix file discard return status
In-Reply-To: <20180710111702.12541-1-sagi@grimberg.me>
References: <20180710111702.12541-1-sagi@grimberg.me>
Message-ID: <BYAPR04MB4502CAAE428C7E06589E78B2865B0@BYAPR04MB4502.namprd04.prod.outlook.com>

Thanks for this fix, what do you think about the following diff on the
top of this patch which adds status variable instead of using ret
which has a different type than nvmet_req_complete 2nd argument?

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 67e3757504db..46f202b1e2b3 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -235,6 +235,7 @@ static void nvmet_file_execute_flush(struct nvmet_req *req)
 static void nvmet_file_execute_discard(struct nvmet_req *req)
 {
        int mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
+       u16 status = NVME_SC_SUCCESS;
        struct nvme_dsm_range range;
        loff_t offset;
        loff_t len;
@@ -243,18 +244,20 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
        for (i = 0; i <= le32_to_cpu(req->cmd->dsm.nr); i++) {
                ret = nvmet_copy_from_sgl(req, i * sizeof(range), &range,
                                sizeof(range));
-               if (ret)
+               if (ret) {
+                       status = NVME_SC_INTERNAL | NVME_SC_DNR;
                        break;
+               }
                offset = le64_to_cpu(range.slba) << req->ns->blksize_shift;
                len = le32_to_cpu(range.nlb) << req->ns->blksize_shift;
                ret = vfs_fallocate(req->ns->file, mode, offset, len);
                if (ret) {
-                       ret = NVME_SC_INTERNAL | NVME_SC_DNR;
+                       status = NVME_SC_INTERNAL | NVME_SC_DNR;
                        break;
                }
        }
 
-       nvmet_req_complete(req, ret);
+       nvmet_req_complete(req, status);
 }
 
 static void nvmet_file_dsm_work(struct work_struct *w)

Regards,
-Chaitanya

From: Linux-nvme <linux-nvme-bounces@lists.infradead.org> on behalf of Sagi Grimberg <sagi@grimberg.me>
Sent: Tuesday, July 10, 2018 4:17 AM
To: linux-nvme at lists.infradead.org
Cc: Christoph Hellwig
Subject: [PATCH for-4.18 1/2] nvmet: fix file discard return status
? 
 
If nvmet_copy_from_sgl failed, we falsly return successful
completion status.

Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
?drivers/nvme/target/io-cmd-file.c | 11 +++++++----
?1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 57c660e3245d..481840474314 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -232,17 +232,20 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
???????? int i, ret;
?
???????? for (i = 0; i <= le32_to_cpu(req->cmd->dsm.nr); i++) {
-?????????????? if (nvmet_copy_from_sgl(req, i * sizeof(range), &range,
-?????????????????????????????????????? sizeof(range)))
+?????????????? ret = nvmet_copy_from_sgl(req, i * sizeof(range), &range,
+?????????????????????????????????????? sizeof(range));
+?????????????? if (ret)
???????????????????????? break;
???????????????? offset = le64_to_cpu(range.slba) << req->ns->blksize_shift;
???????????????? len = le32_to_cpu(range.nlb) << req->ns->blksize_shift;
???????????????? ret = vfs_fallocate(req->ns->file, mode, offset, len);
-?????????????? if (ret)
+?????????????? if (ret) {
+?????????????????????? ret = NVME_SC_INTERNAL | NVME_SC_DNR;
???????????????????????? break;
+?????????????? }
???????? }
?
-?????? nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL | NVME_SC_DNR : 0);
+?????? nvmet_req_complete(req, ret);
?}
?
?static void nvmet_file_dsm_work(struct work_struct *w)
-- 
2.14.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
    
