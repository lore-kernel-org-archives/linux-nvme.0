From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 16 Jul 2019 20:58:28 +1000
Subject: [PATCH 2/3] nvme: Retrieve the required IO queue entry size
 from the controller
In-Reply-To: <20190716093301.GA32562@lst.de>
References: <20190716004649.17799-1-benh@kernel.crashing.org>
 <20190716004649.17799-2-benh@kernel.crashing.org>
 <20190716060430.GB29414@lst.de>
 <ad18ff8d004225e102076f8e1fb617916617f337.camel@kernel.crashing.org>
 <20190716093301.GA32562@lst.de>
Message-ID: <bfbc7352951d1adc714f699acb49e298c24fe7e3.camel@kernel.crashing.org>

On Tue, 2019-07-16@11:33 +0200, Christoph Hellwig wrote:
> > >    So back to the version
> > > you circulated to me in private mail that just sets q->sqes and has a
> > > comment that this is magic for The Apple controller.  If/when we get
> > > standardized large SQE support we'll need to discover that earlier or
> > > do a disable/enable dance.  Sorry for misleading you down this road and
> > > creating the extra work.  
> > 
> > I think it's still ok, let me know...
> 
> Ok, let's go with this series then unless the other maintainers have
> objections.
> 
> I'm still not sure if we want to queue this up for 5.3 (new hardware
> enablement) or wait a bit, though.

The main risk is if existing controllers return crap in SQES and we try
to then use that crap. The rest should essentially be NOPs.

Maybe I should add some kind of printk to warn in case we use/detect a
non-standard size. That would help diagnosing issues.

Cheers,
Ben.
