From: keith.busch@intel.com (Keith Busch)
Date: Tue, 27 Jan 2015 20:59:02 +0000 (UTC)
Subject: [PATCH/RFC] NVMe: add support for doing offline/online of attached
 namespaces
In-Reply-To: <20150123152430.GA6107@kernel.dk>
References: <20150123152430.GA6107@kernel.dk>
Message-ID: <alpine.LNX.2.00.1501272044190.15481@localhost.lm.intel.com>

On Fri, 23 Jan 2015, Jens Axboe wrote:
> Add two new ioctls for the char control device:
>
> - NVME_IOCTL_OFFLINE_DISK will offline namespaces/disks and leave only
>  the admin queue and char dev running.
>
> - NVME_IOCTL_ONLINE_DISK will do discovery and add namespaces and disks
>  back into the system.
>
> The intended use case is for safely doing a format or firmware upgrade,
> where device and hardware characteristics could change substantially
> beyond just device size and block size.
>
> This is an RFC patch. The goal is as listed, being able to detach any
> namespaces and bdevs from a device, so we just have the admin part left.
> I'm open to alternative suggestions on how to handle this. Solutions
> that include rmmod/modprobe if the driver wont work if you have more
> than one NVMe device in a system.
>
> I've run this through various stress testing, and it seems to hold up
> fine.

Looks pretty good, I think we need something like this. We trust a user
too much to not to do something bad when changing things like block sizes,
so it'd be good to have a mechanisms to make this safer.

Should these actions be IOCTLs? I think 'sysfs' might be easier to use,
and easier for adding additional actions in the future.

Could we try for something with more control? For example, I might change
the block format on namespace 2, but namespace 1 is my root partition
so I don't want to delete that disk.

I don't think you need to reference count the namespace open's. The
controller reference is also taken, and the last namespace reference
can't be released until the last controller reference is also released,
so it seems redundant.

That's all I got right now. Thanks!
