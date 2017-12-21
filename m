From: sbauer@eng.utah.edu (Scott Bauer)
Date: Thu, 21 Dec 2017 13:56:34 -0700
Subject: [PATCH 3/3] block: Polling completion performance optimization
In-Reply-To: <20171221204636.2924-4-keith.busch@intel.com>
References: <20171221204636.2924-1-keith.busch@intel.com>
 <20171221204636.2924-4-keith.busch@intel.com>
Message-ID: <40f03ddc-1f7e-8221-ccb0-d8d311d02870@eng.utah.edu>



On 12/21/2017 01:46 PM, Keith Busch wrote:
> When a request completion is polled, the completion task wakes itself
> up. This is unnecessary, as the task can just set itself back to
> running.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  fs/block_dev.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 4a181fcb5175..ce67ffe73430 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -181,7 +181,10 @@ static void blkdev_bio_end_io_simple(struct bio *bio)
>  	struct task_struct *waiter = bio->bi_private;
>  
>  	WRITE_ONCE(bio->bi_private, NULL);
> -	wake_up_process(waiter);
> +	if (current != waiter)
> +		wake_up_process(waiter);
> +	else
> +		__set_current_state(TASK_RUNNING);

Do we actually need to set this to TASK_RUNNING? If we get here we're already running, right?

Everywhere I see uses of __set_current_state(TASK_RUNNING) it's after we've done a set_current_state(TASK_INTERRUPTIBLE).
