From: keith.busch@intel.com (Keith Busch)
Date: Wed,  6 Jun 2018 08:13:03 -0600
Subject: [PATCH 0/6] minor nvme fixes for 4.18
Message-ID: <20180606141309.19389-1-keith.busch@intel.com>

A series of unrelated trivial patches. More to come later, but I think
these are non-controversial ones.

Keith Busch (6):
  nvme-pci: Remove unnecessary nested locking
  nvme-pci: Remove unnecessary completion doorbell check
  nvme-pci: Queue creation fixes
  nvme-pci: Remove HMB teardown on reset
  nvme-pci: Unquiesce dead controller queues
  nvme-pci: Make CMB SQ mod-param read-only

 drivers/nvme/host/pci.c | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

-- 
2.14.3
