From: keith.busch@intel.com (Keith Busch)
Date: Tue, 12 Jan 2016 14:41:16 -0700
Subject: [PATCH 0/2] NVMe updates
Message-ID: <1452634878-31125-1-git-send-email-keith.busch@intel.com>

These are the last two with the folded in suggestions from reviewers.

The first 3 patches in the series are still here, and some of this based
on updates from Christoph and Sagi.

  http://lists.infradead.org/pipermail/linux-nvme/2016-January/003561.html

Keith Busch (2):
  NVMe: IO queue deletion re-write
  NVMe: Shutdown controller only for power-off

 drivers/nvme/host/pci.c | 291 +++++++++++++++++-------------------------------
 1 file changed, 100 insertions(+), 191 deletions(-)

-- 
2.6.2.307.g37023ba
