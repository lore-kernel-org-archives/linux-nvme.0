From: keith.busch@intel.com (Keith Busch)
Date: Mon,  4 Jan 2016 09:10:54 -0700
Subject: [PATCHv3 0/5] NVMe fixes and updates, v3
Message-ID: <1451923859-14187-1-git-send-email-keith.busch@intel.com>

This new version just merges up with the latest from Christoph and Sagi.

I guess 4/5 is still controversial, but confident it will make sense
when the failure cases are exercised.

Keith Busch (5):
  NVMe: Fix admin queue ring wrap
  NVMe: Use a retryable error code on reset
  NVMe: Remove queue freezing on resets
  NVMe: IO queue deletion re-write
  NVMe: Shutdown controller only for power-off

 drivers/nvme/host/core.c |   7 +-
 drivers/nvme/host/nvme.h |   4 +-
 drivers/nvme/host/pci.c  | 307 +++++++++++++++++------------------------------
 3 files changed, 114 insertions(+), 204 deletions(-)

-- 
2.6.2.307.g37023ba
