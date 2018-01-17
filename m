From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 17 Jan 2018 15:52:54 +0200
Subject: [PATCH 0/4] Last WQE Reached event treatment
Message-ID: <1516197178-26493-1-git-send-email-maxg@mellanox.com>

From: root <root@rsws50.mtr.labs.mlnx>

This series adds a new API to support a drain of a QP that is
associated with a SRQ (Shared Receive Queue).
Leakage problem can occur if we won't treat Last WQE Reached event:
1. QP may have consumed SRQ WQE, but no CQE received yet (especially
   in error flow that can take long time)
2. polling responder CQ at this stage is meaningless (since CQEs
   haven't been posted)
3. destroying QP at this point will cause SRQ credit leakage

So the solution (according to IB spec):
1. modify QP to err state
2. wait for Last WQE Reached event
3. poll CQ to free SRQ WQEs completions
4. destroy the QP.

In the series, I based on earlier patchset that enables
direct polling the CQ regardless of the type.
I've added support for ULPs: NVMe-oF, iSER and SRP as well.

Max Gurtovoy (4):
  IB/core: add support for draining Shared receive queues
  nvmet-rdma: notify QP on Last WQE Reached event arrival
  iser-target: remove dead code
  IB/srpt: notify QP on Last WQE Reached event arrival

 drivers/infiniband/core/verbs.c         | 69 ++++++++++++++++++++++++++++++++-
 drivers/infiniband/ulp/isert/ib_isert.c |  3 --
 drivers/infiniband/ulp/srpt/ib_srpt.c   |  1 +
 drivers/nvme/target/rdma.c              |  3 ++
 include/rdma/ib_verbs.h                 |  8 ++++
 5 files changed, 80 insertions(+), 4 deletions(-)

-- 
1.8.3.1
