From: rakesh@tuxera.com (Rakesh Pandit)
Date: Mon, 29 May 2017 09:28:25 +0300
Subject: [PATCH 0/1] nvme: fix nvme_remove going to uninterruptible sleep for
 ever
Message-ID: <20170529062823.GA6462@hercules.tuxera.com>

This patches fixes the controller removal going to sleep for ever
without completion.  Also as a side-effect if this patch:
https://patchwork.kernel.org/patch/9740945/ goes throw which takes a
dev lock before calling reset from PCI layer would deadlock if a
successive call happens to land for same device as first call hasn't
finished.

Rakesh Pandit (1):
  nvme: fix nvme_remove going to uninterruptible sleep for ever

 drivers/nvme/host/core.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.9.3
