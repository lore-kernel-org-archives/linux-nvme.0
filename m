From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Wed, 23 Jul 2014 07:24:04 -0700
Subject: NVMe: Invalid controller status value, device hotplug out
In-Reply-To: <1406049939-29310-1-git-send-email-mundu2510@gmail.com>
References: <1406049939-29310-1-git-send-email-mundu2510@gmail.com>
Message-ID: <53CFC584.2000301@linux.intel.com>

On 07/22/2014 10:25 AM, Mundu wrote:
>   If device hotplug out, controller status become 0xFFFF_FFFF
>   1. Controller fatal status become true in nvme_kthread()
>   2. Ready bit nvere reset to 0 in nvme_wait_ready() for
>      controller disable.
>      above two scenarios controller status data is not a valid
>      data, since device/controller is already removed (hotplug)
>

I believe you want this comment to be in the actual patch you sent?? 
The patch you sent after this email has no description, something 
Matthew pointed out previously.

> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>
