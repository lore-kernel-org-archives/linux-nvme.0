From: keith.busch@intel.com (Keith Busch)
Date: Wed, 30 Dec 2015 10:27:46 -0700
Subject: [PATCH 0/5] NVMe fixes and updates for 4.5
Message-ID: <1451496471-29370-1-git-send-email-keith.busch@intel.com>

This is based on linux-block/for-next.

The first two fix a couple minor issues not caught in initial review or
testing for some larger recent patch sets.

The biggest is 5/5. It simplifies IO queue deletion and removes some
of the most unnecessarily complicated code in this driver. If you're
wondering why the new code is so far away from the code it replaces,
this was the closest I could get it and produce a readable diff. :)

Keith Busch (5):
  NVMe: Fix admin queue ring wrap
  NVMe: Use a retryable error code on reset
  NVMe: Remove queue freezing on resets
  NVMe: Shutdown controller only for power-off
  NVMe: IO queue deletion re-write

 drivers/nvme/host/pci.c | 315 +++++++++++++++++-------------------------------
 1 file changed, 113 insertions(+), 202 deletions(-)

-- 
2.6.2.307.g37023ba
