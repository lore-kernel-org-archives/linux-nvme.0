From: hare@suse.de (Hannes Reinecke)
Date: Fri, 26 Oct 2018 14:57:15 +0200
Subject: [PATCHv2 0/3] nvme: NUMA locality for fabrics
Message-ID: <20181026125718.122767-1-hare@suse.de>

Hi all,

here's a patchset to leverage NUMA locality information for fabric controllers.
This is the second attempt for doing so; after discussion with hch we came
to the conclusion that the attempt in the initial submission with a manual
configuration would only lead to more confusion and suboptimal configuration.

So here's now a version with an automatic NUMA balancing, where we attempt
to split the number submitting CPUs/cores evenly across the available
controller.

With this patchset I'm seeing a performance increase from
262k IOPS to 344k IOPS, measured against a NetApp AF700.

As usual, comments and reviews are welcome.

Hannes Reinecke (3):
  nvme: NUMA locality information for fabrics
  nvme-multipath: Select paths based on NUMA locality
  nvme-multipath: automatic NUMA path balancing

 drivers/nvme/host/core.c      |  41 +++++++++++++-
 drivers/nvme/host/fc.c        |   5 +-
 drivers/nvme/host/multipath.c | 122 ++++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h      |   3 ++
 drivers/nvme/host/pci.c       |   2 +-
 drivers/nvme/host/rdma.c      |   6 ++-
 6 files changed, 169 insertions(+), 10 deletions(-)

-- 
2.16.4
