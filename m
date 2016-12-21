From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 21 Dec 2016 01:37:46 -0800
Subject: [PATCH v3 4/5] nvme: Implement resume_from_suspend and SED
 Allocation code.
In-Reply-To: <20161220175239.GA2426@sbauer-Z170X-UD5>
References: <1482176149-2257-1-git-send-email-scott.bauer@intel.com>
 <1482176149-2257-5-git-send-email-scott.bauer@intel.com>
 <20161219215954.GB10634@localhost.localdomain>
 <20161219222311.GA2056@sbauer-Z170X-UD5>
 <20161220061744.GB4765@infradead.org>
 <20161220154916.GC10634@localhost.localdomain>
 <20161220154639.GA16393@infradead.org>
 <20161220175239.GA2426@sbauer-Z170X-UD5>
Message-ID: <20161221093746.GA32084@infradead.org>

On Tue, Dec 20, 2016@10:52:41AM -0700, Scott Bauer wrote:
> 2) Do we want to continue passing around a sed_context to the core?
> Instead of a block_device struct like we did in previous versions.

My personal preference would be the block_device, but in this case my
preference collides with the (sad) reality, and that reality is that TCG
did a major, major fuckup in specifyiong the NVMe interaction in the
SIIG and does not treat TPer as per-Namespaces, as it does in SCSI for
LUNs.  So in NVMe all the interactions are on a per-controller level,
not per namespaces.  And the block_device maps to the namespacespace in
NVMe.  So I fear we'll have to keep the sed_context.

>  2a) If we do wish to do wish to continue passng sed_contexts to the core I
>  have to add a new variable to the block_device structure for our sed_context.
>  Will this be acceptable?

We have a lot less block_device structures, and they are limited to
block devices, so I think it should be acceptable.

>  It wasn't acceptable for the file struct. The reason
>  I need a new variable in the struct is:
>  On the ioctl path, if we intercept the SED call in the block layer ioctl and
>  have the call chain be:
>  uland -> blk_ioctl -> sed_ioctl() -> sedcore -> sec_send/recv -> nvme

But I really don't think we strictly need it for this reason.  The above
callchain should be:

	userland -> blk_ioctl -> nvme_ioctl -> sed_opal_iocl

This allows passing the sec context including the submission method
to sed_opal_ioctl from the driver and should not require anything
in the block device.

>  then I need to be able to pass a sed_ctx struct in blk_ioctl to sed-ioctl and
>  the only  way is to have it sitting in our block_device structure.
> 
>  The other way which was sorta nack'd last time is the following call chain:
>  uland -> blk_ioctl -> nvme_ioctl -> sed_ioctl -> sedcore -> send/rcv -> nvme

Why was this nacked?  This is still my preference, except that it could
still be simplified a bit per the other comments, e.g. I don't think
we really need a sec_core.

>  In this call chain in nvme_ioctl we have access to our block device struct
>  and from there we can do blkdev->bd_disk->private_data to get our ns and then
>  eventually our sed_ctx to pass to sed_ioctl. I could add the ns to the sec_data
>  pointer in sed_context. This would give us access to ns without having to pass
>  around a block device or store it anywhere.

> 3) For NVMe we need access to our ns ID. It's in the block_device behind a few
> pointers. What I can do is if we want to continue with the first ioctl path
> described above is something like:

The think is the ns does not matter for the OPAL device.  I suspect
the right answer is to pass 0xffffffff as the nsid.  I need to verify
this with some devices I should have access to, and you should verity
it with Intel.  I've also kicked a mail to some people involved with TCG
to see if we can get some agreement on this behavior.  If we can't get
agreement on that we'll just need to have a variable in the nvme_ctrl
that stores some valid nsid just for security send/receive.

> While this works for NVMe I don't know if this is acceptible for *all* users.

The other users are SCSI, ATA and eMMC.

For SCSI the scsi_device is per-lun, and the SIIS specifies that all
TPers are per-lun, so we'll simply have a context per scsi_device,
otherwise it should work the same as NVMe.  ATA doesn't support LUNs
(except for ATAPI, which is SCSI over ATA), so it's even simpler.
Additionally Linux hides ATA behind the SCSI layer, so the only thing
we'll need to implement is the translation between the two.  I don't
really know enough about eMMC to comment on it.
