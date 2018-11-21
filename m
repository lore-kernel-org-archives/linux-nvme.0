From: hch@lst.de (Christoph Hellwig)
Date: Wed, 21 Nov 2018 17:23:34 +0100
Subject: block and nvme polling improvements
Message-ID: <20181121162347.17430-1-hch@lst.de>

Hi all,

this series optimizes a few bits in the block layer and nvme code
related to polling.

It starts by moving the queue types recently introduce entirely into
the block layer instead of requiring an indirect call for them.

It then switches nvme and the block layer to only allow polling
with separate poll queues, which allows us to realize the following
benefits:

 - poll queues can safely avoid disabling irqs on any locks
   (we already do that in NVMe, but it isn't 100% kosher as-is)
 - regular interrupt driven queues can drop the CQ lock entirely,
   as we won't race for completing CQs

Then we drop the NVMe RDMA code, as it doesn't follow the new mode,
and remove the nvme multipath polling code including the block hooks
for it, which didn't make much sense to start with given that we
started bypassing the multipath code for single controller subsystems
early on.  Last but not least we enable polling in the block layer
by default if the underlying driver has poll queues, as that already
requires explicit user action.

Note that it would be really nice to have polling back for RDMA with
dedicated poll queues, but that might take a while.  Also based on
Jens' polling aio patches we could now implement a model in nvmet
where we have a thread polling both the backend nvme device and
the RDMA CQs, which might give us some pretty nice performace
(I know Sagi looked into something similar a while ago).

A git tree is also available at:

    git://git.infradead.org/users/hch/misc.git nvme-polling

Gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/nvme-polling
