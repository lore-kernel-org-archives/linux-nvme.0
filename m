From: axboe@fb.com (Jens Axboe)
Date: Fri, 13 Jun 2014 08:07:29 -0600
Subject: [PATCH v7] NVMe: conversion to blk-mq
In-Reply-To: <alpine.LRH.2.03.1406121757130.4699@AMR>
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
 <alpine.LRH.2.03.1406121757130.4699@AMR>
Message-ID: <539B05A1.7080700@fb.com>

On 06/12/2014 06:06 PM, Keith Busch wrote:
> When cancelling IOs, we have to check if the hwctx has a valid tags
> for some reason. I have 32 cores in my system and as many queues, but

It's because unused queues are torn down, to save memory.

> blk-mq is only using half of those queues and freed the "tags" for the
> rest after they'd been initialized without telling the driver. Why is
> blk-mq not making utilizing all my queues?

You have 31 + 1 queues, so only 31 mappable queues. blk-mq symmetrically
distributes these, so you should have a core + thread sibling on 16
queues. And yes, that leaves 15 idle hardware queues for this specific
case. I like the symmetry, it makes it more predictable if things are
spread out evenly.

But it is a policy decision that could be changed. The logic is in the
50 lines of code in block/blk-mq-cpumap.c:blk_mq_update_queue_map().

Thanks for the abort and completion fixes, looks a lot better now. It
might be cleaner to have blk_mq_tag_busy_iter() just work for
!hctx->tags, since this is actually the 2nd time I've run into this now.
