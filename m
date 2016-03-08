From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Tue, 8 Mar 2016 19:38:41 +0200
Subject: [PATCH 1/2] Block: Disable polling stats when iostats are disabled
In-Reply-To: <1457458494-10550-2-git-send-email-jonathan.derrick@intel.com>
References: <1457458494-10550-1-git-send-email-jonathan.derrick@intel.com>
 <1457458494-10550-2-git-send-email-jonathan.derrick@intel.com>
Message-ID: <56DF0E21.4000907@dev.mellanox.co.il>


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

I fail to see how replacing incrementation with a branch statement helps
performance or even not making it worse...
