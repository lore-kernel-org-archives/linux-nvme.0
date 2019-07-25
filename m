From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 25 Jul 2019 11:23:34 -0600
Subject: [PATCH v6 15/16] block: call blk_account_io_start() in
 blk_execute_rq_nowait()
In-Reply-To: <20190725172335.6825-1-logang@deltatee.com>
References: <20190725172335.6825-1-logang@deltatee.com>
Message-ID: <20190725172335.6825-16-logang@deltatee.com>

All existing users of blk_execute_rq[_nowait]() are for passthrough
commands and will thus be rejected by blk_do_io_stat().

This allows passthrough requests to opt-in to IO accounting by setting
RQF_IO_STAT.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 block/blk-exec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-exec.c b/block/blk-exec.c
index 1db44ca0f4a6..e20a852ae432 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -55,6 +55,8 @@ void blk_execute_rq_nowait(struct request_queue *q, struct gendisk *bd_disk,
 	rq->rq_disk = bd_disk;
 	rq->end_io = done;
 
+	blk_account_io_start(rq, true);
+
 	/*
 	 * don't check dying flag for MQ because the request won't
 	 * be reused after dying flag is set
-- 
2.20.1
