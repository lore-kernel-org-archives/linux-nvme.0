From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 16 Jul 2019 22:17:56 +1000
Subject: [PATCH 2/3] nvme: Retrieve the required IO queue entry size
 from the controller
In-Reply-To: <20190716120547.GA2388@lst.de>
References: <20190716004649.17799-1-benh@kernel.crashing.org>
 <20190716004649.17799-2-benh@kernel.crashing.org>
 <20190716060430.GB29414@lst.de>
 <ad18ff8d004225e102076f8e1fb617916617f337.camel@kernel.crashing.org>
 <20190716093301.GA32562@lst.de>
 <bfbc7352951d1adc714f699acb49e298c24fe7e3.camel@kernel.crashing.org>
 <20190716120547.GA2388@lst.de>
Message-ID: <cca6fd560aa1688ca94fc270310a91ccda9aed06.camel@kernel.crashing.org>

On Tue, 2019-07-16@14:05 +0200, Christoph Hellwig wrote:
> On Tue, Jul 16, 2019@08:58:28PM +1000, Benjamin Herrenschmidt wrote:
> > The main risk is if existing controllers return crap in SQES and we try
> > to then use that crap. The rest should essentially be NOPs.
> > 
> > Maybe I should add some kind of printk to warn in case we use/detect a
> > non-standard size. That would help diagnosing issues.
> 
> Given that the spec currently requires bits 0 to 3 of SQES to be 6
> we might as well not check SQES and just hardcode it to 6 or 7 depending
> on the quirk.  That actually was my initial idea, I just suggested using
> the SQES naming and indexing.

If we're going to do that, then I can move it back to pci.c and leave
core.c alone then I suppose. Up to you. I'm just doing that for fun, no
beef in that game :-) let me know how you want it.

Cheers,
Ben.
