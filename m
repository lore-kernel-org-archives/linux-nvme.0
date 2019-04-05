From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 5 Apr 2019 16:23:27 -0600
Subject: [PATCH] blk-mq: Wait for for hctx requests on CPU unplug
In-Reply-To: <20190405215920.27085-1-keith.busch@intel.com>
References: <20190405215920.27085-1-keith.busch@intel.com>
Message-ID: <226503cd-53ac-902c-7944-b2748407b1d3@kernel.dk>

On 4/5/19 3:59 PM, Keith Busch wrote:
> Managed interrupts can not migrate affinity when their CPUs are offline.
> If the CPU is allowed to shutdown before they're returned, commands
> dispatched to managed queues won't be able to complete through their
> irq handlers.
> 
> Introduce per-hctx reference counting so we can block the CPU dead
> notification for all allocated requests to complete if an hctx's last
> CPU is being taken offline.

What does this do to performance? We're doing a map per request...

-- 
Jens Axboe
