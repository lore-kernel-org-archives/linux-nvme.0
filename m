From: keith.busch@intel.com (Keith Busch)
Date: Wed,  7 Aug 2013 14:44:45 -0600
Subject: [PATCH 0/2] NVMe: Controller resets
Message-ID: <1375908287-18884-1-git-send-email-keith.busch@intel.com>

Some controller reset action. These depend on this patch set here:

http://merlin.infradead.org/pipermail/linux-nvme/2013-July/000331.html

Keith Busch (2):
  NVMe: Reset failed controller
  NVMe: User initiated controller reset

 drivers/block/nvme-core.c |   43 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/nvme.h      |    1 +
 2 files changed, 43 insertions(+), 1 deletion(-)

-- 
1.7.10.4
