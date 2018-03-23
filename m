From: keith.busch@intel.com (Keith Busch)
Date: Fri, 23 Mar 2018 14:21:12 -0600
Subject: [GIT PULL] nvme-4.17
Message-ID: <20180323202111.GM12909@localhost.localdomain>

Hi Jens,

This is the first nvme pull request for 4.17, mostly cleanups and bug
fixes across the spectrum with a few minor new features.

There are two patches outside the nvme subsystem to support fabrics.
I believe Sagi has the 'ok' to go through here, but I've Cc'ed those
maintainers just in case.

Otherwise there shouldn't be anything controversial here, and merges
clean with linux-block/for-next.

There is a trivial conflict merging Linus' upstream due to the late nvme
patch 8a30ecc6e0 (Revert "nvme: create 'slaves' and 'holders'..."). For
reference, a merge conflict resolution branch is here:

  git://git.infradead.org/nvme.git nvme-4.17-conflict-resolution

The following changes since commit f168127a96c55844011e79344322ac317844803a:

  Merge branch 'for-4.17/block' into for-next (2018-03-01 08:38:06 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.17

for you to fetch changes up to 90f99ee371c665bb019efffa0e20afd15a37f661:

  nvme: make nvme_get_log_ext non-static (2018-03-21 12:49:41 -0600)

----------------------------------------------------------------
Christoph Hellwig (2):
      nvmet: refactor configfs transport type handling
      nvmet: constify struct nvmet_fabrics_ops

Israel Rukshin (2):
      nvmet-rdma: Remove unused queue state
      nvmet-rdma: Fix use after free in nvmet_rdma_cm_handler()

James Smart (5):
      nvme_fc: fix ctrl create failures racing with workq items
      nvme_fc: io timeout should defer abort to ctrl reset
      nvme_fc: fix abort race on teardown with lld reject
      nvme_fc: on remoteport reuse, set new nport_id and role.
      nvmet_fc: prevent new io rqsts in possible isr completions

Jaros?aw Janik (1):
      nvme-pci: disable APST for Samsung NVMe SSD 960 EVO + ASUS PRIME Z370-A

Jianchao Wang (3):
      nvme-pci: quiesce IO queues prior to disabling device HMB accesses
      nvme: fix the dangerous reference of namespaces list
      nvme: change namespaces_mutext to namespaces_rwsem

Keith Busch (2):
      nvme-pci: Add .get_address ctrl callback
      nvme: Skip checking heads without namespaces

Matias Bj?rling (2):
      nvme: implement log page low/high offset and dwords
      nvme: make nvme_get_log_ext non-static

Max Gurtovoy (4):
      nvme: centralize ctrl removal prints
      nvmet-rdma: Don't flush system_wq by default during remove_one
      nvme-rdma: Don't flush delete_wq by default during remove_one
      nvmet: move device_uuid configfs attr definition to suitable place

Minwoo Im (1):
      nvme: use define instead of magic value for identify size

Nitzan Carmi (2):
      nvme-rdma: Allow DELETING state change failure in error_recovery
      nvme: Add .stop_ctrl to nvme ctrl ops

Sagi Grimberg (3):
      net/utils: Introduce inet_addr_is_any
      nvmet: don't return "any" ip address in discovery log page
      iscsi-target: use common inet_addr_is_any

Thomas Tai (2):
      nvme: Add fault injection feature
      Documentation: nvme: Documentation for nvme fault injection

 Documentation/fault-injection/fault-injection.txt  |   8 ++
 .../fault-injection/nvme-fault-injection.txt       | 116 ++++++++++++++++++++
 drivers/nvme/host/Makefile                         |   1 +
 drivers/nvme/host/core.c                           | 117 +++++++++++++--------
 drivers/nvme/host/fault_inject.c                   |  79 ++++++++++++++
 drivers/nvme/host/fc.c                             |  36 +++----
 drivers/nvme/host/multipath.c                      |   4 +-
 drivers/nvme/host/nvme.h                           |  33 +++++-
 drivers/nvme/host/pci.c                            |  24 +++--
 drivers/nvme/host/rdma.c                           |  34 ++++--
 drivers/nvme/target/configfs.c                     |  65 ++++++------
 drivers/nvme/target/core.c                         |  12 +--
 drivers/nvme/target/discovery.c                    |  30 +++++-
 drivers/nvme/target/fc.c                           |  23 +++-
 drivers/nvme/target/loop.c                         |   4 +-
 drivers/nvme/target/nvmet.h                        |  12 ++-
 drivers/nvme/target/rdma.c                         |  72 +++++++++----
 drivers/target/iscsi/iscsi_target.c                |  28 +----
 include/linux/inet.h                               |   1 +
 net/core/utils.c                                   |  23 ++++
 20 files changed, 537 insertions(+), 185 deletions(-)
 create mode 100644 Documentation/fault-injection/nvme-fault-injection.txt
 create mode 100644 drivers/nvme/host/fault_inject.c
