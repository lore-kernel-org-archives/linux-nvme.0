From: keith.busch@intel.com (Keith Busch)
Date: Thu, 31 Dec 2015 09:41:51 -0700
Subject: [PATCHv2 0/5] NVMe fixes and updates, version 2
Message-ID: <1451580116-12252-1-git-send-email-keith.busch@intel.com>

Changes since v1:

  Fixed the patch order. Previously 4/5 and 5/5 were swapped.

  Added a code comment to make the clarify the queue full condition.

  Better commit log messages.

  Moved the "struct completion" from an nvme_queue union to struct nvme_dev.

  Simplified the shutdown patch based on review comments. The logic is
  pushed into a single admin queue handling function, and the result is
  more understandable.

There are suggestions for other mechanisms to handle async io queue
deletion (patch 4/5, previously 5/5), but I'm sticking with the original
idea this time. I'll spin another patch if the alternate proposals compel
new version.

Keith Busch (5):
  NVMe: Fix admin queue ring wrap
  NVMe: Use a retryable error code on reset
  NVMe: Remove queue freezing on resets
  NVMe: IO queue deletion re-write
  NVMe: Shutdown controller only for power-off

 drivers/nvme/host/pci.c | 314 +++++++++++++++++-------------------------------
 1 file changed, 112 insertions(+), 202 deletions(-)

-- 
2.6.2.307.g37023ba
