From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 25 Jul 2019 11:23:35 -0600
Subject: [PATCH v6 16/16] nvmet-passthru: support block accounting
In-Reply-To: <20190725172335.6825-1-logang@deltatee.com>
References: <20190725172335.6825-1-logang@deltatee.com>
Message-ID: <20190725172335.6825-17-logang@deltatee.com>

Support block disk accounting by setting the RQF_IO_STAT flag
and gendisk in the request.

After this change, IO counts will be reflected correctly in
/proc/diskstats for drives being used by passthru.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 drivers/nvme/target/io-cmd-passthru.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-passthru.c b/drivers/nvme/target/io-cmd-passthru.c
index aefdd534cb4a..0a3f1249341a 100644
--- a/drivers/nvme/target/io-cmd-passthru.c
+++ b/drivers/nvme/target/io-cmd-passthru.c
@@ -439,6 +439,9 @@ static struct request *nvmet_passthru_blk_make_request(struct nvmet_req *req,
 	if (unlikely(IS_ERR(rq)))
 		return rq;
 
+	if (blk_queue_io_stat(q) && cmd->common.opcode != nvme_cmd_flush)
+		rq->rq_flags |= RQF_IO_STAT;
+
 	if (req->sg_cnt) {
 		ret = nvmet_passthru_map_sg(req, rq);
 		if (unlikely(ret)) {
@@ -503,7 +506,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 
 	rq->end_io_data = req;
 	if (req->sq->qid != 0) {
-		blk_execute_rq_nowait(rq->q, NULL, rq, 0,
+		blk_execute_rq_nowait(rq->q, ns->disk, rq, 0,
 				      nvmet_passthru_req_done);
 	} else {
 		req->p.rq = rq;
-- 
2.20.1
