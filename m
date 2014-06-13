From: axboe@fb.com (Jens Axboe)
Date: Fri, 13 Jun 2014 15:28:58 -0600
Subject: [PATCH v7] NVMe: conversion to blk-mq
In-Reply-To: <alpine.LRH.2.03.1406131307330.4699@AMR>
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
 <alpine.LRH.2.03.1406131307330.4699@AMR>
Message-ID: <539B6D1A.3010602@fb.com>

On 06/13/2014 01:22 PM, Keith Busch wrote:
> One performance oddity we observe is that servicing the interrupt on the
> thread sibling of the core that submitted the I/O is the worst performing
> cpu you can chose; it's actually better to use a different core on the
> same node. At least that's true as long as you're not utilizing the cpus
> for other work, so YMMV.

This doesn't match what I see here. Just ran some test cases - both
sync, and higher QD. For sync performance, core or thread sibling is the
best choice, other CPUs next. That is pretty logical.

For a more loaded run, thread sibling ends up being a better choice than
core, since core runs out of steam (255K vs 275K here). And thread
sibling is still a marginally better choice than some other core on the
same node.

Which pretty much matches my expectations of what the best mappings
would be.
