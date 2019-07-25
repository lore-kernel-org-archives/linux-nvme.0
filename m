From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 25 Jul 2019 20:08:16 +0200
Subject: [PATCH v6 02/16] chardev: introduce cdev_get_by_path()
In-Reply-To: <682ff89f-04e0-7a94-5aeb-895ac65ee7c9@deltatee.com>
References: <20190725172335.6825-1-logang@deltatee.com>
 <20190725172335.6825-3-logang@deltatee.com>
 <20190725174032.GA27818@kroah.com>
 <682ff89f-04e0-7a94-5aeb-895ac65ee7c9@deltatee.com>
Message-ID: <20190725180816.GA32305@kroah.com>

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

Why do you have a "string" within the kernel and are not using the
normal open() call from userspace on the character device node on the
filesystem in your namespace/mount/whatever?

Where is this random string coming from?  Why is this so special that no
one else has ever needed it?

thanks,

greg k-h
