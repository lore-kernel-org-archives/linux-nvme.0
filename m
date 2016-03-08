From: jonathan.derrick@intel.com (Jon Derrick)
Date: Tue,  8 Mar 2016 10:34:52 -0700
Subject: [PATCH 0/2] Some performance fixes for fastpath
Message-ID: <1457458494-10550-1-git-send-email-jonathan.derrick@intel.com>

This is a small set of hopefully uncontroversial, performance-related
patches. Local testing on new hardware showed a 5-10MBps increase in
4k and 1M sequential synchronous null reads from an NVMe device.

Jon Derrick (2):
  Block: Disable polling stats when iostats are disabled
  NVMe: Remove unused sq_head read in completion path

 block/blk-core.c        | 7 +++++--
 drivers/nvme/host/pci.c | 2 --
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
1.8.3.1
