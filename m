From: keith.busch@intel.com (Keith Busch)
Date: Wed, 8 Apr 2015 02:48:34 +0000 (UTC)
Subject: [RESEND PATCH] NVMe: Add translation for block limits
In-Reply-To: <yq1y4m3fmjj.fsf@sermon.lab.mkp.net>
References: <1428442458-3219-1-git-send-email-keith.busch@intel.com>
 <yq1y4m3fmjj.fsf@sermon.lab.mkp.net>
Message-ID: <alpine.LNX.2.00.1504080233400.32385@localhost.lm.intel.com>

On Tue, 7 Apr 2015, Martin K. Petersen wrote:
> +static int nvme_trans_bdev_limits_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
> +					u8 *inq_response, int alloc_len)
> +{
> +	__be32 max_sectors = cpu_to_be32(queue_max_hw_sectors(ns->queue));
>
> max_hw_sectors is in 512-byte units, the VPD page in logical blocks.

Yes, this one is screwed up. For shame, I'm quick to point out the same
mistake in other patches.

> +	__be32 max_discard = cpu_to_be32(ns->queue->limits.max_discard_sectors);
>
> Same.
>
> +	__be32 discard_desc_count = cpu_to_be32(0x100);
>
> max_discard_sectors is the maximum number of 512-byte contiguous blocks
> that can be discarded in a single command using however many range
> descriptors will fit in the command's payload.
>
> So max_discard_sectors for an NVMe device would technically be:
>
>   256 * 0xffffffff << (ilog2(ns block size) - 9)
>
> You only report 0xffffffff going the other way so it is not a big
> deal. Just wanted to make it clear since you're converting a value from
> Linux' block limit to NVMe/SCSI.

This I'm not sure about. There is no max discard size in NVMe, so any
non-zero value is valid, so the largest possible number is still valid
regardless of physical block size.

The 256 max descriptors is straight from the "spec" (if you can call it
that), but convienent because it fits in a 4k page.
