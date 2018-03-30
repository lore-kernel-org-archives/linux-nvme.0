From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Fri, 30 Mar 2018 02:57:39 -0400
Subject: [RFC PATCH 0/8] nvmet: implement target passthru commands support
Message-ID: <20180330065747.20962-1-chaitanya.kulkarni@wdc.com>

Hi,

This patchset implements NVMeOF target passthrough commands support.

In current implementation on the target side, NVMe command is mapped on the
block layer request which allows the target to use generic block device.

With the help of passthrough interface, it can now identify the NVMe controller
and allow the host to issue NVMe commands along with the VUCs on the
target side. For example with this feature, depending on the target controller
support host can issue namespace management commands,
Vendor unique commands etc.

The code is tested on the loopback target (nvme-loop) and cut against
the Linux 4.16-rc7 (tag v4.16-rc7).

Regards,
Chaitanya

Chaitanya Kulkarni (8):
  nvme-core: add new interfaces
  nvme-core: export existing ctrl and ns interfaces
  nvmet: add passthru members in target subsys
  nvmet: use const values for id-ctrl
  nvmet: export nvmet_add_async_event api
  nvmet: add target passthru command support
  nvmet: integrate passthru code with target core
  nvmet: add configfs interface for target passthru

 drivers/nvme/host/core.c           |  74 ++++++-
 drivers/nvme/host/nvme.h           |   9 +
 drivers/nvme/target/Makefile       |   2 +-
 drivers/nvme/target/admin-cmd.c    |   6 +-
 drivers/nvme/target/configfs.c     | 145 +++++++++++++-
 drivers/nvme/target/core.c         |  53 ++++-
 drivers/nvme/target/nvmet.h        |  17 ++
 drivers/nvme/target/passthru-cmd.c | 399 +++++++++++++++++++++++++++++++++++++
 8 files changed, 693 insertions(+), 12 deletions(-)
 create mode 100644 drivers/nvme/target/passthru-cmd.c

-- 
2.14.1
