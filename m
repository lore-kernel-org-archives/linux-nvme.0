From: axboe@fb.com (Jens Axboe)
Date: Wed, 13 Apr 2016 08:16:40 -0600
Subject: [PATCH v3] nvme: Avoid reset work on watchdog timer function
 during error recovery
In-Reply-To: <1460556500-7815-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1460556500-7815-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Message-ID: <570E54C8.1060601@fb.com>

On 04/13/2016 08:08 AM, Guilherme G. Piccoli wrote:
> This patch adds a check on nvme_watchdog_timer() function to avoid the
> call to reset_work() when an error recovery process is ongoing on
> controller. The check is made by looking at pci_channel_offline()
> result.
>
> If we don't check for this on nvme_watchdog_timer(), error recovery
> mechanism can't recover well, because reset_work() won't be able to
> do its job (since we're in the middle of an error) and so the
> controller is removed from the system before error recovery mechanism
> can perform slot reset (which would allow the adapter to recover).
>
> In this patch we also have split the huge condition expression on
> nvme_watchdog_timer() by introducing an auxiliary function to help
> make the code more readable.

Thanks, added.

-- 
Jens Axboe
