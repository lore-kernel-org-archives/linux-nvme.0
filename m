From: axboe@fb.com (Jens Axboe)
Date: Mon, 11 Apr 2016 10:00:24 -0600
Subject: [RESEND PATCH] NVMe: Fix reset/remove race
In-Reply-To: <1460153462-5178-1-git-send-email-keith.busch@intel.com>
References: <1460153462-5178-1-git-send-email-keith.busch@intel.com>
Message-ID: <570BCA18.7040804@fb.com>

On 04/08/2016 04:11 PM, Keith Busch wrote:
> This fixes a scenario where device is present and being reset, but a
> request to unbind the driver occurs.
>
> A previous patch series addressing a device failure removal scenario
> flushed reset_work after controller disable to unblock reset_work waiting
> on a completion that wouldn't occur. This isn't safe as-is. The broken
> scenario can potentially be induced with:
>
>    modprobe nvme && modprobe -r nvme
>
> To fix, the reset work is flushed immediately after setting the controller
> removing flag, and any subsequent reset will not proceed with controller
> initialization if the flag is set.
>
> The controller status must be polled while active, so the watchdog timer
> is also left active until the controller is disabled to cleanup requests
> that may be stuck during namespace removal.

Added, thanks Keith.

-- 
Jens Axboe
