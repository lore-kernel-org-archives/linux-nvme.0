From: keith.busch@intel.com (Keith Busch)
Date: Tue, 29 Aug 2017 15:43:23 -0400
Subject: [PATCH] nvme: Use metadata for passthrough commands
In-Reply-To: <20170829084350.GA10895@lst.de>
References: <1503957780-12905-1-git-send-email-keith.busch@intel.com>
 <20170829084350.GA10895@lst.de>
Message-ID: <20170829194323.GC4428@localhost.localdomain>

On Tue, Aug 29, 2017@10:43:50AM +0200, Christoph Hellwig wrote:
> On Mon, Aug 28, 2017@06:03:00PM -0400, Keith Busch wrote:
> > The ioctls' struct allows the user to provide a metadata address and
> > length for a passthrough command. This patch uses these values that were
> > previously ignored and deletes the now unused wrapper function.
> > 
> > Note the implementation currently requires a gendisk so will not work
> > for admin commands.
> 
> This looks generally ok.  I thought NVME_IOCTL_SUBMIT_IO was added because
> the other ioctls don't supported metadata, but history tells me it
> was the other way around, and NVME_IOCTL_SUBMIT_IO came before
> the other ioctls.

Yep, NVME_IOCTL_SUBMIT_IO was conceived when read/write/compare were the
only commands in the IO set. The structure is unusable for any other IO
commands, so we extended the admin passthrough only after it was too
late to undo SUBMIT_IO.
 
> But that begs the question: is it time to deprecate NVME_IOCTL_SUBMIT_IO
> slowly?  nvme-cli unfortunately still uses it for read/write/compare
> though.

I can certainly discourage new usage of SUBMIT_IO. I'll look into having
nvme-cli use the passthrough, but it'll break some usage for existing
kernels, so the transition may be slow.

> Do we need this sniplet from nvme_submit_io in nvme_user_cmd or
> nvme_submit_user_cmd as well:
> 
> 	if (ns->ext) {
> 		length += meta_len;
> 		meta_len = 0;
> 	} else if (meta_len) {
> 		if ((io.metadata & 3) || !io.metadata)
> 			return -EINVAL;
> 	}
> 
> ?

That shouldn't be necessary with passthrough ioctl since it takes transfer
lengths directly from the user. The SUBMIT_IO ioctl had to infer these based
on the LBA.


> Also last but not least I'd be tempted to say that the
> removal of __nvme_submit_user_cmd shold be a separate prep patch.

Sounds good, I'll resend with that split, along with your patch separating
metadata setup from the rest of the user command.

I also noticed we need to skip nvme_dif_remap for REQ_OP_DRV_IN/OUT
requests for this to really work. I'll add that to the series.
