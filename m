From: ming.lei@redhat.com (Ming Lei)
Date: Thu, 18 Apr 2019 22:34:30 +0800
Subject: [PATCH] block: use static bio_set for bio_split() calls
In-Reply-To: <20190418140632.60606-1-hare@suse.de>
References: <20190418140632.60606-1-hare@suse.de>
Message-ID: <20190418143429.GA19175@ming.t460p>

Hi Hannes,

On Thu, Apr 18, 2019@04:06:32PM +0200, Hannes Reinecke wrote:
> When calling blk_queue_split() it will be using the per-queue
> bioset to allocate the split bio from. However, blk_steal_bios()
> might move the bio to another queue, _and_ the original queue
> might be removed completely (nvme is especially prone to do so).

Could you explain a bit how the original queue is removed in case
that blk_steal_bios() is involved?

> That leaves the bvecs of the split bio with a missing / destroyed
> mempool, and a really fun crash in bio_endio().

per-queue bioset is used originally for avoiding deadlock, are you
sure the static bioset is safe?


Thanks,
Ming
