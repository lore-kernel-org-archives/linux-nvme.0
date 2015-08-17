From: axboe@fb.com (Jens Axboe)
Date: Mon, 17 Aug 2015 15:51:55 -0600
Subject: [PATCH] NVMe: Set queue max segments
In-Reply-To: <1439417874-8925-1-git-send-email-keith.busch@intel.com>
References: <1439417874-8925-1-git-send-email-keith.busch@intel.com>
Message-ID: <55D2577B.9020905@fb.com>

On 08/12/2015 04:17 PM, Keith Busch wrote:
> This sets the queue's max segment size to match the device's
> capabilities. The default of 128 is usable until a device's transfer
> capability exceeds 512k, assuming a device page size of 4k. Many nvme
> devices exceed that transfer limit, so this lets the block layer know what
> kind of commands it to allow to form rather than unnecessarily split them.
>
> One additional segment is added to account for a transfer that may start
> in the middle of a page.

Applied for 4.3.

-- 
Jens Axboe
