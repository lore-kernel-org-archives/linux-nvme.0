From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Wed, 14 Sep 2016 12:02:22 +0200
Subject: [PATCH, RFC] nvme: Do not test the read-ahead flag in cmd_flags
Message-ID: <30c2c70d-ec2d-607b-3f2f-5b3daa1754cd@sandisk.com>

REQ_RAHEAD is a bio-only flag (bio.bi_opf) and hence is never set in
request.cmd_flags. Hence remove the cmd_flags & REQ_RAHEAD tests.
Compile-tested only.

Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Ming Lin <ming.l at ssi.samsung.com>
---
 drivers/nvme/host/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2feacc7..c920b5f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -285,12 +285,9 @@ static inline void nvme_setup_rw(struct nvme_ns *ns, struct request *req,
 
 	if (req->cmd_flags & REQ_FUA)
 		control |= NVME_RW_FUA;
-	if (req->cmd_flags & (REQ_FAILFAST_DEV | REQ_RAHEAD))
+	if (req->cmd_flags & REQ_FAILFAST_DEV)
 		control |= NVME_RW_LR;
 
-	if (req->cmd_flags & REQ_RAHEAD)
-		dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
-
 	memset(cmnd, 0, sizeof(*cmnd));
 	cmnd->rw.opcode = (rq_data_dir(req) ? nvme_cmd_write : nvme_cmd_read);
 	cmnd->rw.command_id = req->tag;
-- 
2.10.0
