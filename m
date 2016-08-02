From: haggaie@mellanox.com (Haggai Eran)
Date: Tue, 2 Aug 2016 07:10:14 +0000
Subject: [RFC 7/7] NVMe: CMB on DMA-BUF
In-Reply-To: <20160801155206.GA23224@infradead.org>
References: <1470034653-9097-1-git-send-email-haggaie@mellanox.com>
 <1470034653-9097-8-git-send-email-haggaie@mellanox.com>
 <20160801155206.GA23224@infradead.org>
Message-ID: <1470121814.20129.8.camel@mellanox.com>

On ?', 2016-08-01@08:52 -0700, Christoph Hellwig wrote:
> On Mon, Aug 01, 2016@09:57:33AM +0300, Haggai Eran wrote:
> > 
> > Allocate a CMB region to user-space as a DMA-BUF object.
> NACK.??Absolutely no way we're going to export a low-level device
> specific feature to userspace like that.??If you want to DMA to
> the CMB do it from the kernel, and for that we'll need a proper
> block device level API.

The reason I thought this idea might work is because of the responses
Stephen got for his attempt to use ZONE_DEVICE for things like the CMB.
The problem with that is that the way RDMA registration works with
get_user_pages means that the CPU also gets access to the CMB and
sometimes you don't want that. DMA-BUF can solve that nicely in that it
doesn't require mapping it to the CPU - a driver can attach to it
directly.

Anyway, I understand exposing the CMB directly might be a little too
low level. What do you think would work better? Something like
direct_access that returns bus addresses instead of pfns?

Thanks,
Haggai
