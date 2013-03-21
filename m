From: keith.busch@intel.com (Keith Busch)
Date: Thu, 21 Mar 2013 11:52:00 -0600
Subject: [PATCH v2 0/7] NVMe Data Integrity Extensions
Message-ID: <1363888327-7420-1-git-send-email-keith.busch@intel.com>

This patch set adds data integrity extensions to NVMe. Contrast with
the previous patch attempt, this makes some modifications to sd_dif
to export the template so a block driver can make use of it instead of
copying it. There are more namespace block formats possible than what is
available in SCSI, so I had to make some modifications to the integrity
code to take this into account. I hope that's okay.

Keith Busch (7):
  sd: remove invalid ref tag check
  sd: skip verifying unwritten sectors
  sd: hw sector size calculation
  sd: arbitrary dif meta-data sizes
  sd: export dif integrity template
  NVMe: Split non-mergeable bio requests
  NVMe: End-to-end data protection

 drivers/block/nvme.c   |  277 ++++++++++++++++++++++++++++++++++++++++++------
 drivers/scsi/sd_dif.c  |  144 ++++++++++++++++---------
 fs/bio-integrity.c     |   19 ++--
 include/linux/blkdev.h |   10 ++-
 include/linux/nvme.h   |   28 ++++-
 5 files changed, 378 insertions(+), 100 deletions(-)
