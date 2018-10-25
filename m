From: bvanassche@acm.org (Bart Van Assche)
Date: Thu, 25 Oct 2018 14:13:07 -0700
Subject: [PATCH v3 0/2] nvmet-rdma: Rework the DoS mitigation code
Message-ID: <20181025211309.100564-1-bvanassche@acm.org>

Hi Christoph,

This patch series reworks the DoS mitigation code in the NVMeOF
target code and also addresses a lockdep complaint that has been
discussed recently on the NVMe mailing list. Please consider this
patch series for the upstream kernel.

Thanks,

Bart.

Changes compared to v2:
- Avoid that code introduced in patch 1/2 is moved around in patch 2/2.
  The end result of patches 1 and 2 combined remains the same.

Changes compared to v1:
- Reworked the approach of patch 1/2.

Bart Van Assche (2):
  nvmet-rdma: Rework DoS attack mitigation
  nvmet-rdma: Use the system workqueues again for deletion work

 drivers/nvme/target/rdma.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

-- 
2.19.1.568.g152ad8e336-goog
