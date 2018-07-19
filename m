From: hch@lst.de (hch@lst.de)
Date: Thu, 19 Jul 2018 15:19:04 +0200
Subject: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
In-Reply-To: <20180718211711.GB32160@localhost.localdomain>
References: <7cad25b821c3a640e036f28ff1bbe51e7362d25d.camel@wdc.com>
 <20180713154346.GA18955@localhost.localdomain>
 <a32b251bd3c0a186e5c5ba82656a85fbdcc0c5e4.camel@wdc.com>
 <20180713184712.GA19419@localhost.localdomain>
 <291a13b35af1b65fbbe99a3a9cfc7d570a620cd9.camel@wdc.com>
 <20180713235807.GA19967@localhost.localdomain>
 <20180718195650.GA20336@lst.de>
 <20180718205321.GA32160@localhost.localdomain>
 <c67f3da64914a436bc76f3ec0bc261ee6178cd14.camel@wdc.com>
 <20180718211711.GB32160@localhost.localdomain>
Message-ID: <20180719131903.GB13129@lst.de>

On Wed, Jul 18, 2018@03:17:11PM -0600, Keith Busch wrote:
> And there may be other drivers that don't want their completions
> ignored, so breaking them again is also a step in the wrong direction.
> 
> There are not that many blk-mq drivers, so we can go through them all.

I think the point is that SCSI is the biggest user by both the number
of low-level drivers sitting under the midlayer, and also by usage.

We need to be very careful not to break it.  Note that this doesn't
mean that I don't want to eventually move away from just ignoring
completions in timeout state for SCSI.  I'd just rather rever 4.18
to a clean known state instead of doctoring around late in the rc
phase.

> Most don't even implement .timeout, so they never know that condition
> ever happened. Others always return BLK_EH_RESET_TIMER without doing
> anythign else, so the 'new' behavior would have to be better for those,
> too.

And we should never even hit the timeout handler for those as it
is rather pointless (although it looks we currently do..).
