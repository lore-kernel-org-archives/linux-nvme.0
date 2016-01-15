From: jonathan.derrick@intel.com (Jon Derrick)
Date: Fri, 15 Jan 2016 11:22:27 -0700
Subject: [PATCH 1/2] blk-mq: dynamic h/w context count
In-Reply-To: <1450397295-24031-1-git-send-email-keith.busch@intel.com>
References: <1450397295-24031-1-git-send-email-keith.busch@intel.com>
Message-ID: <20160115182227.GA7253@localhost.localdomain>

On Thu, Dec 17, 2015@05:08:14PM -0700, Keith Busch wrote:
> The hardware's provided queue count may change at runtime with resource
> provisioning. This patch allows a block driver to alter the number of
> h/w queues available when its resource count changes.
> 
> The main part is a new blk-mq API to request a new number of h/w queues
> for a given live tag set. The new API freezes all queues using that set,
> then adjusts the allocated count prior to remapping these to CPUs.
> 
> The bulk of the rest just shifts where h/w contexts and all their
> artifacts are allocated and freed.
> 
> The number of max h/w contexts is capped to the number of possible cpus
> since there is no use for more than that. As such, all pre-allocated
> memory for pointers need to account for the max possible rather than
> the initial number of queues.
> 
> A side effect of this is that the blk-mq will proceed successfully as
> long as it can allocate at least one h/w context. Previously it would
> fail request queue initialization if less than the requested number
> was allocated.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---

Looks good, works well,
Tested-by: Jon Derrick <jonathan.derrick at intel.com>
