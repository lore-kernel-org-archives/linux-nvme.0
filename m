From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 17 Nov 2016 11:28:07 -0800
Subject: [PATCH v1 0/7] SED OPAL Library
In-Reply-To: <20161117173613.GA13865@sbauer-Z170X-UD5>
References: <1479338252-8777-1-git-send-email-scott.bauer@intel.com>
 <20161117131251.GA15852@infradead.org>
 <20161117173613.GA13865@sbauer-Z170X-UD5>
Message-ID: <20161117192807.GA31515@infradead.org>

On Thu, Nov 17, 2016@10:36:14AM -0700, Scott Bauer wrote:
> 
> I want some further clarification, if you don't mind. We call sec_ops
> inside the actual logic for the opal code. Which is only accessible via the
> ioctls, is that what you were meaning?  When you say "the driver calls"
> do you mean that the nvme/sata/et al drivers would implement some generic
> block sed function that would be called via ioctl?
> So the call chain would be:
> 
> Userland
>  block/ioctl  ops->blkdev_sed()
> 
>   nvme/et al (implements blkdev_sed()) which calls:
> 
>    sed.c blkdev_sed_ioctl(with passed in combined fn to get data to controller)?
> 
> Is this what you were thinking, if so I agree it will alleviate a bunch of clutter
> in block/ioctl.c. If this isn't what you were thinking please let me know.

Similar, but not quite the same.  We already have an ioctl method in
struct block_device_operations, so in that we'd do something like
this for nvme:

	case IOC_SED_FOO:
	...
	case IOC_SED_BAR:
		return blkdev_sed_ioctl(bdev, mode, cmd, arg,
				ctrl, nvme_sec_submit);

Or maybe even shortcut the list of ioctl with something like this
before the main switch statement:

	if (is_sed_ioctl(cmd)) {
		return blkdev_sed_ioctl(bdev, mode, cmd, arg,
			ctrl, nvme_sec_submit);
	}

> >  - talking about lib/sed*.c - I'd move it to block/
> 
> I don't have any reservations about this but from a learning standpoint, why
>  block/ instead of lib/ ?

Because it's code related to block devices, and it looks like it's
tied pretty deeply into block device semantics.

> If we go with what I described above I'm not sure if we'll even need
> blkdev_sec_capable. If the driver(nvme/etc) implements blkdev_sed then we know it's
> capable?

Indeed, even better.
