From: israelr@mellanox.com (Israel Rukshin)
Date: Wed, 11 Apr 2018 16:07:02 +0000
Subject: [PATCH 0/2 v3] Fix nvme-rdma timeout flow
Message-ID: <1523462824-25643-1-git-send-email-israelr@mellanox.com>

Hi all,

This patch series fixes a bug that was reproduced while getting
block mq IO timeout (causing nvmf to reset controller) running
with rdma transport.

The bug is a NULL deref of a request mr:

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


The bug happens because we complete the request before handling
the good rdma completion.
When completing the request we return its mr to the mr pool
(and set the request's mr pointer to NULL) and also unmap its data.
This may lead also to a memory corruption like was reported by VastData.

My two patches fix those problems by completing the requests only after
we finish handling all the good completions and the qp is in error state.

The current code complete the requests from several places:
 - rdma completions
 - block mq timeout work
 - nvme abort commands (nvme_cancel_request())

The first commit don't let the block layer to complete the request.
Those requests will be completed by nvme abort mechanism.
So now we have a race only between two places.

The second commit fix the race between rdma completions and
nvme abort commands.
It fixes the race by flushing all the rdma completions before
starting the abort commands mechanism.

Change from v1:
 - Adding cover letter

Change from v2:
 - Edit bug description

Israel Rukshin (2):
  nvme-rdma: Fix race between queue timeout and error recovery
  nvme-rdma: Fix command completion race at error recovery

 drivers/nvme/host/rdma.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
1.8.3.1
