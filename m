From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 04 Jun 2014 12:42:49 -0600
Subject: [PATCH v5] conversion to blk-mq
In-Reply-To: <alpine.LRH.2.03.1406041146280.11244@AMR>
References: <1401742510-10827-1-git-send-email-m@bjorling.me>
 <alpine.LRH.2.03.1406021642480.11244@AMR>
 <alpine.LRH.2.03.1406021702530.11244@AMR> <538E2C2E.1010500@bjorling.me>
 <alpine.LRH.2.03.1406031553280.11244@AMR>
 <alpine.LRH.2.03.1406031625120.11244@AMR> <538EE3E6.60408@bjorling.me>
 <alpine.LRH.2.03.1406041146280.11244@AMR>
Message-ID: <538F68A9.50608@kernel.dk>

On 06/04/2014 12:28 PM, Keith Busch wrote:
> On Wed, 4 Jun 2014, Matias Bj?rling wrote:
>> On 06/04/2014 12:27 AM, Keith Busch wrote:
>>>> On Tue, 3 Jun 2014, Matias Bjorling wrote:
>>>>>
>>>>> Keith, will you take the nvmemq_wip_v6 branch for a spin? Thanks!
>>>
>>> BTW, if you want to test this out yourself, it's pretty simple to
>>> recreate. I just run a simple user admin program sending nvme
>>> passthrough
>>> commands in a tight loop, then run:
>>>
>>>   # echo 1 > /sys/bus/pci/devices/<bdf>/remove
>>
>> I can't recreate- I use the nvme_get_feature program to continuously
>> hit the ioctl path, testing using your nvme qemu branch.
> 
> Okay, I'll try to fix it.
> 
> I think there are multiple problems, but the first is that since there
> is no gendisk associated with the admin_q, the QUEUE_FLAG_INIT_DONE flag
> is never set, and blk_mq_queue_enter returns successful whenever this
> flag is not set even though this queue is dying, so we enter with all
> its invalid pointers.
> 
> Here's a couple diff's. The first fixes the kernel oops by not entering a
> dying queue. The second is just a few unrelated clean-ups in nvme-core.c.
> 
> I still can't complete my current hot-removal test, though; something
> appears hung, but haven't nailed that down yet.
> 
> Please let me know what you think! Thanks.
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d10013b..5a9ae8a 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -105,6 +105,10 @@ static int blk_mq_queue_enter(struct request_queue *q)
>      __percpu_counter_add(&q->mq_usage_counter, 1, 1000000);
>      smp_wmb();
>      /* we have problems to freeze the queue if it's initializing */
> +    if (blk_queue_dying(q)) {
> +        __percpu_counter_add(&q->mq_usage_counter, -1, 1000000);
> +        ret = -ENODEV;
> +    }
>      if (!blk_queue_bypass(q) || !blk_queue_init_done(q))
>          return 0;

Are you testing against 3.13? You really need the current tree for this,
otherwise I'm sure you'll run into issues (as you appear to be :-)

-- 
Jens Axboe
