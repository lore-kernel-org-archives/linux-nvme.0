From: nj.shetty@samsung.com (Nitesh Shetty)
Date: Tue, 13 Feb 2018 21:18:12 +0530
Subject: [PATCH v3] blk: optimization for classic polling
In-Reply-To: <3578876466-3733-1-git-send-email-nj.shetty@samsung.com>
References: <3578876466-3733-1-git-send-email-nj.shetty@samsung.com>
 <CGME20180213154752epcas1p35e3c13d150d2108a06342781ec5e64d7@epcas1p3.samsung.com>
Message-ID: <1518536892-2051-1-git-send-email-nj.shetty@samsung.com>

This removes the dependency on interrupts to wake up task. Set task
state as TASK_RUNNING, if need_resched() returns true,
while polling for IO completion.
Earlier, polling task used to sleep, relying on interrupt to wake it up.
This made some IO take very long when interrupt-coalescing is enabled in
NVMe.

Reference:
http://lists.infradead.org/pipermail/linux-nvme/2018-February/015435.html

Changes since v2->v3:
	-using __set_current_state() instead of set_current_state()

Changes since v1->v2:
	-setting task state once in blk_poll, instead of multiple
callers.
Signed-off-by: Nitesh Shetty <nj.shetty at samsung.com>
---
 block/blk-mq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index df93102..3574927 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3164,6 +3164,7 @@ static bool __blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
 		cpu_relax();
 	}
 
+	__set_current_state(TASK_RUNNING);
 	return false;
 }
 
-- 
2.7.4
