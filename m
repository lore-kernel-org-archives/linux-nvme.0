From: jitendra.bhivare@broadcom.com (Jitendra Bhivare)
Date: Thu, 14 Jun 2018 15:46:30 +0530
Subject: Read request exceeding max_hw_sectors_kb
In-Reply-To: <524089dd-7926-2a69-7d0d-bf6c496d9d98@intel.com>
References: <0ba3cccb9d2ee7cba50a91bfc92b373a@mail.gmail.com>
 <20180613114756.GA27631@lst.de>
 <524089dd-7926-2a69-7d0d-bf6c496d9d98@intel.com>
Message-ID: <bc2f3108b4e2572836ad9a038f4e2b12@mail.gmail.com>

> -----Original Message-----
> From: Daniel Verkamp [mailto:daniel.verkamp at intel.com]
> Sent: Wednesday, June 13, 2018 10:30 PM
> To: Christoph Hellwig <hch at lst.de>; Jitendra Bhivare
> <jitendra.bhivare at broadcom.com>
> Cc: linux-nvme at lists.infradead.org; Storage Performance Development Kit
> <spdk at lists.01.org>
> Subject: Re: Read request exceeding max_hw_sectors_kb
>
> On 06/13/2018 04:47 AM, Christoph Hellwig wrote:
> > On Wed, Jun 13, 2018@04:11:56PM +0530, Jitendra Bhivare wrote:
> >> So something like resolves the issue:
> >> static void nvme_set_chunk_size(struct nvme_ns *ns) {
> >> 	u32 chunk_size = (((u32)ns->noiob) << (ns->lba_shift - 9));
> >>
> >> 	chunk_size = rounddown_pow_of_two(chunk_size);
> >> 	chunk_size = min(ns->ctrl->max_hw_sectors, chunk_size);
> >> 	blk_queue_chunk_sectors(ns->queue,
> >> rounddown_pow_of_two(chunk_size));
> >> }
> >>
> >> Please do let me know if this is the right approach or SPDK should
> >> set noiob appropriately.
> >
> > I think the answer is both:  The kernel code should be more robust in
> > handling bogus noiob sizes, so please submit a patch per your above
> > analysis.  spdk should be fixed to not expose a bogus noiob size as
> > well.
>
> Hi Christoph,
>
> By my understanding, this is what the spec is trying to say about NOIOB
> (though
> unfortunately not very clearly): for best performance, read and write I/Os
> should
> not cross an LBA that is a multiple of NOIOB.  For example, if NOIOB is
> 64KB, an
> I/O of LBA=48KB size=32KB should be split into two smaller I/Os, LBA=48KB
> size=16KB and LBA=64KB size=16KB, since it crosses a 64KB LBA boundary.
>
> Based on the current wording in the spec, I don't believe there is any
> requirement that NOIOB be less than or equal to MDTS; it's purely about
> avoiding I/O overlapping any boundary where LBA = NOIOB * n.
>
> That said, we could consider some kind of workaround on the target side if
> this
> kernel host code is in wide use already, like clamping NOIOB to MDTS
> (accounting for unit conversion) or reporting NOIOB = 0 if NOIOB would be
> greater than MDTS.  I'd like to avoid this route if possible, though.
>
> Based on a quick glance at the kernel history, it looks like the host code
> has been
> using NOIOB since Linux 4.12 (commit 6b8190d61a622), so I'm surprised we
> haven't had more reports about this failing.  Did something change in the
> kernel
> block stack more recently than that to cause chunks larger than the
> maximum
> data transfer size, or has this always been an issue since the
> introduction of the
> NOIOB host code?
>
> Thanks,
> -- Daniel

Thanks Daniel, Christoph.

I agree with Daniel, MDTS being controller property might not be related to
NOIOB.
Need to fix this in initiator kernel.

This is happening only in readahead path issued by systemd-udevd only when
SPDK is configured with that MaxIOSize.

Regards,

JB
