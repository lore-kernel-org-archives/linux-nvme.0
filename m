From: keith.busch@intel.com (Keith Busch)
Date: Thu, 8 Feb 2018 08:27:30 -0700
Subject: [PATCH] blk: optimization for classic polling
In-Reply-To: <3578876466-3733-1-git-send-email-nj.shetty@samsung.com>
References: <CGME20180208143655epcas1p444bf34705526b7839a5a135f82761aad@epcas1p4.samsung.com>
 <3578876466-3733-1-git-send-email-nj.shetty@samsung.com>
Message-ID: <20180208152730.GA4906@localhost.localdomain>

On Sun, May 30, 2083@09:51:06AM +0530, Nitesh Shetty wrote:
> This removes the dependency on interrupts to wake up task. Set task
> state as TASK_RUNNING, if need_resched() returns true,
> while polling for IO completion.
> Earlier, polling task used to sleep, relying on interrupt to wake it up.
> This made some IO take very long when interrupt-coalescing is enabled in
> NVMe.
> 
> Reference:
> http://lists.infradead.org/pipermail/linux-nvme/2018-February/015435.html
> Signed-off-by: Nitesh Shetty <nj.shetty at samsung.com>
> ---
>  fs/block_dev.c | 16 ++++++++++++----
>  fs/direct-io.c |  8 ++++++--
>  fs/iomap.c     | 10 +++++++---
>  3 files changed, 25 insertions(+), 9 deletions(-)

I think it'd be simpler to have blk_poll set it back to running if
need_resched is true rather than repeat this patter across all the
callers:

---
diff --git a/block/blk-mq.c b/block/blk-mq.c
index df93102e2149..40285fe1c8ad 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3164,6 +3164,7 @@ static bool __blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
 		cpu_relax();
 	}
 
+	set_current_state(TASK_RUNNING);
 	return false;
 }
 
--
