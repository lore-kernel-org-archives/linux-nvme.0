From: willy@infradead.org (Matthew Wilcox)
Date: Thu, 25 Jul 2019 10:58:34 -0700
Subject: [PATCH v6 02/16] chardev: introduce cdev_get_by_path()
In-Reply-To: <682ff89f-04e0-7a94-5aeb-895ac65ee7c9@deltatee.com>
References: <20190725172335.6825-1-logang@deltatee.com>
 <20190725172335.6825-3-logang@deltatee.com>
 <20190725174032.GA27818@kroah.com>
 <682ff89f-04e0-7a94-5aeb-895ac65ee7c9@deltatee.com>
Message-ID: <20190725175834.GB30641@bombadil.infradead.org>

On Thu, Jul 25, 2019@11:53:20AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2019-07-25 11:40 a.m., Greg Kroah-Hartman wrote:
> > On Thu, Jul 25, 2019@11:23:21AM -0600, Logan Gunthorpe wrote:
> >> cdev_get_by_path() attempts to retrieve a struct cdev from
> >> a path name. It is analagous to blkdev_get_by_path().
> >>
> >> This will be necessary to create a nvme_ctrl_get_by_path()to
> >> support NVMe-OF passthru.
> > 
> > Ick, why?  Why would a cdev have a "pathname"?
> 
> So we can go from "/dev/nvme0" (which points to a char device) to its
> struct cdev and eventually it's struct nvme_ctrl. Doing it this way also
> allows supporting symlinks that might be created by udev rules.

But you're not really trying to go from a string to a chardev.  You're
trying to go from a nvmet_subsys to a chardev.  Isn't there a better
way to link the two somewhere else?

(I must confess that once I would have known the answer to this, but
the NVMe subsystem has grown ridiculously complex and I can no longer
fit it in my head)
