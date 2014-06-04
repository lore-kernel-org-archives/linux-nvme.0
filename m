From: m@bjorling.me (Matias Bjorling)
Date: Wed, 04 Jun 2014 22:01:09 +0200
Subject: [PATCH v5] conversion to blk-mq
In-Reply-To: <alpine.LRH.2.03.1406041246300.11244@AMR>
References: <1401742510-10827-1-git-send-email-m@bjorling.me>
 <alpine.LRH.2.03.1406021642480.11244@AMR>
 <alpine.LRH.2.03.1406021702530.11244@AMR> <538E2C2E.1010500@bjorling.me>
 <alpine.LRH.2.03.1406031553280.11244@AMR>
 <alpine.LRH.2.03.1406031625120.11244@AMR> <538EE3E6.60408@bjorling.me>
 <alpine.LRH.2.03.1406041146280.11244@AMR> <538F68A9.50608@kernel.dk>
 <alpine.LRH.2.03.1406041246300.11244@AMR>
Message-ID: <538F7B05.70705@bjorling.me>

On 06/04/2014 08:52 PM, Keith Busch wrote:
> On Wed, 4 Jun 2014, Jens Axboe wrote:
>> On 06/04/2014 12:28 PM, Keith Busch wrote:
>> Are you testing against 3.13? You really need the current tree for this,
>> otherwise I'm sure you'll run into issues (as you appear to be :-)
> 
> I'm using Matias' current tree:
> 
> git://github.com/MatiasBjorling/linux-collab nvmeq_wip_6
> 
> Is this the right one to use? Looks like a 3.15rc1+.
> 
> Also ... obviously that's the wrong diff from before. I didn't save my
> file before creating the diff. Should have looked like this:
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d10013b..d1b986c 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -105,7 +105,8 @@ static int blk_mq_queue_enter(struct request_queue *q)
>      __percpu_counter_add(&q->mq_usage_counter, 1, 1000000);
>      smp_wmb();
>      /* we have problems to freeze the queue if it's initializing */
> -    if (!blk_queue_bypass(q) || !blk_queue_init_done(q))
> +    if (!blk_queue_dying(q) && (!blk_queue_bypass(q) ||
> +                    !blk_queue_init_done(q)))
>          return 0;
> 
>      __percpu_counter_add(&q->mq_usage_counter, -1, 1000000);

Thanks!

I've put your patch into the nvmemq_wip_v6 branch and rebased it on top
of Jens' for-linus.
