From: haggaie@mellanox.com (Haggai Eran)
Date: Tue, 2 Aug 2016 06:48:36 +0000
Subject: [RFC 6/7] NVMe: Use genalloc to allocate CMB regions
In-Reply-To: <20160801155348.GB23224@infradead.org>
References: <1470034653-9097-1-git-send-email-haggaie@mellanox.com>
 <1470034653-9097-7-git-send-email-haggaie@mellanox.com>
 <20160801155348.GB23224@infradead.org>
Message-ID: <1470120518.20129.2.camel@mellanox.com>

On ?', 2016-08-01@08:53 -0700, Christoph Hellwig wrote:
> On Mon, Aug 01, 2016@09:57:32AM +0300, Haggai Eran wrote:
> > 
> > Register the CMB in a gen_pool dedicated to manage CMB regions. Use
> > the
> > pool to allocate the SQs to make sure they are registered.
> And why would the NVMe driver care if "they are registered"?
I just meant that they are allocated through genalloc so that it
doesn't allocate the same buffer again.

> 
> Once we start allowing diverse CMB uses (what happened to Jon's
> patches
> btw?) genalloc might be a good backend allocator, but without that
> it's entirely pointless.??
I missed Jon's patches. I'll have a look. The point in this patch was
to allow this diverse use in the next patch.

> Also please don't introduce useless header
> files.
Fair enough.

Thanks,
Haggai
