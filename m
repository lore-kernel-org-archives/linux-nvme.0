From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 8 Feb 2018 18:03:33 +0200
Subject: [PATCH] blk: optimization for classic polling
In-Reply-To: <20180208152730.GA4906@localhost.localdomain>
References: <CGME20180208143655epcas1p444bf34705526b7839a5a135f82761aad@epcas1p4.samsung.com>
 <3578876466-3733-1-git-send-email-nj.shetty@samsung.com>
 <20180208152730.GA4906@localhost.localdomain>
Message-ID: <2fa9340f-302b-1531-d51b-d4bfbdf50f86@grimberg.me>


> I think it'd be simpler to have blk_poll set it back to running if
> need_resched is true rather than repeat this patter across all the
> callers:
> 
> ---
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index df93102e2149..40285fe1c8ad 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3164,6 +3164,7 @@ static bool __blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
>   		cpu_relax();
>   	}
>   
> +	set_current_state(TASK_RUNNING);
>   	return false;
>   }
>   
> --

Nice!
