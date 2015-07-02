From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 02 Jul 2015 09:03:03 -0600
Subject: [PATCH] NVMe: Fix irq freeing when queue_request_irq fails
In-Reply-To: <1435684972-4245-1-git-send-email-jonathan.derrick@intel.com>
References: <1435684972-4245-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <559552A7.2000600@kernel.dk>

On 06/30/2015 11:22 AM, Jon Derrick wrote:
> Fixes an issue when queue_reuest_irq fails in nvme_setup_io_queues. This
> patch initializes all vectors to -1 and resets the vector to -1 in the
> case of a failure in queue_request_irq. This avoids the free_irq in
> nvme_suspend_queue if the queue did not get an irq.

Looks good to me, added for this series.

-- 
Jens Axboe
