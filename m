From: axboe@fb.com (Jens Axboe)
Date: Mon, 22 Dec 2014 12:54:16 -0700
Subject: [PATCHv2] NVMe: Fix double free irq
In-Reply-To: <alpine.LNX.2.00.1412221840260.4026@localhost.lm.intel.com>
References: <1419273081-13080-1-git-send-email-keith.busch@intel.com>
 <alpine.LNX.2.00.1412221840260.4026@localhost.lm.intel.com>
Message-ID: <549876E8.2010409@fb.com>

On 12/22/2014 11:42 AM, Keith Busch wrote:
> ... and Willy reminded me you can't have more than 2k MSI-x vectors, so
> int is overkill. We can just change the int to s16 below, and alignment
> is still fine.

I'll just cut that hunk when folding.

-- 
Jens Axboe
