From: axboe@fb.com (Jens Axboe)
Date: Tue, 8 Mar 2016 10:40:46 -0700
Subject: [PATCH 1/2] Block: Disable polling stats when iostats are disabled
In-Reply-To: <1457458494-10550-2-git-send-email-jonathan.derrick@intel.com>
References: <1457458494-10550-1-git-send-email-jonathan.derrick@intel.com>
 <1457458494-10550-2-git-send-email-jonathan.derrick@intel.com>
Message-ID: <56DF0E9E.8030302@fb.com>

On 03/08/2016 10:34 AM, Jon Derrick wrote:
> Extends iostats to encompass polling statistics to save a few cycles
> when disabled.
>
> Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
> ---
>   block/blk-core.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index ab51685..354d03b 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -3350,13 +3350,16 @@ bool blk_poll(struct request_queue *q, blk_qc_t cookie)
>   	while (!need_resched()) {
>   		unsigned int queue_num = blk_qc_t_to_queue_num(cookie);
>   		struct blk_mq_hw_ctx *hctx = q->queue_hw_ctx[queue_num];
> +		int io_stat = blk_queue_io_stat(q);
>   		int ret;
>
> -		hctx->poll_invoked++;
> +		if (io_stat)
> +			hctx->poll_invoked++;
>
>   		ret = q->mq_ops->poll(hctx, blk_qc_t_to_tag(cookie));
>   		if (ret > 0) {
> -			hctx->poll_success++;
> +			if (io_stat)
> +				hctx->poll_success++;
>   			set_current_state(TASK_RUNNING);
>   			return true;
>   		}
>

Not sure this is a great idea. First of all, the poll stats are per 
hardware queue. How many submission queues and CPUs do you have in your 
setup? For most cases, I'd assume there'd be a 1:1 mapping between the 
two, which makes the stats essentially free. And secondly, even for a 
less optimal mapping, the poll stats are a lot cheaper than the io 
stats. So bundling them together might not make a ton of sense.

-- 
Jens Axboe
