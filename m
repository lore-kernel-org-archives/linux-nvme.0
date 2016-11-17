From: scott.bauer@intel.com (Scott Bauer)
Date: Thu, 17 Nov 2016 10:36:14 -0700
Subject: [PATCH v1 0/7] SED OPAL Library
In-Reply-To: <20161117131251.GA15852@infradead.org>
References: <1479338252-8777-1-git-send-email-scott.bauer@intel.com>
 <20161117131251.GA15852@infradead.org>
Message-ID: <20161117173613.GA13865@sbauer-Z170X-UD5>

On Thu, Nov 17, 2016@05:12:51AM -0800, Christoph Hellwig wrote:
> Hi Scott,
> 
> I took a look at the code and here are some very high level comments:
> 
>  - we only call into block_device_operations.sec_ops from the ioctl
>    handlers.  So instead of adding it to the block layer I'd rather
>    structure the code so that the driver itself calls a new common
>    blkdev_sed_ioctl handler implemented in lib/sed.c, which then gets
>    callbacks passed directly from the calling, similar to how
>    opal_unlock_from_suspend works.

I want some further clarification, if you don't mind. We call sec_ops
inside the actual logic for the opal code. Which is only accessible via the
ioctls, is that what you were meaning?  When you say "the driver calls"
do you mean that the nvme/sata/et al drivers would implement some generic
block sed function that would be called via ioctl?
So the call chain would be:

Userland
 block/ioctl  ops->blkdev_sed()

  nvme/et al (implements blkdev_sed()) which calls:

   sed.c blkdev_sed_ioctl(with passed in combined fn to get data to controller)?

Is this what you were thinking, if so I agree it will alleviate a bunch of clutter
in block/ioctl.c. If this isn't what you were thinking please let me know.




>  - talking about lib/sed*.c - I'd move it to block/

I don't have any reservations about this but from a learning standpoint, why
 block/ instead of lib/ ?

>  - there are a lot of levels of indirection in the code, I think
>    we can condense them down a bit to basically just having the
>    main blkdev_sed_ioctl entry point, which should check
>    bdev_sec_capable first, and then dispatch to the security
>    types, probably through a little method table.

If we go with what I described above I'm not sure if we'll even need
blkdev_sec_capable. If the driver(nvme/etc) implements blkdev_sed then we know it's
capable?

>  - what's so special about request_user_key that it can't be inline
>    into the only caller but needs a separate file?

Probably nothing I'll check with Rafael and see if there was a reason.
We do have another patch set which once all this new code lands lives in that file.
It can probably go elsewhere though.

>  - please don't use pointer indirections in your userspace ABI,
>    struct sed_key will be a pain to handle for 32-bit userspace
>    on 64-bit kernels.  I don't fully understand what the key_type
>    is for anyway - it seems like exactly one type is supported
>    per call anyway.

Sure good call... Now that you say this I see we didnt even implement the compat
ioctl properly for the indirect pointers.
We'll inline as much as we can.
