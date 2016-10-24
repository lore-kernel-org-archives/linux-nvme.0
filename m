From: swise@opengridcomputing.com (Steve Wise)
Date: Mon, 24 Oct 2016 12:07:25 -0700
Subject: [PATCH v3 0/6] connect reject event helpers
Message-ID: <cover.1477336045.git.swise@opengridcomputing.com>

While reviewing:

http://lists.infradead.org/pipermail/linux-nvme/2016-October/006681.html

I decided to propose transport-agnostic helper functions to better
handle connection reject event information.  Included are patches
for nvme_rdma, ib_ser, and rds_rdma to utilize the new helpers.

Changes since v2:

- reworked ibcm/iwcm_reject_msg() as per Christoph's recommendation
- use ibcm_ and iwcm_ prefix instead of ib_ and iw_ for reject_msg funcs
- change rdma_consumer_reject() to rdma_is_consumer_reject()
- add rdma_consumer_reject_data() helper function to return private
  data/len
- use new helpers in nvme_rdma, ib_iser, and rdma_rds
- in nvme_rdma, add strings for nvme_rdma_cm_status values

---

Steve Wise (6):
  rdma_cm: add rdma_reject_msg() helper function
  rdma_cm: add rdma_is_consumer_reject() helper function
  rdma_cm: add rdma_consumer_reject_data helper function
  nvme-rdma: use rdma connection reject helper functions
  ib_iser: log the connection reject message
  rds_rdma: log the connection reject message

 drivers/infiniband/core/cm.c             | 48 ++++++++++++++++++++++++++++++++
 drivers/infiniband/core/cma.c            | 43 ++++++++++++++++++++++++++++
 drivers/infiniband/core/iwcm.c           | 21 ++++++++++++++
 drivers/infiniband/ulp/iser/iser_verbs.c |  5 +++-
 drivers/nvme/host/rdma.c                 | 46 ++++++++++++++++++++++++------
 include/rdma/ib_cm.h                     |  6 ++++
 include/rdma/iw_cm.h                     |  6 ++++
 include/rdma/rdma_cm.h                   | 25 +++++++++++++++++
 net/rds/rdma_transport.c                 |  5 +++-
 9 files changed, 195 insertions(+), 10 deletions(-)

-- 
2.7.0
