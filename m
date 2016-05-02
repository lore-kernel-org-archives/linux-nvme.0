From: keith.busch@intel.com (Keith Busch)
Date: Mon,  2 May 2016 11:12:05 -0600
Subject: Patches for 4.7
Message-ID: <1462209128-12376-1-git-send-email-keith.busch@intel.com>

Just a collection of small and unrelated patches.

Keith Busch (3):
  NVMe: Return ENODEV error on invalid namespace
  NVMe: Short-cut removal on surprise hot-unplug
  NVMe: Set capacity to 0 on all unusable namespaces

 drivers/nvme/host/core.c | 36 ++++++++++++++++++++++++------------
 drivers/nvme/host/nvme.h |  3 +++
 drivers/nvme/host/pci.c  |  8 ++++++--
 3 files changed, 33 insertions(+), 14 deletions(-)

-- 
2.7.2
