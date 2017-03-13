From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 13 Mar 2017 23:46:02 +0200
Subject: NULL deref in cpu hot unplug on jens for-linus branch
In-Reply-To: <54f833f1-ab98-5d22-e7d4-5e6059a4c467@fb.com>
References: <a4e0cb7c-c779-b681-e66c-2159c5f2b09f@grimberg.me>
 <54f833f1-ab98-5d22-e7d4-5e6059a4c467@fb.com>
Message-ID: <f6f85d2f-ac94-874e-e247-ccf9ffbe4b9e@grimberg.me>


> Are you saying your code works on top of 4.11-rc2, but not on top of my
> for-linus?

I was actually on Linus 4.11-rc1 before I rebased on top of your
for-linus.

> That seems odd. Looking at the oops, you are crashing with
> !tags in __blk_mq_tag_idle. The below should work around it, but I'm
> puzzled why this is new.

I got it just once (out of a single run :)), but maybe it is
possible that its racy and not really new.

But another example where this can happen:
blk_mq_realloc_hw_ctxs explicitly checks on hctx->tags != NULL
but right after calls blk_mq_exit_hctx() which goes in the
same route, won't this happen there too? Or is it assumed that
hctx->state does not have BLK_MQ_S_TAG_ACTIVE on here?

> Is it related to the other path you fixed in this patch:
>
> commit 0067d4b020ea07a58540acb2c5fcd3364bf326e0
> Author: Sagi Grimberg <sagi at grimberg.me>
> Date:   Mon Mar 13 16:10:11 2017 +0200
>
>     blk-mq: Fix tagset reinit in the presence of cpu hot-unplug
>
> Since that's also handling hctx->tags == NULL.

The above patch prevented a NULL deref earlier when the
tags were reinitialized, now we are all setup and we
happen to remove an old namespace.

> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 9d97bfc4d465..1283f74bfdfb 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -54,9 +54,11 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
>  	if (!test_and_clear_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
>  		return;
>
> -	atomic_dec(&tags->active_queues);
> +	if (tags) {
> +		atomic_dec(&tags->active_queues);
>
> -	blk_mq_tag_wakeup_all(tags, false);
> +		blk_mq_tag_wakeup_all(tags, false);
> +	}
>  }
>
>  /*
>

I'll see if I can test it out later this week. thanks.
