From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 18 Apr 2018 15:00:00 -0400
Subject: [PATCH 09/20] nvmet: use workqueue for sync I/O
In-Reply-To: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
References: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180418190011.3973-10-chaitanya.kulkarni@wdc.com>

This patch allows NVMe read/write command to use sync or direct
I/O flags as it is configured from the configfs.

Here when ns->sync is set we use workqueue to execute
synchronous I/O operation in different thread context than
the submission thread.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/io-cmd.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index 7791a63e38ab..6d355b2dac56 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -108,7 +108,7 @@ static void nvmet_execute_rw_file(struct nvmet_req *req)
 	struct sg_mapping_iter miter;
 	loff_t pos;
 	ssize_t len = 0, ret;
-	int ki_flags = IOCB_DIRECT;
+	int ki_flags = req->ns->sync ? IOCB_SYNC : IOCB_DIRECT;
 	int bv_cnt = 0, rw = READ;
 
 	if (req->cmd->rw.opcode == nvme_cmd_write) {
@@ -155,6 +155,20 @@ static void nvmet_execute_rw_file(struct nvmet_req *req)
 	nvmet_req_complete(req, NVME_SC_INTERNAL | NVME_SC_DNR);
 }
 
+static void nvmet_sync_work_file(struct work_struct *work)
+{
+	struct nvmet_req *req;
+
+	req = container_of(work, struct nvmet_req, sync_work);
+
+	nvmet_execute_rw_file(req);
+}
+
+static void nvmet_execute_rw_sync_file(struct nvmet_req *req)
+{
+	queue_work(req->ns->file_wq, &req->sync_work);
+}
+
 static void nvmet_execute_flush(struct nvmet_req *req)
 {
 	struct bio *bio = &req->inline_bio;
@@ -333,9 +347,14 @@ u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 	switch (cmd->common.opcode) {
 	case nvme_cmd_read:
 	case nvme_cmd_write:
-		if (req->ns->filp)
-			req->execute = nvmet_execute_rw_file;
-		else
+		if (req->ns->filp) {
+			if (req->ns->sync) {
+				req->execute = nvmet_execute_rw_sync_file;
+				INIT_WORK(&req->sync_work,
+						nvmet_sync_work_file);
+			} else
+				req->execute = nvmet_execute_rw_file;
+		} else
 			req->execute = nvmet_execute_rw;
 		req->data_len = nvmet_rw_len(req);
 		return 0;
-- 
2.14.1
