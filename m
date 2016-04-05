From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 5 Apr 2016 05:35:23 -0700
Subject: [PATCH] NVMe: Re-introduce polling for completions
In-Reply-To: <1459808689-7689-1-git-send-email-keith.busch@intel.com>
References: <1459808689-7689-1-git-send-email-keith.busch@intel.com>
Message-ID: <20160405123523.GA19495@infradead.org>

On Mon, Apr 04, 2016@04:24:49PM -0600, Keith Busch wrote:
> Multiple users have reported device initialization failure on some
> platforms due the driver not receiving expected interrupts. This is not
> the fault of any particular controller. This patch polls for completions
> on the admin queue in the watchdog timer, and starts the timer immediately
> after controller initialization completes, just before the first admin
> command is issued.

So how do any other PCIe device work given that almost no driver does
unconditionaly polling?

> +	spin_lock_irq(&admin_q->q_lock);
> +	nvme_process_cq(admin_q);
> +	spin_unlock_irq(&admin_q->q_lock);

Add a comment on why this is done.  Given that only the admin queue
is polled it's going to be a really convoluted explanation which should
be spelled out in detail.
