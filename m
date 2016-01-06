From: keith.busch@intel.com (Keith Busch)
Date: Wed, 6 Jan 2016 05:51:34 +0000
Subject: [PATCH for-4.4] block: split bios to max possible length
In-Reply-To: <CACVXFVNQQNd8_3ti4AAhZB4KN0uJEN8sdmB+xsmpykJaCLfebA@mail.gmail.com>
References: <1451931895-17474-1-git-send-email-keith.busch@intel.com>
 <CACVXFVPOYra24SNmGBthcheYv_kY=5Fv-6s=-bSwwZijudXapw@mail.gmail.com>
 <20160105150938.GA20832@localhost.localdomain>
 <CACVXFVNQQNd8_3ti4AAhZB4KN0uJEN8sdmB+xsmpykJaCLfebA@mail.gmail.com>
Message-ID: <20160106055133.GA4868@localhost.localdomain>

On Wed, Jan 06, 2016@10:17:51AM +0800, Ming Lei wrote:
> Firstly we didn't split one single bio vector before bio splitting.
>
> Secondly, current bio split still doesn't support to split one single
> bvec into two, and it just makes the two bios shared the original
> bvec table, please see bio_split(), which calls bio_clone_fast()
> to do that, and the bvec table has been immutable at that time.

You are saying we can't split a bio in the middle of a vector?
bvec_iter_advance() says we can split anywhere.
 
> I understand your motivation in the two patches, actually before bio splitting,
> we don't do sg merge for nvme because of the flag of NO_SG_MERGE,
> which is ignored after bio splitting is introduced. So could you check if
> the nvme performance can be good by putting NO_SG_MERGE back
> in blk_bio_segment_split()? And the change should be simple, like the
> attached patch.

The nvme driver is okay to take physically merged pages. It splits them
into PRPs accordingly, and it's faster to DMA map physically contiguous
just because there are fewer segments to iterate, so NVMe would prefer
to let them coalesce.
 
> IMO, splitting is quite cheap,

Splitting is absolutely not cheap if your media is fast enough. I measure
every % of increased CPU instructions as the same % decrease in IOPs
with 3DXpoint.

But this patch was to split on stripe boundaries, which is an even worse
penalty if we get the split wrong.

> +	bool no_sg_merge = !!test_bit(QUEUE_FLAG_NO_SG_MERGE, &q->queue_flags);
>  
>  	bio_for_each_segment(bv, bio, iter) {
> -		if (sectors + (bv.bv_len >> 9) > blk_max_size_offset(q, bio->bi_iter.bi_sector))
> +		if (no_sg_merge)
> +			goto new_segment;

Bad idea for NVMe. We need to split on SG gaps, which you've skipped,
or you will BUG_ON in the NVMe driver.
