From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 21 May 2015 12:39:18 -0600
Subject: [PATCH] NVMe: Avoid interrupt disable during queue init.
In-Reply-To: <1432253553-17045-1-git-send-email-parav.pandit@avagotech.com>
References: <1432253553-17045-1-git-send-email-parav.pandit@avagotech.com>
Message-ID: <555E2656.5030503@kernel.dk>

On 05/21/2015 06:12 PM, Parav Pandit wrote:
> Avoid diabling interrupt and holding q_lock for the queue
> which is just getting initialized.
>
> With this change, online_queues is also incremented without
> lock during queue setup stage.
> if Power management nvme_suspend() kicks in during queue setup time,
> per nvmeq based q_lock spinlock cannot protect device wide
> online_queues variable anyway.

Seems fairly pointless, it's not like it's a hot path...

-- 
Jens Axboe
