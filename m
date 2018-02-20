From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 20 Feb 2018 14:21:37 +0100
Subject: [PATCH] blk: optimization for classic polling
In-Reply-To: <3578876466-3733-1-git-send-email-nj.shetty@samsung.com>
References: <CGME20180208143655epcas1p444bf34705526b7839a5a135f82761aad@epcas1p4.samsung.com>
 <3578876466-3733-1-git-send-email-nj.shetty@samsung.com>
Message-ID: <20180220132137.GG25314@hirez.programming.kicks-ass.net>

On Sun, May 30, 2083@09:51:06AM +0530, Nitesh Shetty wrote:
> This removes the dependency on interrupts to wake up task. Set task
> state as TASK_RUNNING, if need_resched() returns true,
> while polling for IO completion.
> Earlier, polling task used to sleep, relying on interrupt to wake it up.
> This made some IO take very long when interrupt-coalescing is enabled in
> NVMe.

This is a horrible Changelog.. it does not in fact explain why the patch
works or is correct.

Also, set_current_state(TASK_RUNNING) is dodgy (similarly in
__blk_mq_poll), why do you need that memory barrier?


> Signed-off-by: Nitesh Shetty <nj.shetty at samsung.com>
> ---
>  fs/block_dev.c | 16 ++++++++++++----
>  fs/direct-io.c |  8 ++++++--
>  fs/iomap.c     | 10 +++++++---
>  3 files changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 4a181fc..a87d8b7 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -236,9 +236,13 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
>  		set_current_state(TASK_UNINTERRUPTIBLE);
>  		if (!READ_ONCE(bio.bi_private))
>  			break;
> -		if (!(iocb->ki_flags & IOCB_HIPRI) ||
> -		    !blk_poll(bdev_get_queue(bdev), qc))
> +		if (!(iocb->ki_flags & IOCB_HIPRI))
>  			io_schedule();
> +		else if (!blk_poll(bdev_get_queue(bdev), qc)) {
> +			if (need_resched())
> +				set_current_state(TASK_RUNNING);
> +			io_schedule();
> +		}
>  	}
>  	__set_current_state(TASK_RUNNING);
>  
