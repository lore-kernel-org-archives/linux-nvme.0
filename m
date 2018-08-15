From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 15 Aug 2018 15:58:54 -0400
Subject: [PATCH V4 9/9] nvmet: add request polling support
In-Reply-To: <20180815195854.15449-1-chaitanya.kulkarni@wdc.com>
References: <20180815195854.15449-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180815195854.15449-10-chaitanya.kulkarni@wdc.com>

Use request based polling for NVMeOF target passthru I/O submission.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/pt-cmd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/pt-cmd.c b/drivers/nvme/target/pt-cmd.c
index 851e3ee63ac6..6a7f46918103 100644
--- a/drivers/nvme/target/pt-cmd.c
+++ b/drivers/nvme/target/pt-cmd.c
@@ -306,8 +306,10 @@ static void nvmet_pt_execute_pt(struct nvmet_req *req)
 		goto fail_free_bio;
 
 	rq->end_io_data = req;
-	if (likely(req->sq->qid != 0))
+	if (likely(req->sq->qid != 0)) {
 		blk_execute_rq_nowait(rq->q, NULL, rq, 0, nvmet_pt_req_done);
+		blk_poll(rq->q, blk_mq_req_cookie(rq));
+	}
 	else
 		nvmet_pt_execute_admin_cmd(req, rq);
 	return;
-- 
2.14.1
