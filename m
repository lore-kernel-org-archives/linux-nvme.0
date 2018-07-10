From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 10 Jul 2018 14:17:02 +0300
Subject: [PATCH for-4.18 2/2] nvmet: check fileio lba range access boundaries
In-Reply-To: <20180710111702.12541-1-sagi@grimberg.me>
References: <20180710111702.12541-1-sagi@grimberg.me>
Message-ID: <20180710111702.12541-2-sagi@grimberg.me>

Fail out-of-bounds read/write/dsm with a proper status code.

Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/io-cmd-file.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 481840474314..82d0579cc7ca 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -161,6 +161,10 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 	}
 
 	pos = le64_to_cpu(req->cmd->rw.slba) << req->ns->blksize_shift;
+	if (unlikely(pos + req->data_len > req->ns->size)) {
+		nvmet_req_complete(req, NVME_SC_LBA_RANGE | NVME_SC_DNR);
+		return;
+	}
 
 	memset(&req->f.iocb, 0, sizeof(struct kiocb));
 	for_each_sg_page(req->sg, &sg_pg_iter, req->sg_cnt, 0) {
@@ -236,6 +240,12 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
 					sizeof(range));
 		if (ret)
 			break;
+
+		if (offset + len > req->ns->size) {
+			ret = NVME_SC_LBA_RANGE | NVME_SC_DNR;
+			break;
+		}
+
 		offset = le64_to_cpu(range.slba) << req->ns->blksize_shift;
 		len = le32_to_cpu(range.nlb) << req->ns->blksize_shift;
 		ret = vfs_fallocate(req->ns->file, mode, offset, len);
@@ -284,6 +294,11 @@ static void nvmet_file_write_zeroes_work(struct work_struct *w)
 	len = (((sector_t)le16_to_cpu(write_zeroes->length) + 1) <<
 			req->ns->blksize_shift);
 
+	if (unlikely(offset + len > req->ns->size)) {
+		nvmet_req_complete(req, NVME_SC_LBA_RANGE | NVME_SC_DNR);
+		return;
+	}
+
 	ret = vfs_fallocate(req->ns->file, mode, offset, len);
 	nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL | NVME_SC_DNR : 0);
 }
-- 
2.14.1
