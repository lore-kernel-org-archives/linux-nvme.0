From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 20 Oct 2016 15:40:35 -0700
Subject: [PATCH RFC v2 0/3] connect reject event helpers
Message-ID: <cover.1477003235.git.swise@opengridcomputing.com>

While reviewing:

http://lists.infradead.org/pipermail/linux-nvme/2016-October/006681.html

I decided to propose transport-agnostic helper functions to better
handle connection reject event information.  I've included a nvme_rdma
patch to utilize the new helpers.

Thoughts?

Changes since v1:

- moved reject logic to cm.c and iwcm.c.
- added rdma_consumer_reject() helper.
- added nvme-rdma change to utilize the new helpers.

Steve Wise (3):
  rdma_cm: add rdma_reject_msg() helper function
  rdma_cm: add rdma_consumer_reject() helper function
  nvme-rdma: use rdma_reject_msg() to log connection rejects

 drivers/infiniband/core/cm.c   | 46 ++++++++++++++++++++++++++++++++++++++++++
 drivers/infiniband/core/cma.c  | 26 ++++++++++++++++++++++++
 drivers/infiniband/core/iwcm.c | 18 +++++++++++++++++
 drivers/nvme/host/rdma.c       | 18 ++++++++++-------
 include/rdma/ib_cm.h           | 15 ++++++++++++++
 include/rdma/iw_cm.h           | 15 ++++++++++++++
 include/rdma/rdma_cm.h         | 14 +++++++++++++
 7 files changed, 145 insertions(+), 7 deletions(-)

-- 
2.7.0
