From: joshi.k@samsung.com (kanchan)
Date: Wed, 3 Apr 2019 20:00:22 +0530
Subject: [PATCH v3 6/7] fs: introduce write-hint start point for
 in-kernel hints
In-Reply-To: <20190401051239.GP26298@dastard>
References: <1553846032-4451-1-git-send-email-joshi.k@samsung.com>
 <CGME20190329075758epcas1p335511dcb10bb5592ea72409a1d01e752@epcas1p3.samsung.com>
 <1553846032-4451-7-git-send-email-joshi.k@samsung.com>
 <20190401051239.GP26298@dastard>
Message-ID: <11ce01d4ea29$cb576c90$620645b0$@samsung.com>

> Which means that when a new userspace hint is defined, all the kernel
hints change numbers and, AIUI, that changes how the kernel hints are mapped
to the underlying device.

Currently adding a new user-space hint requires modifying code and
installing modified kernel. So I felt it would be less probable to encounter
that situation while in production workload.


>The kernel hints need to be mapped to the highest supported number a work
down, while userspace starts at the lowest and works up.

Actually, I initially implemented "blk_write_hint_to_streamid" function like
that i.e. as per the table you've put. But that code involved more
checks/branches (condition checks) than the current one.
Also, request queue contained this statically defined array called
"write_hints", which nvme driver updated to gather stream stats.
Snippet below - 

  	if (streamid < ARRAY_SIZE(req->q->write_hints))
		req->q->write_hints[streamid] += blk_rq_bytes(req) >> 9;

That requires nvme driver doing a reverse conversion from streamid to
array-index(some more conditional checks) if kernel-hints get mapped to
highest possible stream numbers.


Overall, will it not be about adding additional  run-time checks in I/O path
(which we will always execute) for the condition which will happen only if
one chooses to extend user-space hint count in between?


Thanks,

-----Original Message-----
From: Dave Chinner [mailto:david@fromorbit.com] 
Sent: Monday, April 01, 2019 10:43 AM
To: Kanchan Joshi <joshi.k at samsung.com>
Cc: linux-kernel at vger.kernel.org; linux-block at vger.kernel.org;
linux-nvme at lists.infradead.org; linux-fsdevel at vger.kernel.org;
linux-ext4 at vger.kernel.org; axboe at fb.com; prakash.v at samsung.com;
anshul at samsung.com; joshiiitr at gmail.com
Subject: Re: [PATCH v3 6/7] fs: introduce write-hint start point for
in-kernel hints

On Fri, Mar 29, 2019@01:23:51PM +0530, Kanchan Joshi wrote:
> kernel-mode components can define own write-hints using 
> "WRITE_LIFE_KERN_MIN" as base.
> 
> Signed-off-by: Kanchan Joshi <joshi.k at samsung.com>
> ---
>  include/linux/fs.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h index 
> 29d8e2c..6a2673e 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -291,6 +291,8 @@ enum rw_hint {
>  	WRITE_LIFE_MEDIUM	= RWH_WRITE_LIFE_MEDIUM,
>  	WRITE_LIFE_LONG		= RWH_WRITE_LIFE_LONG,
>  	WRITE_LIFE_EXTREME	= RWH_WRITE_LIFE_EXTREME,
> +/* Kernel should use write-hint starting from this */
> +	WRITE_LIFE_KERN_MIN,

Which means that when a new userspace hint is defined, all the kernel hints
change numbers and, AIUI, that changes how the kernel hints are mapped to
the underlying device.

The kernel hints need to be mapped to the highest supported number a work
down, while userspace starts at the lowest and works up. The "kernel to
device stream id" needs to translate the kernel hints down to the upper
range of the device hints.

I think the mapping range the code uses should be:

    HINT		Type			device
     0			USER 0			  0
     1			USER 1			  1
     ......
     n			USER MAX		  n

     {n,65535-m}	UNUSED			{n,dev_max-m}

     65535 - m		KERN_MIN,		dev_max - m
     ......
     65532		KERN 3			dev_max - 3
     65533		KERN 2			dev_max - 2
     65534		KERN 1			dev_max - 1
     65535		KERN 0			dev_max

i.e. if you look at the mapping as a signed short, >= 0 are user hints, < 0
are kernel hints. This provides an obvious, simple way to map the kernel
hints to the upper range of the device hint range. It also provides a simple
way to compress both user and kernel hints into a limited device hint range
- kernel always uses the top device hint, user is limited to the rest of the
range....

This means the ranges don't overlap or change at either the code or the
device level as we add more user and kernel hint channels in the future.

Cheers,

Dave.
--
Dave Chinner
david at fromorbit.com
