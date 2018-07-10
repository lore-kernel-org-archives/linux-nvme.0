From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue, 10 Jul 2018 21:34:39 +0000
Subject: [PATCH for-4.18 2/2] nvmet: check fileio lba range access
 boundaries
In-Reply-To: <20180710111702.12541-2-sagi@grimberg.me>
References: <20180710111702.12541-1-sagi@grimberg.me>,
 <20180710111702.12541-2-sagi@grimberg.me>
Message-ID: <BYAPR04MB4502471F3BAA1FC8A1ECC8F5865B0@BYAPR04MB4502.namprd04.prod.outlook.com>

Thanks for providing the fix. We need to free the memory when the pos comparison
results true for out of bounds before calling the nvmet_req_complete() in
nvmet_file_execute_rw(), please have a look at the following diff on the top of this patch,
it frees the memory and adds the status variable instead of using the ret which has a
different type than nvmet_req_complete() 2nd argument.

Also, do you think we should check for the out of bounds position in the
submission thread context than the worker thread context when buffered I/O is
configured? i.e. before scheduling the work in the nvmet_file_execute_rw_buffered_io().
OR possibly move all the comparison check in when parsing the cmd for
rw/DSM/ write-zeroes?

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 38ab7e7fd205..050d0b6bea08 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -115,18 +115,22 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
        return ret;
 }
 
-static void nvmet_file_io_done(struct kiocb *iocb, long ret, long ret2)
+static void nvmet_file_req_complete(struct nvmet_req *req, u16 status)
 {
-       struct nvmet_req *req = container_of(iocb, struct nvmet_req, f.iocb);
-
        if (req->f.bvec != req->inline_bvec) {
                if (likely(req->f.mpool_alloc == false))
                        kfree(req->f.bvec);
                else
                        mempool_free(req->f.bvec, req->ns->bvec_pool);
        }
+       nvmet_req_complete(req, status);
+}
 
-       nvmet_req_complete(req, ret != req->data_len ?
+static void nvmet_file_io_done(struct kiocb *iocb, long ret, long ret2)
+{
+       struct nvmet_req *req = container_of(iocb, struct nvmet_req, f.iocb);
+
+       nvmet_file_req_complete(req, ret != req->data_len ?
                        NVME_SC_INTERNAL | NVME_SC_DNR : 0);
 }
 
@@ -163,7 +167,7 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
        pos = le64_to_cpu(req->cmd->rw.slba) << req->ns->blksize_shift;
 
        if (unlikely(pos + req->data_len > req->ns->size)) {
-               nvmet_req_complete(req, NVME_SC_LBA_RANGE | NVME_SC_DNR);
+               nvmet_file_req_complete(req, NVME_SC_LBA_RANGE | NVME_SC_DNR);
                return;
        }
 
@@ -241,6 +245,7 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
 {
        int mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
        struct nvme_dsm_range range;
+       u16 status = NVME_SC_SUCCESS;
        loff_t offset;
        loff_t len;
        int i, ret;
@@ -252,7 +257,7 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
                        break;
 
                if (offset + len > req->ns->size) {
-                       ret = NVME_SC_LBA_RANGE | NVME_SC_DNR;
+                       status = NVME_SC_LBA_RANGE | NVME_SC_DNR;
                        break;
                }
 
@@ -260,12 +265,12 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
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






From: Linux-nvme <linux-nvme-bounces@lists.infradead.org> on behalf of Sagi Grimberg <sagi@grimberg.me>
Sent: Tuesday, July 10, 2018 4:17 AM
To: linux-nvme at lists.infradead.org
Cc: Christoph Hellwig
Subject: [PATCH for-4.18 2/2] nvmet: check fileio lba range access boundaries
? 
 
Fail out-of-bounds read/write/dsm with a proper status code.

Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
?drivers/nvme/target/io-cmd-file.c | 15 +++++++++++++++
?1 file changed, 15 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 481840474314..82d0579cc7ca 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -161,6 +161,10 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
???????? }
?
???????? pos = le64_to_cpu(req->cmd->rw.slba) << req->ns->blksize_shift;
+?????? if (unlikely(pos + req->data_len > req->ns->size)) {
+?????????????? nvmet_req_complete(req, NVME_SC_LBA_RANGE | NVME_SC_DNR);
+?????????????? return;
+?????? }
?
???????? memset(&req->f.iocb, 0, sizeof(struct kiocb));
???????? for_each_sg_page(req->sg, &sg_pg_iter, req->sg_cnt, 0) {
@@ -236,6 +240,12 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
???????????????????????????????????????? sizeof(range));
???????????????? if (ret)
???????????????????????? break;
+
+?????????????? if (offset + len > req->ns->size) {
+?????????????????????? ret = NVME_SC_LBA_RANGE | NVME_SC_DNR;
+?????????????????????? break;
+?????????????? }
+
???????????????? offset = le64_to_cpu(range.slba) << req->ns->blksize_shift;
???????????????? len = le32_to_cpu(range.nlb) << req->ns->blksize_shift;
???????????????? ret = vfs_fallocate(req->ns->file, mode, offset, len);
@@ -284,6 +294,11 @@ static void nvmet_file_write_zeroes_work(struct work_struct *w)
???????? len = (((sector_t)le16_to_cpu(write_zeroes->length) + 1) <<
???????????????????????? req->ns->blksize_shift);
?
+?????? if (unlikely(offset + len > req->ns->size)) {
+?????????????? nvmet_req_complete(req, NVME_SC_LBA_RANGE | NVME_SC_DNR);
+?????????????? return;
+?????? }
+
???????? ret = vfs_fallocate(req->ns->file, mode, offset, len);
???????? nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL | NVME_SC_DNR : 0);
?}
-- 
2.14.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
    
