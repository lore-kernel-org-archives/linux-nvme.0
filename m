From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 31 Mar 2017 12:59:12 +0200 (CEST)
Subject: [PATCH] irq/affinity: Assign all CPUs a vector
In-Reply-To: <1490743277-14139-1-git-send-email-keith.busch@intel.com>
References: <1490743277-14139-1-git-send-email-keith.busch@intel.com>
Message-ID: <alpine.DEB.2.20.1703311247160.1780@nanos>

On Tue, 28 Mar 2017, Keith Busch wrote:

> The number of vectors to assign needs to be adjusted for each node such
> that it doesn't exceed the number of CPUs in that node. This patch
> recalculates the vector assignment per-node so that we don't try to
> assign more vectors than there are CPUs. When that previously happened,
> the cpus_per_vec was calculated to be 0, so many vectors had no CPUs
> assigned. This then goes on to fail to allocate descriptors due to
> empty masks, leading to an unoptimal spread.

To be honest: This changelog sucks. I really have a hard time to figure out
what's wrong. Can you please structure and rephrase this so it's
understandable for people who did not debug the issue five days ago? That
includes yourself when you have to look at that patch 3 month from now.

A proper structure would be: Context - Problem - Solution. e.g.

  irq_create_affinity_masks() spreads the interrupt vectors of a multi
  queue device across CPUs.

  The algorithm fails to do X, which causes problem Y

  Make it do frotz so the blas are properly assigned.

> Not only does this patch get the intended spread, this also fixes
> other subsystems that depend on every CPU being assigned to something:
> blk_mq_map_swqueue dereferences NULL while mapping s/w queues when CPUs
> are unnassigned, so making sure all CPUs are assigned fixes that.

That's hardly a justification for that change. If blk_mq_map_swqueue()
lacks sanity checks, then blk_mq_map_swqueue() is broken and needs to be
fixed independently of this.

Thanks,

	tglx
