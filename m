From: bvanassche@acm.org (Bart Van Assche)
Date: Thu, 14 Feb 2019 14:50:51 -0800
Subject: [PATCH 0/6] NVMe patches for kernel v5.1
Message-ID: <20190214225057.195397-1-bvanassche@acm.org>

Hi Christoph,

The patches in this series are what I came up with after having analyzed the
output of gcc W=1, sparse, smatch and blktests. Please consider these patches
for kernel v5.1.

Thanks,

Bart.

Bart Van Assche (6):
  nvmet: Fix indentation
  nvme-fabrics: Document the poll function argument
  nvme-pci: Check kstrtoint() return value in queue_count_set()
  nvme: Unexport nvme_delete_ctrl_sync()
  nvme: Introduce a helper function for controller deletion
  nvme: Avoid that deleting a controller triggers a circular locking
    complaint

 drivers/nvme/host/core.c        | 21 +++++++++++++--------
 drivers/nvme/host/fabrics.c     |  1 +
 drivers/nvme/host/nvme.h        |  1 -
 drivers/nvme/host/pci.c         |  2 ++
 drivers/nvme/target/discovery.c |  2 +-
 5 files changed, 17 insertions(+), 10 deletions(-)

-- 
2.21.0.rc0.258.g878e2cd30e-goog
