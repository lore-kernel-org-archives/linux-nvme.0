From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue, 26 Jun 2018 18:17:16 -0400
Subject: [PATCH V4 1/2] nvmet: move struct work_struct out of union
In-Reply-To: <20180626221717.19992-1-chaitanya.kulkarni@wdc.com>
References: <20180626221717.19992-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180626221717.19992-2-chaitanya.kulkarni@wdc.com>

This is a preparation patch which moves the struct work_struct
the parameter out of the anonymous union present in the request
structure so that it can be used to submit the generic work.

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/io-cmd-file.c | 24 ++++++++++++------------
 drivers/nvme/target/nvmet.h       |  2 +-
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 16502018fbfd..4e6e6c255a58 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -207,20 +207,20 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 
 static void nvmet_file_buffered_io_work(struct work_struct *w)
 {
-	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
+	struct nvmet_req *req = container_of(w, struct nvmet_req, work);
 
 	nvmet_file_execute_rw(req);
 }
 
 static void nvmet_file_execute_rw_buffered_io(struct nvmet_req *req)
 {
-	INIT_WORK(&req->f.work, nvmet_file_buffered_io_work);
-	queue_work(req->ns->file_wq, &req->f.work);
+	INIT_WORK(&req->work, nvmet_file_buffered_io_work);
+	queue_work(req->ns->file_wq, &req->work);
 }
 
 static void nvmet_file_flush_work(struct work_struct *w)
 {
-	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
+	struct nvmet_req *req = container_of(w, struct nvmet_req, work);
 	int ret;
 
 	ret = vfs_fsync(req->ns->file, 1);
@@ -230,8 +230,8 @@ static void nvmet_file_flush_work(struct work_struct *w)
 
 static void nvmet_file_execute_flush(struct nvmet_req *req)
 {
-	INIT_WORK(&req->f.work, nvmet_file_flush_work);
-	schedule_work(&req->f.work);
+	INIT_WORK(&req->work, nvmet_file_flush_work);
+	schedule_work(&req->work);
 }
 
 static void nvmet_file_execute_discard(struct nvmet_req *req)
@@ -258,7 +258,7 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
 
 static void nvmet_file_dsm_work(struct work_struct *w)
 {
-	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
+	struct nvmet_req *req = container_of(w, struct nvmet_req, work);
 
 	switch (le32_to_cpu(req->cmd->dsm.attributes)) {
 	case NVME_DSMGMT_AD:
@@ -275,13 +275,13 @@ static void nvmet_file_dsm_work(struct work_struct *w)
 
 static void nvmet_file_execute_dsm(struct nvmet_req *req)
 {
-	INIT_WORK(&req->f.work, nvmet_file_dsm_work);
-	schedule_work(&req->f.work);
+	INIT_WORK(&req->work, nvmet_file_dsm_work);
+	schedule_work(&req->work);
 }
 
 static void nvmet_file_write_zeroes_work(struct work_struct *w)
 {
-	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
+	struct nvmet_req *req = container_of(w, struct nvmet_req, work);
 	struct nvme_write_zeroes_cmd *write_zeroes = &req->cmd->write_zeroes;
 	int mode = FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE;
 	loff_t offset;
@@ -298,8 +298,8 @@ static void nvmet_file_write_zeroes_work(struct work_struct *w)
 
 static void nvmet_file_execute_write_zeroes(struct nvmet_req *req)
 {
-	INIT_WORK(&req->f.work, nvmet_file_write_zeroes_work);
-	schedule_work(&req->f.work);
+	INIT_WORK(&req->work, nvmet_file_write_zeroes_work);
+	schedule_work(&req->work);
 }
 
 u16 nvmet_file_parse_io_cmd(struct nvmet_req *req)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index c4aa54d933f1..b1cd8eb6717f 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -256,9 +256,9 @@ struct nvmet_req {
 			bool			mpool_alloc;
 			struct kiocb            iocb;
 			struct bio_vec          *bvec;
-			struct work_struct      work;
 		} f;
 	};
+	struct work_struct      work;
 	int			sg_cnt;
 	/* data length as parsed from the command: */
 	size_t			data_len;
-- 
2.17.0
