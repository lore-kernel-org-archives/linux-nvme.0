From: keith.busch@intel.com (Keith Busch)
Date: Fri, 16 Aug 2013 16:00:27 -0600
Subject: [PATCHv2 0/5] NVMe: Controller reset and shutdown
Message-ID: <1376690432-9775-1-git-send-email-keith.busch@intel.com>

More controller reset handling. Fixes a couple errors and adds more
conditions that have come up that require this kind of thing.

Again, it relies on this patch set here:
http://merlin.infradead.org/pipermail/linux-nvme/2013-July/000331.html

Keith Busch (5):
  NVMe: Reset failed controller
  NVMe: User initiated controller reset
  NVMe: Reset controller on timed out commands
  NVMe: Don't wait for delete queues to finish
  NVMe: Add shutdown pci callback

 drivers/block/nvme-core.c |   90 +++++++++++++++++++++++++++++++++++++++------
 include/linux/nvme.h      |    1 +
 2 files changed, 79 insertions(+), 12 deletions(-)

-- 
1.7.10.4
