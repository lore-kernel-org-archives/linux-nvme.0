From: keith.busch@intel.com (Keith Busch)
Date: Thu, 21 May 2015 19:34:20 +0000 (UTC)
Subject: [PATCH] NVMe: Avoid interrupt disable during queue init.
In-Reply-To: <1432253553-17045-1-git-send-email-parav.pandit@avagotech.com>
References: <1432253553-17045-1-git-send-email-parav.pandit@avagotech.com>
Message-ID: <alpine.LNX.2.00.1505211931470.15930@localhost.lm.intel.com>

On Thu, 21 May 2015, Parav Pandit wrote:
> Avoid diabling interrupt and holding q_lock for the queue
> which is just getting initialized.
>
> With this change, online_queues is also incremented without
> lock during queue setup stage.
> if Power management nvme_suspend() kicks in during queue setup time,
> per nvmeq based q_lock spinlock cannot protect device wide
> online_queues variable anyway.

The q_lock is held to protect polling from reading inconsistent data.
