From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 11 Dec 2014 08:26:09 -0700
Subject: [PATCH][linux-block] NVMe: Fix FS mount issue(hot-remove followed
 by hot-add)
In-Reply-To: <1418294839-3464-1-git-send-email-indraneel.m@samsung.com>
References: <1418294839-3464-1-git-send-email-indraneel.m@samsung.com>
Message-ID: <5489B791.7020007@kernel.dk>

On 12/11/2014 03:47 AM, Indraneel M wrote:
> Jens, this version is against the linux-block tree.

It's not, though:

checking file drivers/block/nvme-core.c
Hunk #1 FAILED at 2600.
Hunk #2 FAILED at 2859.
2 out of 2 hunks FAILED

what branch are you on? It has to be against for-3.19/drivers or 
for-next. This was simple enough to hand apply, so I did that. This is 
the result:

http://git.kernel.dk/?p=linux-block.git;a=commit;h=285dffc9101244ac65c29672a1fb3fe614b52238

-- 
Jens Axboe
