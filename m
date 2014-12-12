From: indraneel.m@samsung.com (Indraneel Mukherjee)
Date: Fri, 12 Dec 2014 14:17:53 +0530
Subject: [PATCH][linux-block] NVMe: Fix FS mount issue(hot-remove followed
 by hot-add)
In-Reply-To: <5489B791.7020007@kernel.dk>
References: <1418294839-3464-1-git-send-email-indraneel.m@samsung.com>
 <5489B791.7020007@kernel.dk>
Message-ID: <000d01d015e8$5615a740$0240f5c0$@samsung.com>

> -----Original Message-----
> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On Behalf
> Of Jens Axboe
> Sent: Thursday, December 11, 2014 8:56 PM
> To: Indraneel M; linux-nvme at lists.infradead.org; Keith Busch
> Subject: Re: [PATCH][linux-block] NVMe: Fix FS mount issue(hot-remove
> followed by hot-add)
> 
> On 12/11/2014 03:47 AM, Indraneel M wrote:
> > Jens, this version is against the linux-block tree.
> 
> It's not, though:
> 
> checking file drivers/block/nvme-core.c
> Hunk #1 FAILED at 2600.
> Hunk #2 FAILED at 2859.
> 2 out of 2 hunks FAILED
> 
> what branch are you on? It has to be against for-3.19/drivers or for-next.
This
> was simple enough to hand apply, so I did that. This is the result:
> 
> http://git.kernel.dk/?p=linux-
> block.git;a=commit;h=285dffc9101244ac65c29672a1fb3fe614b52238


Thanks Jens! I had just cloned linux-block and created a patch against it
without any branch switch.


> 
> --
> Jens Axboe
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
