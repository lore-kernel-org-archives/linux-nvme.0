From: mheyne@amazon.de (Maximilian Heyne)
Date: Wed, 3 Apr 2019 12:35:04 +0000
Subject: [PATCH v2 0/2] Adding per-controller timeout support to nvme
Message-ID: <20190403123506.122904-1-mheyne@amazon.de>

As different nvme controllers are connect via different fabrics, some require
different timeout settings than others. This series implements per-controller
timeouts in the nvme subsystem which can be set via sysfs.

We have reached out to the NVMe working group to implement per-controller
timeout values. These patches are paving the way for this.

Changes since v1:
- implement the change not only for the pci NVMe driver but also for fc,
  lightnvm, rdma, tcp and loop.
- add an additional check when updating timeouts to not race with controller
  creation or deletion

Maximilian Heyne (2):
  nvme: add per-controller io and admin timeouts
  nvme: add sysfs controls for io and admin timeouts

 drivers/nvme/host/core.c     | 123 +++++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/fc.c       |   2 +-
 drivers/nvme/host/lightnvm.c |   2 +-
 drivers/nvme/host/nvme.h     |   2 +
 drivers/nvme/host/pci.c      |  13 ++---
 drivers/nvme/host/rdma.c     |   4 +-
 drivers/nvme/host/tcp.c      |   4 +-
 drivers/nvme/target/loop.c   |   4 +-
 8 files changed, 136 insertions(+), 18 deletions(-)

-- 
2.16.5




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrer: Christian Schlaeger, Ralf Herbrich
Ust-ID: DE 289 237 879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
