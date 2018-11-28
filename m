From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 28 Nov 2018 06:35:31 -0700
Subject: [PATCHSET v2 0/8] block plugging improvements
Message-ID: <20181128133538.20329-1-axboe@kernel.dk>

Series improving plugging for fast devices, but some fixes in here too.

Patch 1 changes the logic for when we sort the plug list, switching
it to only doing it if we have requests for multiple queues in the
plug (and enough requests to warrant an actual sort).

2-6 add a ->commit_rqs() hook and implement it in drivers that use (or
will use) bd->last to optimize IO submission. If a driver currently uses
bd->last to know if it's needed to kick the hardware into action, there
are cases where we flag bd->last == false, but then fail to submit any
further IO due to other resource constraints. We probably get saved by
the fact that this happens for the case where we have pending IO and
that will eventually guarantee forward progress, but we really should
kick IO into gear at that point.

7 improves plugging for blk-mq.

In terms of improvements, for virtualized nvme, I've seen a 2-x IOPS
improvement with proper handling of bd->last with this series.

Changes since v1:

- Fold the plug case for blk-mq, do it if we have 1 hw queue, or
  if we have ->commit_rqs().
- Add disable/enable IRQ to ataflop
- Drop nvme ring index helper
- Rework when to sort patch

-- 
Jens Axboe
