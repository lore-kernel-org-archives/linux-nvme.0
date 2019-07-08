From: mskorzhinskiy@solarflare.com (Mikhail Skorzhinskii)
Date: Mon, 8 Jul 2019 13:53:24 +0200
Subject: [PATCH v2 0/2] Miscellaneous changes for nvme-tcp v2
Message-ID: <cover.1562586804.git.mskorzhinskiy@solarflare.com>

A few unrelated changes for NVMoF subsystem, that was found during testing
of NVMoF TCP.

patch 2: found during extensive testing on various filesystems
patch 3: found during testing on debug kernels with VM_DEBUG enabled

v2
  - Moved hint patch as separate patch;
  - Fix commit description in stable writes patch;
  - Simplify check for SLAB check;
  - Remove unnecessary replacments of sendpage calls;

Mike Playle (1):
  nvme-tcp: set the STABLE_WRITES flag when data digests are enabled

Mikhail Skorzhinskii (1):
  nvme-tcp: don't use sendpage for SLAB pages

 drivers/nvme/host/core.c | 5 +++++
 drivers/nvme/host/tcp.c  | 7 ++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.16.4
