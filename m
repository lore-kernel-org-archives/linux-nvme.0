From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 25 Oct 2016 13:19:03 -0700
Subject: [PATCH v4 0/8] connect reject event helpers
Message-ID: <cover.1477426743.git.swise@opengridcomputing.com>

While reviewing:

http://lists.infradead.org/pipermail/linux-nvme/2016-October/006681.html

I decided to propose transport-agnostic helper functions to better
handle connection reject event information.  Included are patches
for nvme/fabrics, iser, and rds to utilize the new helpers.

Doug, this series applies on top of v4.9-rc2 as well as sagi's nvmf-4.9-rc
branch as of today.  The series should be targeted for 4.10.

Changes since v3:
- added reviewed-by/acked-by tags
- positive logic in reject_msg helpers
- cleaned up reject message strings
- added patches to use helpers in isert and nvmet_rdma
- fixed zero-day build warning

Changes since v2:

- reworked ibcm/iwcm_reject_msg() as per Christoph's recommendation
- use ibcm_ and iwcm_ prefix instead of ib_ and iw_ for reject_msg funcs
- change rdma_consumer_reject() to rdma_is_consumer_reject()
- add rdma_consumer_reject_data() helper function to return private
  data/len
- use new helpers in nvme_rdma, ib_iser, and rdma_rds
- in nvme_rdma, add strings for nvme_rdma_cm_status values

---

Steve Wise (8):
  rdma_cm: add rdma_reject_msg() helper function
  rdma_cm: add rdma_is_consumer_reject() helper function
  rdma_cm: add rdma_consumer_reject_data helper function
  nvme-rdma: use rdma connection reject helper functions
  ib_iser: log the connection reject message
  rds_rdma: log the connection reject message
  ib_isert: log the connection reject message
  nvmet_rdma: log the connection reject message

 drivers/infiniband/core/cm.c             | 48 ++++++++++++++++++++++++++++++++
 drivers/infiniband/core/cma.c            | 43 ++++++++++++++++++++++++++++
 drivers/infiniband/core/iwcm.c           | 21 ++++++++++++++
 drivers/infiniband/ulp/iser/iser_verbs.c |  5 +++-
 drivers/infiniband/ulp/isert/ib_isert.c  |  2 ++
 drivers/nvme/host/rdma.c                 | 46 ++++++++++++++++++++++++------
 drivers/nvme/target/rdma.c               |  3 ++
 include/rdma/ib_cm.h                     |  6 ++++
 include/rdma/iw_cm.h                     |  6 ++++
 include/rdma/rdma_cm.h                   | 25 +++++++++++++++++
 net/rds/rdma_transport.c                 |  5 +++-
 11 files changed, 200 insertions(+), 10 deletions(-)

-- 
2.7.0
