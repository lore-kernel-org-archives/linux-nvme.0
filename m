From: axboe@fb.com (Jens Axboe)
Date: Fri, 13 Jun 2014 14:56:23 -0600
Subject: [PATCH v7] NVMe: conversion to blk-mq
In-Reply-To: <539B5124.3090302@fb.com>
References: <1402392038-5268-2-git-send-email-m@bjorling.me>
 <alpine.LRH.2.03.1406100945250.4699@AMR>
 <A52B97CC-6D77-468B-9A9B-A5888AE63580@fb.com>
 <alpine.LRH.2.03.1406101140490.4699@AMR> <5397636F.9050209@fb.com>
 <alpine.LRH.2.03.1406101458470.4699@AMR> <5397753B.2020009@fb.com>
 <alpine.LRH.2.03.1406101515430.4699@AMR>
 <20140610213333.GA10055@linux.intel.com> <539889DC.7090704@fb.com>
 <20140611170917.GA12025@linux.intel.com>
 <CAOu_J6kocZZ1mRQeSidyqJ_Ew0F_POS30v2kgUZX2wDOOnuExg@mail.gmail.com>
 <alpine.LRH.2.03.1406111641180.4699@AMR> <5399BA00.7000705@bjorling.me>
 <alpine.LRH.2.03.1406121015130.4699@AMR>
 <alpine.LRH.2.03.1406121757130.4699@AMR> <539B05A1.7080700@fb.com>
 <alpine.LRH.2.03.1406130838210.4699@AMR> <539B14A9.8010204@fb.com>
 <alpine.LRH.2.03.1406130914110.4699@AMR> <539B3F75.7040700@fb.com>
 <alpine.LRH.2.03.1406131307330.4699@AMR> <539B5124.3090302@fb.com>
Message-ID: <539B6577.503@fb.com>

On 2014-06-13 13:29, Jens Axboe wrote:
> On 06/13/2014 01:22 PM, Keith Busch wrote:
>> On Fri, 13 Jun 2014, Jens Axboe wrote:
>>> OK, same setup as mine. The affinity hint is really screwing us over, no
>>> question about it. We just need a:
>>>
>>> irq_set_affinity_hint(dev->entry[nvmeq->cq_vector].vector,
>>> hctx->cpumask);
>>>
>>> in the ->init_hctx() methods to fix that up.
>>>
>>> That brings us to roughly the same performance, except for the cases
>>> where the dd is run on the thread sibling of the core handling the
>>> interrupt. And granted, with the 16 queues used, that'll happen on
>>> blk-mq. But since you have 32 threads and just 31 IO queues, the non
>>> blk-mq driver must end up sharing for some cases, too.
>>>
>>> So what do we care most about here? Consistency, or using all queues at
>>> all costs?
>>
>> I think we want to use all h/w queues regardless of mismatched sharing. A
>> 24 thread server shouldn't use more of the hardware than a 32.
>>
>> You're right, the current driver shares the queues on anything with 32
>> or more cpus with this NVMe controller, but we wrote an algorithm that
>> allocates the most and tries to group them with their nearest neighbors.
>>
>> One performance oddity we observe is that servicing the interrupt on the
>> thread sibling of the core that submitted the I/O is the worst performing
>> cpu you can chose; it's actually better to use a different core on the
>> same node. At least that's true as long as you're not utilizing the cpus
>> for other work, so YMMV.
>
> I played around with the mappings, and stumbled upon some pretty ugly
> results. The back story is that on this test box, I limit max C state to
> C1 to avoid having too much of a bad time with power management. Running
> the dd on a specific core, yields somewhere around 52MB/sec for me.
> That's with the right CPU affinity for the irq. If I purposely put it
> somewhere else, I end up at 380-390MB/sec. Or if I leave it on the right
> CPU but simply do:
>
> perf record -o /dev/null dd if= ...
>
> and run the same thing just traced, I get the high performance as well.
>
> Indeed... So I went to take a look at what is going on. For the slow
> case, turbostat tells me I'm spending 80% in C1. For the fast case,
> we're down to 20% in C1.
>
> I then turn off C1, but low and behold, it's still slow and sucky even
> if turbostat now verifies that it's spending 0% time in C1.
>
> Now, this smells like scheduling artifacts. I'm going to turn off all
> power junk and see what happens. Because at 8x differences between fast
> and slow, irq mappings don't really matter at all here. In fact it shows
> results contrary to what you'd like to see.

OK, so I think I know what is going on here. If we slow down the next 
issue just a little bit, the device will have cached the next read. 
Essentially getting some parallellism out of a sync read, since it is 
sequential. For random 4k reads, it behaves like expected.

For reference, the attached patch brings back the affinity to what we 
want it to be.

We can always diddle with the utilization of the number of hardware 
queues later, I don't see that as a huge issue at all.

-- 
Jens Axboe

-------------- next part --------------
A non-text attachment was scrubbed...
Name: nvme-affinity-hint.patch
Type: text/x-patch
Size: 1537 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20140613/80bec08c/attachment.bin>
