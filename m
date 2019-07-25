From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 25 Jul 2019 11:53:20 -0600
Subject: [PATCH v6 02/16] chardev: introduce cdev_get_by_path()
In-Reply-To: <20190725174032.GA27818@kroah.com>
References: <20190725172335.6825-1-logang@deltatee.com>
 <20190725172335.6825-3-logang@deltatee.com>
 <20190725174032.GA27818@kroah.com>
Message-ID: <682ff89f-04e0-7a94-5aeb-895ac65ee7c9@deltatee.com>



On 2019-07-25 11:40 a.m., Greg Kroah-Hartman wrote:
> On Thu, Jul 25, 2019@11:23:21AM -0600, Logan Gunthorpe wrote:
>> cdev_get_by_path() attempts to retrieve a struct cdev from
>> a path name. It is analagous to blkdev_get_by_path().
>>
>> This will be necessary to create a nvme_ctrl_get_by_path()to
>> support NVMe-OF passthru.
> 
> Ick, why?  Why would a cdev have a "pathname"?

So we can go from "/dev/nvme0" (which points to a char device) to its
struct cdev and eventually it's struct nvme_ctrl. Doing it this way also
allows supporting symlinks that might be created by udev rules.

This is very similar to blkdev_get_by_path() that lets regular NVMe-OF
obtain the struct block_device from a path.

I didn't think this would be all that controversial.

> What is "NVMe-OF passthru"?  Why does a char device node have anything
> to do with NVMe?

NVME-OF passthru is support for NVME over fabrics to directly target a
regular NVMe controller and thus export an entire NVMe device to a
remote system. We need to be able to tell the kernel which controller to
use and IMO a path to the device file is the best way as it allows us to
support symlinks created by udev.

> We have way too many ways to abuse cdevs today, my long-term-wish has
> always been to clean this interface up to make it more sane and unified,
> and get rid of the "outliers" (all created at the time for a good
> reason, that's not the problem.)  But to add "just one more" seems
> really odd to me.

Well it doesn't seem all that much like an outlier to me.

Logan
