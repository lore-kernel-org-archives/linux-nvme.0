From: keith.busch@intel.com (Keith Busch)
Date: Mon, 24 Mar 2014 10:46:24 -0600
Subject: [PATCH 0/2] NVMe: Per CPU stuff
Message-ID: <1395679586-13410-1-git-send-email-keith.busch@intel.com>

Resending after merging latest tree.

Keith Busch (2):
  NVMe: per-cpu io queues
  NVMe: CPU hot plug notification

 drivers/block/nvme-core.c |  220 +++++++++++++++++++++++++++++++++++++--------
 include/linux/nvme.h      |    7 +-
 2 files changed, 190 insertions(+), 37 deletions(-)

-- 
1.7.10.4
