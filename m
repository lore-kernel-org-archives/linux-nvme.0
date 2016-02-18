From: keith.busch@intel.com (Keith Busch)
Date: Thu, 18 Feb 2016 16:26:14 +0000
Subject: [PATCH-4.5-v3 2/5] NVMe: Fix namespace removal deadlock
In-Reply-To: <20160218040956.GB12379@infradead.org>
References: <1455734215-20396-1-git-send-email-keith.busch@intel.com>
 <1455734215-20396-3-git-send-email-keith.busch@intel.com>
 <BJXPR01MB1997CEFCF124760350CFEEDE0AF0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
 <20160218040956.GB12379@infradead.org>
Message-ID: <20160218162613.GB4901@localhost.localdomain>

On Wed, Feb 17, 2016@08:09:56PM -0800, Christoph Hellwig wrote:
> On Thu, Feb 18, 2016@02:00:47AM +0000, Wenbo Wang wrote:
> > Without this mutex, is it safe to run concurrently with nvme_free_ns which manipulates the list?
> 
> see the first patch for an explanation on why this should be safe.

I think the potential problem Wenbo is talking about is if someone is
holding an open reference (mounted, for example) after detaching the
namespace.

Removing it from the list when all references are released keeps the list
consistent with the block layer so that attaching a different namespace
with the same NSID won't create a naming conflict. The newly attached
namespace isn't be usable in this case, though.

Instead of using NSID, I think the disk name should use an IDA like the
controller's instance. Then we can unlink the namespace from the list
when detached instead of with the last reference.

The downside is you can't infer the NSID from the name, but we have
NVME_IOCTL_ID and /sys/block/nvmeXnY/nsid for that.
