From: jonathan.derrick@intel.com (Jon Derrick)
Date: Wed, 30 Dec 2015 10:47:56 -0700
Subject: [PATCH 0/3] NVMe: Introduce CMB allocation scheme
Message-ID: <1451497679-1195-1-git-send-email-jonathan.derrick@intel.com>

Applies to Jens' for-4.5/nvme

This patchset changes the CMB allocation scheme. Instead of reserving
the entire range for SQes and automatically placing the SQes in the CMB,
this set creates sysfs knobs to manage it. This allows partial usage of
the CMB for SQes, so that the remainder can be mmapped or used for other
NVMe-defined CMB usages.

Jon Derrick (3):
  NVMe: Introduce sysfs entries for submission queues in CMB
  NVMe: Generate resource tree for CMB
  NVMe: Create CMB resource sysfs file

 drivers/nvme/host/core.c | 161 ++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h |  21 +++++
 drivers/nvme/host/pci.c  | 212 ++++++++++++++++++++++++++++++-----------------
 3 files changed, 313 insertions(+), 81 deletions(-)

-- 
2.1.4
