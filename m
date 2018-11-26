From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 26 Nov 2018 09:35:48 -0700
Subject: [PATCHSET 0/8] block plugging improvements
Message-ID: <20181126163556.5181-1-axboe@kernel.dk>

Series improving plugging for fast devices, but some fixes in here too.

1-2 are improvements around plugging accounting. Changes the behavior
a bit, but works fine for me.

3-6 add a ->commit_rqs() hook and implement it in drivers that use (or
will use) bd->last to optimize IO submission. If a driver currently uses
bd->last to know if it's needed to kick the hardware into action, there
are cases where we flag bd->last == false, but then fail to submit any
further IO due to other resource constraints. We probably get saved by
the fact that this happens for the case where we have pending IO and
that will eventually guarantee forward progress, but we really should
kick IO into gear at that point.

7-8 improve plugging for blk-mq.

In terms of improvements, for virtualized nvme, I've seen a 2-x IOPS
improvement with proper handling of bd->last with this series.

-- 
Jens Axboe
