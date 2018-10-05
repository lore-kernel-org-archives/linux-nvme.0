From: hare@suse.de (Hannes Reinecke)
Date: Fri,  5 Oct 2018 11:29:13 +0200
Subject: [PATCH 0/2] nvme: NUMA locality for fabrics
Message-ID: <20181005092915.126636-1-hare@suse.de>

Hi all,

[Resend, as I forgot to include the nvme ml]

here's a patchset to leverage NUMA locality information for fabric controllers.
As there are systems for which no 'best' configuration exists (eg a symmetric
NUMA machine with 4 nodes and 2 HBAs) it also exports the node mapping to
sysfs so that the admin can tweak them to achieve best performance.

With this patchset I'm seeing a performance increase from
262k IOPS to 344k IOPS, measured against a NetApp AF700.

As usual, comments and reviews are welcome.

Hannes Reinecke (2):
  nvme: NUMA locality information for fabrics
  nvme-multipath: manual NUMA configuration

 drivers/nvme/host/core.c      | 68 +++++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/fc.c        |  5 ++--
 drivers/nvme/host/multipath.c | 11 +++++--
 drivers/nvme/host/nvme.h      |  3 ++
 drivers/nvme/host/pci.c       |  2 +-
 drivers/nvme/host/rdma.c      |  6 ++--
 6 files changed, 85 insertions(+), 10 deletions(-)

-- 
2.16.4
