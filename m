From: keith.busch@intel.com (Keith Busch)
Date: Thu, 26 Apr 2018 15:49:54 -0600
Subject: [PATCH 0/2] nvme multipath naming fixes
Message-ID: <20180426214956.3377-1-keith.busch@intel.com>

This is the update to the mpath naming conclict as discussed in thread:

http://lists.infradead.org/pipermail/linux-nvme/2018-April/016820.html

Keith Busch (2):
  nvme/multipath: Disable runtime writable enabling parameter
  nvme/multipath: Fix multipath disabled naming collisions

 drivers/nvme/host/core.c      | 26 +-------------------------
 drivers/nvme/host/multipath.c | 24 +++++++++++++++++++++++-
 drivers/nvme/host/nvme.h      | 12 ++++++++++++
 3 files changed, 36 insertions(+), 26 deletions(-)

-- 
2.14.3
