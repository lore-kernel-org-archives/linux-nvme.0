From: keith.busch@intel.com (Keith Busch)
Date: Wed, 24 Feb 2016 09:15:51 -0700
Subject: [PATCHv4-4.5 0/7] Rebased fixes
Message-ID: <1456330558-819-1-git-send-email-keith.busch@intel.com>

This rebases the hot plug fixes to the current linux-block/for-linus,
folds in the review comments, a couple minor fixes (described in the
individual patches), reorders the series to minimize churn, and squashes
two previous patches for "namespace removal deadlock"; the two separate
patches weren't really useful on their own.

The last two patches are not hot-plug related, but fix kernel crashes
from user misuse/abuse of the passthru interface. These were already
posted separatedly, but they are included in this series to complete
everything I believe includes all important fixes I know about for 4.5.

Keith Busch (7):
  NVMe: Don't unmap controller registers on reset
  NVMe: Use IDA for namespace disk naming
  NVMe: Fix namespace removal deadlock
  NVMe: Simplify device reset failure
  NVMe: Move error handling to failed reset handler
  NVMe: Don't allow unsupported flags
  NVMe: Fix 0-length integrity payload

 drivers/nvme/host/core.c |  81 ++++++++++++++++++--------
 drivers/nvme/host/nvme.h |   8 +++
 drivers/nvme/host/pci.c  | 149 ++++++++++++++++++++++++++++-------------------
 3 files changed, 156 insertions(+), 82 deletions(-)

-- 
2.6.2.307.g37023ba
