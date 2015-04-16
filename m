From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Thu, 16 Apr 2015 15:35:04 -0700
Subject: uapi/linux/nvme.h
In-Reply-To: <20150415142535.GA29983@infradead.org>
References: <20150415061142.GA14354@infradead.org>
 <alpine.LNX.2.00.1504151412380.32385@localhost.lm.intel.com>
 <20150415142535.GA29983@infradead.org>
Message-ID: <1429223704.2691.17.camel@jpfreyen-mobl5.amr.corp.intel.com>

On Wed, 2015-04-15@07:25 -0700, Christoph Hellwig wrote:
> On Wed, Apr 15, 2015@02:22:07PM +0000, Keith Busch wrote:
> > I'll stop adding new stuff here if the kernel driver isn't explicitly
> > using it, but should we remove everything it's not currently using?
> 
> In theory we should never break userspace, but given how relatively
> recent NVMe is we might try to get away with it (the rule is you can
> break userspace APIs if no one notices..).
> 

There is an NVMe test compliance suite developed at www.iol.unh.edu (U
of New Hampshire that has hosted NVMe plugfests), that will probably be
one of the first things to check to see if changes in here break.  I
have no experience with this test suite; I just know it exists.

> If people notice and complain we can set the current defs in stone
> under #ifndef __KERNEL__.
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
