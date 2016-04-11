From: axboe@fb.com (Jens Axboe)
Date: Mon, 11 Apr 2016 10:02:37 -0600
Subject: [PATCH] NVMe: Always use MSI/MSI-x interrupts
In-Reply-To: <1460153350-4992-1-git-send-email-keith.busch@intel.com>
References: <1460153350-4992-1-git-send-email-keith.busch@intel.com>
Message-ID: <570BCA9D.4060807@fb.com>

On 04/08/2016 04:09 PM, Keith Busch wrote:
> Multiple users have reported device initialization failure due the driver
> not receiving legacy PCI interrupts. This is not unique to any particular
> controller, but has been observed on multiple platforms.
>
> There have been no issues reported or observed when with message signaled
> interrupts, so this patch attempts to use MSI-x during initialization,
> falling back to MSI. If that fails, legacy would become the default.
>
> The setup_io_queues error handling had to change as a result: the admin
> queue's msix_entry used to be initialized to the legacy IRQ. The case
> where nr_io_queues is 0 would fail request_irq when setting up the admin
> queue's interrupt since re-enabling MSI-x fails with 0 vectors, leaving
> the admin queue's msix_entry invalid. Instead, return success immediately.

Added for 4.7.

-- 
Jens Axboe
