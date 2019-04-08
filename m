From: kbusch@kernel.org (Keith Busch)
Date: Mon, 8 Apr 2019 09:36:27 -0600
Subject: [PATCH] blk-mq: Wait for for hctx requests on CPU unplug
In-Reply-To: <4a57f581-954d-b314-fd1d-6dd30640e0f5@oracle.com>
References: <20190405215920.27085-1-keith.busch@intel.com>
 <226503cd-53ac-902c-7944-b2748407b1d3@kernel.dk>
 <20190405223719.GC25081@localhost.localdomain>
 <d4a4b6c0-3ea8-f748-85b0-6b39c5023a6f@kernel.dk>
 <CAOSXXT7V3E2j_Ut=hJ2X3QcdLwuWGRFtgzTs4iTe+RDMeHg8nA@mail.gmail.com>
 <20190406212709.GA29871@ming.t460p>
 <4a57f581-954d-b314-fd1d-6dd30640e0f5@oracle.com>
Message-ID: <20190408153627.GF32498@localhost.localdomain>

On Sun, Apr 07, 2019@06:55:20AM -0700, Dongli Zhang wrote:
> [PATCH 1/1] blk-mq: do not splice ctx->rq_lists[type] to hctx->dispatch if ctx
> is not mapped to hctx
> 
> When a cpu is offline, blk_mq_hctx_notify_dead() is called once for each
> hctx for the offline cpu.
> 
> While blk_mq_hctx_notify_dead() is used to splice all ctx->rq_lists[type]
> to hctx->dispatch, it never checks whether the ctx is already mapped to the
> hctx.
> 
> For example, on a VM (with nvme) of 4 cpu, to offline cpu 2 out of the
> 4 cpu (0-3), blk_mq_hctx_notify_dead() is called once for each io queue
> hctx:
> 
> 1st: blk_mq_ctx->cpu = 2 for blk_mq_hw_ctx->queue_num = 3
> 2nd: blk_mq_ctx->cpu = 2 for blk_mq_hw_ctx->queue_num = 2
> 3rd: blk_mq_ctx->cpu = 2 for blk_mq_hw_ctx->queue_num = 1
> 4th: blk_mq_ctx->cpu = 2 for blk_mq_hw_ctx->queue_num = 0
> 
> Although blk_mq_ctx->cpu = 2 is only mapped to blk_mq_hw_ctx->queue_num = 2
> in this case, its ctx->rq_lists[type] will however be moved to
> blk_mq_hw_ctx->queue_num = 3 during the 1st call of
> blk_mq_hctx_notify_dead().
> 
> This patch would return and go ahead to next call of
> blk_mq_hctx_notify_dead() if ctx is not mapped to hctx.

Ha, I think you're right. 

It would be a bit more work, but it might be best if we could avoid
calling the notify for each hctx that doesn't apply to the CPU. We might
get that by registering a single callback for the request_queue and loop
only the affected hctx's.

But this patch looks good to me too.

Reviewed-by: Keith Busch <keith.busch at intel.com>
 
> Signed-off-by: Dongli Zhang <dongli.zhang at oracle.com>
> ---
>  block/blk-mq.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 3ff3d7b..b8ef489 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2212,6 +2212,10 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu,
> struct hlist_node *node)
>  	enum hctx_type type;
> 
>  	hctx = hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
> +
> +	if (!cpumask_test_cpu(cpu, hctx->cpumask))
> +		return 0;
> +
>  	ctx = __blk_mq_get_ctx(hctx->queue, cpu);
>  	type = hctx->type;
> 
> -- 
> 2.7.4
