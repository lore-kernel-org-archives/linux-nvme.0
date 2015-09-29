From: keith.busch@intel.com (Keith Busch)
Date: Tue, 29 Sep 2015 14:26:07 +0000 (UTC)
Subject: [PATCH 0/3] blk-mq & nvme: introduce .map_changed
In-Reply-To: <1443496857-26887-1-git-send-email-tom.leiming@gmail.com>
References: <1443496857-26887-1-git-send-email-tom.leiming@gmail.com>
Message-ID: <alpine.LNX.2.00.1509291418270.23840@localhost.lm.intel.com>

On Mon, 28 Sep 2015, Ming Lei wrote:
> This patchset introduces .map_changed callback into 'struct blk_mq_ops',
> and use this callback to get NVMe notified about the mapping changed event,
> then NVMe can update the irq affinity hint for its queues.

I think this is going the wrong direction. Shouldn't we provide blk-mq
the vectors in the tag set so that layer can manage the irq hints?

This could lead to more cpu-queue assignment optimizations from using
that information. For example, two h/w contexts sharing the same vector
shouldn't be assigned to cpus on different NUMA nodes.

> Also the 'cpumask' in 'struct blk_mq_tags' isn't needed any more, so remove
> that and related kernel interface.

It was added to the tags because the cpu mask is an artifact of the
tags rather that duplicating it across all the h/w contexts sharing the
same set. It also doesn't let a h/w context from one namespace overwrite
another's cpu affinity mask when they share the same vector.
