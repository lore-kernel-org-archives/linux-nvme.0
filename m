From: keith.busch@intel.com (Keith Busch)
Date: Wed,  3 Feb 2016 09:05:39 -0700
Subject: [PATCH 0/4] NVMe: Surprise removal fixes
Message-ID: <1454515543-21683-1-git-send-email-keith.busch@intel.com>

First on the 'dd' experiements, I did not find kernel that "worked"
as expected on a surprise removal. The IO process runs until SIGKILL
is recieved. I don't think that's right, and it causes noticable system
performance issues for unrelated tasks.

This series is just focusing on getting the driver to cleanup its part
so it can unbind from a controller.

Earlier feedback suggested this functionality be in the block layer. I
don't have the devices to test what happens with other drivers, and
the desired sequence seems unique to NVMe. Maybe that's an indication
that the driver's flow could benefit from some redesign, or maybe it's
an artifact from having the controller and storage being the same device.

In any case, I would like to isolate this fix to the NVMe driver in
the interest of time, and flush out the block layer before the next
merge window.

Keith Busch (4):
  NVMe: Fix io incapable return values
  NVMe: Sync stopped queues with block layer
  NVMe: Surprise removal fixes
  blk-mq: End unstarted requests on dying queue

 block/blk-mq.c           |  6 ++++--
 drivers/nvme/host/core.c | 14 ++++++++------
 drivers/nvme/host/nvme.h |  4 ++--
 drivers/nvme/host/pci.c  | 14 ++++++++++++++
 4 files changed, 28 insertions(+), 10 deletions(-)

-- 
2.6.2.307.g37023ba
