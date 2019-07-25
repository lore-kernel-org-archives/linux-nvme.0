From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 25 Jul 2019 20:27:01 +0200
Subject: [PATCH v6 02/16] chardev: introduce cdev_get_by_path()
In-Reply-To: <da0eacb7-3738-ddf3-8c61-7ffc61aa41f4@deltatee.com>
References: <20190725172335.6825-1-logang@deltatee.com>
 <20190725172335.6825-3-logang@deltatee.com>
 <20190725174032.GA27818@kroah.com>
 <682ff89f-04e0-7a94-5aeb-895ac65ee7c9@deltatee.com>
 <20190725180816.GA32305@kroah.com>
 <da0eacb7-3738-ddf3-8c61-7ffc61aa41f4@deltatee.com>
Message-ID: <20190725182701.GA11547@kroah.com>

On Thu, Jul 25, 2019@12:14:33PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2019-07-25 12:08 p.m., Greg Kroah-Hartman wrote:
> > On Thu, Jul 25, 2019@11:53:20AM -0600, Logan Gunthorpe wrote:
> >>
> >>
> >> On 2019-07-25 11:40 a.m., Greg Kroah-Hartman wrote:
> >>> On Thu, Jul 25, 2019@11:23:21AM -0600, Logan Gunthorpe wrote:
> >>>> cdev_get_by_path() attempts to retrieve a struct cdev from
> >>>> a path name. It is analagous to blkdev_get_by_path().
> >>>>
> >>>> This will be necessary to create a nvme_ctrl_get_by_path()to
> >>>> support NVMe-OF passthru.
> >>>
> >>> Ick, why?  Why would a cdev have a "pathname"?
> >>
> >> So we can go from "/dev/nvme0" (which points to a char device) to its
> >> struct cdev and eventually it's struct nvme_ctrl. Doing it this way also
> >> allows supporting symlinks that might be created by udev rules.
> > 
> > Why do you have a "string" within the kernel and are not using the
> > normal open() call from userspace on the character device node on the
> > filesystem in your namespace/mount/whatever?
> 
> NVMe-OF is configured using configfs. The target is specified by the
> user writing a path to a configfs attribute. This is the way it works
> today but with blkdev_get_by_path()[1]. For the passthru code, we need
> to get a nvme_ctrl instead of a block_device, but the principal is the same.

Why isn't a fd being passed in there instead of a random string?

Seems odd, but oh well, that ship sailed a long time ago for block
devices I guess.

So what do you actually _do_ with that char device once you have it?

greg k-h
