From: nj.shetty@samsung.com (Nitesh Shetty)
Date: Wed, 14 Feb 2018 00:26:46 +0530
Subject: [PATCH v2 RESENT] blk: optimization for classic polling
In-Reply-To: <3578876466-3733-1-git-send-email-nj.shetty@samsung.com>
References: <3578876466-3733-1-git-send-email-nj.shetty@samsung.com>
 <CGME20180213082701epcas1p4d92a86f127a0918fb9d62120bd121cb6@epcas1p4.samsung.com>
Message-ID: <1518548206-4766-1-git-send-email-nj.shetty@samsung.com>

This removes the dependency on interrupts to wake up task. Set task
state as TASK_RUNNING, if need_resched() returns true,
while polling for IO completion.
Earlier, polling task used to sleep, relying on interrupt to wake it up.
This made some IO take very long when interrupt-coalescing is enabled in
NVMe.

Reference:
http://lists.infradead.org/pipermail/linux-nvme/2018-February/015435.html

Changes since v1:
	-setting task state once in blk_poll, instead of multiple
callers.
Signed-off-by: Nitesh Shetty <nj.shetty at samsung.com>
---
 block/blk-mq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index df93102..40285fe 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3164,6 +3164,7 @@ static bool __blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
 		cpu_relax();
 	}
 
+	set_current_state(TASK_RUNNING);
 	return false;
 }
 
-- 
2.7.4
