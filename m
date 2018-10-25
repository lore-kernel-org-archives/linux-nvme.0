From: bvanassche@acm.org (Bart Van Assche)
Date: Thu, 25 Oct 2018 14:01:27 -0700
Subject: [PATCH v2 0/2] nvmet-rdma: Rework the DoS mitigation code
Message-ID: <20181025210129.96766-1-bvanassche@acm.org>

Hi Christoph,

This patch series reworks the DoS mitigation code in the NVMeOF
target code and also addresses a lockdep complaint that has been
discussed recently on the NVMe mailing list. Please consider this
patch series for the upstream kernel.

Thanks,

Bart.

Changes compared to v1: reworked the approach of patch 1/2.

Bart Van Assche (2):
  nvmet-rdma: Rework DoS attack mitigation
  nvmet-rdma: Use the system workqueues again for deletion work

 drivers/nvme/target/rdma.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

-- 
2.19.1.568.g152ad8e336-goog
