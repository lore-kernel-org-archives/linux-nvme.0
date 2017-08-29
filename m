From: hch@lst.de (Christoph Hellwig)
Date: Tue, 29 Aug 2017 10:43:50 +0200
Subject: [PATCH] nvme: Use metadata for passthrough commands
In-Reply-To: <1503957780-12905-1-git-send-email-keith.busch@intel.com>
References: <1503957780-12905-1-git-send-email-keith.busch@intel.com>
Message-ID: <20170829084350.GA10895@lst.de>

On Mon, Aug 28, 2017@06:03:00PM -0400, Keith Busch wrote:
> The ioctls' struct allows the user to provide a metadata address and
> length for a passthrough command. This patch uses these values that were
> previously ignored and deletes the now unused wrapper function.
> 
> Note the implementation currently requires a gendisk so will not work
> for admin commands.

This looks generally ok.  I thought NVME_IOCTL_SUBMIT_IO was added because
the other ioctls don't supported metadata, but history tells me it
was the other way around, and NVME_IOCTL_SUBMIT_IO came before
the other ioctls.

But that begs the question: is it time to deprecate NVME_IOCTL_SUBMIT_IO
slowly?  nvme-cli unfortunately still uses it for read/write/compare
though.

Do we need this sniplet from nvme_submit_io in nvme_user_cmd or
nvme_submit_user_cmd as well:

	if (ns->ext) {
		length += meta_len;
		meta_len = 0;
	} else if (meta_len) {
		if ((io.metadata & 3) || !io.metadata)
			return -EINVAL;
	}

?

Also last but not least I'd be tempted to say that the
removal of __nvme_submit_user_cmd shold be a separate prep patch.
