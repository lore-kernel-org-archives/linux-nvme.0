From: keith.busch@linux.intel.com (Keith Busch)
Date: Thu, 19 Jul 2018 14:18:56 -0600
Subject: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
In-Reply-To: <20180719162924.GA23917@lst.de>
References: <20180718195650.GA20336@lst.de>
 <20180718205321.GA32160@localhost.localdomain>
 <c67f3da64914a436bc76f3ec0bc261ee6178cd14.camel@wdc.com>
 <20180718211711.GB32160@localhost.localdomain>
 <20180719131903.GB13129@lst.de>
 <20180719145931.GF32160@localhost.localdomain>
 <20180719155616.GG32160@localhost.localdomain>
 <7239f833438701fb6ce21d819bc7042af1bc1f8a.camel@wdc.com>
 <20180719162240.GH32160@localhost.localdomain>
 <20180719162924.GA23917@lst.de>
Message-ID: <20180719201856.GI32160@localhost.localdomain>

On Thu, Jul 19, 2018@06:29:24PM +0200, hch@lst.de wrote:
> How do we get a fix into 4.18 at this part of the cycle?  I think that
> is the most important prirority right now.

Even if you were okay at this point to incorporate the concepts from
Bart's patch, it still looks like trouble for scsi (will elobrate
separately).

But reverting breaks other things we finally got working, so I'd
still vote for isolating the old behavior to scsi if that isn't too
unpalatable. I'll send a small patch shortly and see what happens.
