From: scott.bauer@intel.com (Scott Bauer)
Date: Thu, 17 Nov 2016 12:33:23 -0700
Subject: [PATCH v1 0/7] SED OPAL Library
In-Reply-To: <20161117192807.GA31515@infradead.org>
References: <1479338252-8777-1-git-send-email-scott.bauer@intel.com>
 <20161117131251.GA15852@infradead.org>
 <20161117173613.GA13865@sbauer-Z170X-UD5>
 <20161117192807.GA31515@infradead.org>
Message-ID: <20161117193322.GA3044@sbauer-Z170X-UD5>

On Thu, Nov 17, 2016@11:28:07AM -0800, Christoph Hellwig wrote:
> On Thu, Nov 17, 2016@10:36:14AM -0700, Scott Bauer wrote:
> > 
> > I want some further clarification, if you don't mind. We call sec_ops
> > inside the actual logic for the opal code. Which is only accessible via the
> > ioctls, is that what you were meaning?  When you say "the driver calls"
> > do you mean that the nvme/sata/et al drivers would implement some generic
> > block sed function that would be called via ioctl?
> > So the call chain would be:
> > 
> > Userland
> >  block/ioctl  ops->blkdev_sed()
> > 
> >   nvme/et al (implements blkdev_sed()) which calls:
> > 
> >    sed.c blkdev_sed_ioctl(with passed in combined fn to get data to controller)?
> > 
> > Is this what you were thinking, if so I agree it will alleviate a bunch of clutter
> > in block/ioctl.c. If this isn't what you were thinking please let me know.
> 
> Similar, but not quite the same.  We already have an ioctl method in
> struct block_device_operations, so in that we'd do something like
> this for nvme:

Ah okay this was the piece I was missing. I was mixed up on how we would
agnostically get it into the nvme drive and allow sata etc to do the same.

Thanks for your help i'll get working.
