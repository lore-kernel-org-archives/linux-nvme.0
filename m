From: keith.busch@intel.com (Keith Busch)
Date: Tue, 10 Dec 2013 13:10:35 -0700
Subject: [PATCH 0/5] Controller error handling set
Message-ID: <1386706240-2300-1-git-send-email-keith.busch@intel.com>

Additional handling for nvme device errors. I've submitted patches along
these lines in the past, but this is better tested against hot-plug capable
platforms and low power state transitions.

Obsoletes these:
http://merlin.infradead.org/pipermail/linux-nvme/2013-October/000563.html
http://merlin.infradead.org/pipermail/linux-nvme/2013-October/000566.html

Keith Busch (5):
  NVMe: Device resume error handling
  NVMe: Schedule reset for failed controllers
  NVMe: Abort timed out commands
  NVMe: Surprise removal handling
  NVMe: Async IO queue deletion

 drivers/block/nvme-core.c |  433 +++++++++++++++++++++++++++++++++++++++++----
 include/linux/nvme.h      |    3 +
 include/uapi/linux/nvme.h |   11 ++
 3 files changed, 416 insertions(+), 31 deletions(-)

-- 
1.7.10.4
