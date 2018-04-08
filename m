From: israelr@mellanox.com (Israel Rukshin)
Date: Sun,  8 Apr 2018 14:08:37 +0000
Subject: [PATCH 0/2 v2] Fix double completing a request
Message-ID: <1523196519-23268-1-git-send-email-israelr@mellanox.com>

This patch series fixes two bugs that was reproduced while getting
block mq timeout (reset controller).

The first bug is a warning of the block layer:

 WARNING: CPU: 9 PID: 563 at block/blk-mq.c:534 __blk_mq_complete_request
 Workqueue: kblockd blk_mq_timeout_work
 RIP: 0010:__blk_mq_complete_request+0x154/0x160
 Call Trace:
  bt_iter+0x43/0x50
  blk_mq_queue_tag_busy_iter+0xfb/0x230
  ? blk_mq_complete_request+0x80/0x80
  ? blk_mq_complete_request+0x80/0x80
  ? __call_rcu.constprop.72+0x170/0x1c0
  blk_mq_timeout_work+0xf6/0x1e0

>From the code:
WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IN_FLIGHT);

The second bug is a NULL deref of a request mr:

 BUG: unable to handle kernel NULL pointer dereference at 0000000000000014
 IP: __nvme_rdma_recv_done.isra.48+0x1ba/0x300 [nvme_rdma]
 Call Trace:
  <IRQ>
  nvme_rdma_recv_done+0x12/0x20 [nvme_rdma]
  __ib_process_cq+0x58/0xb0 [ib_core]
  ib_poll_handler+0x1d/0x70 [ib_core]
  irq_poll_softirq+0x98/0xf0
  __do_softirq+0xbc/0x1c0
  irq_exit+0x9a/0xb0
  do_IRQ+0x4c/0xd0
  common_interrupt+0x90/0x90
  </IRQ>


Those two bugs are related and they happen because we complete the requests
from several places:
 - rdma completions
 - block mq reset work
 - nvme abort commands

The first commit don't let the block layer to complete the request.
Those requests will be completed by nvme abort mechanism.
The second commit fix the race between rdma completions and
nvme abort commands.
It fixes the race by flushing all the rdma completions before
starting the abort commands mechanism.

Change from v1:
 - Adding cover letter

Israel Rukshin (2):
  nvme-rdma: Fix race between queue timeout and error recovery
  nvme-rdma: Fix race at error recovery

 drivers/nvme/host/rdma.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
1.8.3.1
