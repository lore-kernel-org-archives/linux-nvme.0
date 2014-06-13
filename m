From: keith.busch@intel.com (Keith Busch)
Date: Fri, 13 Jun 2014 13:22:54 -0600 (MDT)
Subject: [PATCH v7] NVMe: conversion to blk-mq
In-Reply-To: <539B3F75.7040700@fb.com>
References: <1402392038-5268-2-git-send-email-m@bjorling.me>
 <alpine.LRH.2.03.1406100945250.4699@AMR>
 <A52B97CC-6D77-468B-9A9B-A5888AE63580@fb.com>
 <alpine.LRH.2.03.1406101140490.4699@AMR> <5397636F.9050209@fb.com>
 <alpine.LRH.2.03.1406101458470.4699@AMR>
 <5397753B.2020009@fb.com> <alpine.LRH.2.03.1406101515430.4699@AMR>
 <20140610213333.GA10055@linux.intel.com> <539889DC.7090704@fb.com>
 <20140611170917.GA12025@linux.intel.com>
 <CAOu_J6kocZZ1mRQeSidyqJ_Ew0F_POS30v2kgUZX2wDOOnuExg@mail.gmail.com>
 <alpine.LRH.2.03.1406111641180.4699@AMR> <5399BA00.7000705@bjorling.me>
 <alpine.LRH.2.03.1406121015130.4699@AMR>
 <alpine.LRH.2.03.1406121757130.4699@AMR> <539B05A1.7080700@fb.com>
 <alpine.LRH.2.03.1406130838210.4699@AMR> <539B14A9.8010204@fb.com>
 <alpine.LRH.2.03.1406130914110.4699@AMR> <539B3F75.7040700@fb.com>
Message-ID: <alpine.LRH.2.03.1406131307330.4699@AMR>

On Fri, 13 Jun 2014, Jens Axboe wrote:
> OK, same setup as mine. The affinity hint is really screwing us over, no
> question about it. We just need a:
>
> irq_set_affinity_hint(dev->entry[nvmeq->cq_vector].vector, hctx->cpumask);
>
> in the ->init_hctx() methods to fix that up.
>
> That brings us to roughly the same performance, except for the cases
> where the dd is run on the thread sibling of the core handling the
> interrupt. And granted, with the 16 queues used, that'll happen on
> blk-mq. But since you have 32 threads and just 31 IO queues, the non
> blk-mq driver must end up sharing for some cases, too.
>
> So what do we care most about here? Consistency, or using all queues at
> all costs?

I think we want to use all h/w queues regardless of mismatched sharing. A
24 thread server shouldn't use more of the hardware than a 32.

You're right, the current driver shares the queues on anything with 32
or more cpus with this NVMe controller, but we wrote an algorithm that
allocates the most and tries to group them with their nearest neighbors.

One performance oddity we observe is that servicing the interrupt on the
thread sibling of the core that submitted the I/O is the worst performing
cpu you can chose; it's actually better to use a different core on the
same node. At least that's true as long as you're not utilizing the cpus
for other work, so YMMV.
