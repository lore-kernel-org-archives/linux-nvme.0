From: keith.busch@intel.com (Keith Busch)
Date: Wed, 6 Jan 2016 15:29:17 +0000
Subject: [PATCH for-4.4] block: split bios to max possible length
In-Reply-To: <CACVXFVNWTSD9Few9KLT6r+yvgynfMduAoLEbP0t3Yo=ye5UDHA@mail.gmail.com>
References: <1451931895-17474-1-git-send-email-keith.busch@intel.com>
 <CACVXFVPOYra24SNmGBthcheYv_kY=5Fv-6s=-bSwwZijudXapw@mail.gmail.com>
 <20160105150938.GA20832@localhost.localdomain>
 <CACVXFVNQQNd8_3ti4AAhZB4KN0uJEN8sdmB+xsmpykJaCLfebA@mail.gmail.com>
 <20160106055133.GA4868@localhost.localdomain>
 <CACVXFVNWTSD9Few9KLT6r+yvgynfMduAoLEbP0t3Yo=ye5UDHA@mail.gmail.com>
Message-ID: <20160106152917.GC15113@localhost.localdomain>

On Wed, Jan 06, 2016@02:29:16PM +0800, Ming Lei wrote:
> Also not mention your patch doesn't update front_seg_size/back_seg_size/
> seg_size correctly.
> 
> That is why I said we should be careful about splitting bvec because it
> is never used or supported before.

Ok, that's an easy fix, but it's not really a functional difference. The
request is not mergeable after this, which is the only use for back and
front seg sizes.

> > The nvme driver is okay to take physically merged pages. It splits them
> > into PRPs accordingly, and it's faster to DMA map physically contiguous
> > just because there are fewer segments to iterate, so NVMe would prefer
> > to let them coalesce.
> 
> If so, NO_SG_MERGE should be removed now.
 
Sounds good.

> Could you share your test case? Last time I use null_blk to observe
> the performance difference between NO_SG_MERGE vs. non-NO_SG_MERGE,
> and basically no difference is observed.

null_blk doesn't do anything, so it's probably difficult to measure
that. Use a driver that DMA maps the data, uses MMIO to submit to h/w
and takes an interrupt. You can measure all these when you create 50%
more commands than necessary with unneeded splits.
