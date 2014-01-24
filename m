From: keith.busch@intel.com (Keith Busch)
Date: Fri, 24 Jan 2014 16:50:47 -0700
Subject: [PATCH 0/7] Fixes and improvements
Message-ID: <1390607454-23273-1-git-send-email-keith.busch@intel.com>

Starts off the same as this one:

http://merlin.infradead.org/pipermail/linux-nvme/2014-January/000624.html

... then I kept adding more stuff and revived the percpu optimization
and hot cpu stuff and think it's in good shape.

If you want to test hot cpu, this linux-nvme tree is broken due to bad
timing on the merge from upstream during 3.13rc and merged in a scheduler
bug, so will need merge upstream or at the very least cherry-pick these:

2cce5600486 sched: Avoid NULL dereference on sd_busy
a53cb752016 sched: Assign correct scheduling domain to 'sd_llc'

Keith Busch (7):
  NVMe: Namespace use after free on surprise removal
  NVMe: RCU access to nvme_queue
  NVMe: Initialization clean-up
  NVMe: Clean-up character device bring-up
  NVMe: Per-cpu IO queues
  NVMe: CPU hot plug notification
  NVMe: Share interrupt vectors among IO queues

 drivers/block/nvme-core.c |  377 +++++++++++++++++++++++++++++++++------------
 include/linux/nvme.h      |   11 +-
 2 files changed, 289 insertions(+), 99 deletions(-)

-- 
1.7.10.4
