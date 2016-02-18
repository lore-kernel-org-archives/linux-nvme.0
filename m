From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 17 Feb 2016 20:11:22 -0800
Subject: [PATCH-4.5-v3 4/5] NVMe: Move error handling to failed reset
 handler
In-Reply-To: <1455734215-20396-5-git-send-email-keith.busch@intel.com>
References: <1455734215-20396-1-git-send-email-keith.busch@intel.com>
 <1455734215-20396-5-git-send-email-keith.busch@intel.com>
Message-ID: <20160218041122.GC12379@infradead.org>

> +/**
> + * nvme_kill_queues(): Ends all namespace queues
> + * @ctrl: the dead controller that needs to end
> + *
> + * Call this function when the driver determines it is unable to get the
> + * controller in a state capable of servicing IO.
> + */
> +void nvme_kill_queues(struct nvme_ctrl *ctrl)

Is there a good reason to skyp the admin queue here entirely?

Otherwise looks fine to me.
