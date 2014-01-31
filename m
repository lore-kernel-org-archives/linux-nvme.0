From: keith.busch@intel.com (Keith Busch)
Date: Fri, 31 Jan 2014 16:53:38 -0700
Subject: [PATCHv2 0/4] IO Queue fixes rewrite
Message-ID: <1391212422-14764-1-git-send-email-keith.busch@intel.com>

New set replacing this one:

http://merlin.infradead.org/pipermail/linux-nvme/2014-January/000656.html

I narrowed this set down to only the surprise removal fixes and the io
queue/cpu mapping. The cosmetic and irq vector patches from the previous
set can wait.

The only patch different in v2 from the previous is the "Per-cpu IO
queues". The feedback on using the per cpu variable to point to an index
rather than a struct nvme_queue pointer was a great idea!

I only included all 4 in this set because I wanted to make sure they
apply cleanly against the new tree.

I also ran sparse this time; I've exceeded my fair share of sparse errors
working on this driver. :)

Keith Busch (4):
  NVMe: Namespace use after free on surprise removal
  NVMe: RCU access to nvme_queue
  NVMe: Per-cpu IO queues
  NVMe: CPU hot plug notification

 drivers/block/nvme-core.c |  314 ++++++++++++++++++++++++++++++++++-----------
 include/linux/nvme.h      |    9 +-
 2 files changed, 247 insertions(+), 76 deletions(-)

-- 
1.7.10.4
