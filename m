From: tom.leiming@gmail.com (Ming Lei)
Date: Wed, 6 Jan 2016 14:29:16 +0800
Subject: [PATCH for-4.4] block: split bios to max possible length
In-Reply-To: <20160106055133.GA4868@localhost.localdomain>
References: <1451931895-17474-1-git-send-email-keith.busch@intel.com>
 <CACVXFVPOYra24SNmGBthcheYv_kY=5Fv-6s=-bSwwZijudXapw@mail.gmail.com>
 <20160105150938.GA20832@localhost.localdomain>
 <CACVXFVNQQNd8_3ti4AAhZB4KN0uJEN8sdmB+xsmpykJaCLfebA@mail.gmail.com>
 <20160106055133.GA4868@localhost.localdomain>
Message-ID: <CACVXFVNWTSD9Few9KLT6r+yvgynfMduAoLEbP0t3Yo=ye5UDHA@mail.gmail.com>

On Wed, Jan 6, 2016@1:51 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Wed, Jan 06, 2016@10:17:51AM +0800, Ming Lei wrote:
>> Firstly we didn't split one single bio vector before bio splitting.
>>
>> Secondly, current bio split still doesn't support to split one single
>> bvec into two, and it just makes the two bios shared the original
>> bvec table, please see bio_split(), which calls bio_clone_fast()
>> to do that, and the bvec table has been immutable at that time.
>
> You are saying we can't split a bio in the middle of a vector?

I mean the current block stack may not be ready for that.

> bvec_iter_advance() says we can split anywhere.

bvec_iter_advance() can split anywhere, but the splitted bios may
cross one same bvec, which may cause trouble, for example,
BIOVEC_PHYS_MERGEABLE() may not work well and
blk_phys_contig_segment() too.

Also not mention your patch doesn't update front_seg_size/back_seg_size/
seg_size correctly.

That is why I said we should be careful about splitting bvec because it
is never used or supported before.

>
>> I understand your motivation in the two patches, actually before bio splitting,
>> we don't do sg merge for nvme because of the flag of NO_SG_MERGE,
>> which is ignored after bio splitting is introduced. So could you check if
>> the nvme performance can be good by putting NO_SG_MERGE back
>> in blk_bio_segment_split()? And the change should be simple, like the
>> attached patch.
>
> The nvme driver is okay to take physically merged pages. It splits them
> into PRPs accordingly, and it's faster to DMA map physically contiguous
> just because there are fewer segments to iterate, so NVMe would prefer
> to let them coalesce.

If so, NO_SG_MERGE should be removed now.

>
>> IMO, splitting is quite cheap,
>
> Splitting is absolutely not cheap if your media is fast enough. I measure
> every % of increased CPU instructions as the same % decrease in IOPs
> with 3DXpoint.

Could you share your test case? Last time I use null_blk to observe
the performance difference between NO_SG_MERGE vs. non-NO_SG_MERGE,
and basically no difference is observed.

>
> But this patch was to split on stripe boundaries, which is an even worse
> penalty if we get the split wrong.
>
>> +     bool no_sg_merge = !!test_bit(QUEUE_FLAG_NO_SG_MERGE, &q->queue_flags);
>>
>>       bio_for_each_segment(bv, bio, iter) {
>> -             if (sectors + (bv.bv_len >> 9) > blk_max_size_offset(q, bio->bi_iter.bi_sector))
>> +             if (no_sg_merge)
>> +                     goto new_segment;
>
> Bad idea for NVMe. We need to split on SG gaps, which you've skipped,
> or you will BUG_ON in the NVMe driver.

I don't object to the idea of split on SG gap, and I mean we should make
sure the implementation is correct.

Thanks,
Ming Lei
