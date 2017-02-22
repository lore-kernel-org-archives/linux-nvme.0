From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 22 Feb 2017 21:31:56 +0200
Subject: [GIT PULL] nvme patches for 4.11
Message-ID: <1487791916-25599-1-git-send-email-sagi@grimberg.me>

Hey Jens,

This pull-request includes:
- autonomous power state transitions from Andy
- nvme-rdma support for connecting via configurable source ip
- nvmet-rdma cleanups from Max
- nvme-fc cleanups from James
- quirk fixup for apple from Daniel
- various nvme-pci fixes from Keith
- expose nvme controller state via sysfs
- identify CNS fixup from Parav
- enforce fabrics implement ->create_ctrl callout from Johannes
- nvme-rdma fix goto tag from Christophe
- spelling fixup from Colin

Please pull from:

  git://git.infradead.org/nvme.git nvme-4.11

----------------------------------------------------------------
Andy Lutomirski (2):
      nvme: Add a quirk mechanism that uses identify_ctrl
      nvme: Enable autonomous power state transitions

Christophe JAILLET (1):
      nvmet-rdma: Fix error handling

Colin Ian King (1):
      nvme: admin-cmd: fix spelling mistake: "Counld" -> "Could"

Daniel Roschka (1):
      Detect NVMe controller in recent MacBooks

James Smart (2):
      nvmet_fc: cleanup of abort flag processing in fcp_op_done
      nvme-fc: don't bother to validate ioccsz and iorcsz

Johannes Thumshirn (1):
      nvme: make nvmf_register_transport require a create_ctrl callback

Keith Busch (5):
      nvme/pci: Disable on removal when disconnected
      nvme/core: Fix race kicking freed request_queue
      nvme/pci: No special case for queue busy on IO
      nvme/pci: Cancel work after watchdog disabled
      Revert "nvme/pci: Cancel work after watchdog disabled"

Max Gurtovoy (5):
      nvmet: avoid dereferencing nvmet_req
      nvme: add semicolon in nvme_command setting
      nvme-rdma: move nvme cm status helper to .h file
      nvmet-rdma: use nvme cm status helper
      nvme-rdma: add support for host_traddr

Parav Pandit (1):
      nvme: Use CNS as 8-bit field and avoid endianness conversion

Sagi Grimberg (2):
      nvmet: Make cntlid globally unique
      nvme: Make controller state visible via sysfs

 drivers/nvme/host/core.c          | 257 ++++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/fabrics.c       |   7 +-
 drivers/nvme/host/fabrics.h       |   2 +-
 drivers/nvme/host/fc.c            |  15 +--
 drivers/nvme/host/nvme.h          |  12 ++
 drivers/nvme/host/pci.c           |  11 +-
 drivers/nvme/host/rdma.c          |  48 ++++---
 drivers/nvme/target/admin-cmd.c   |   4 +-
 drivers/nvme/target/core.c        |  10 +-
 drivers/nvme/target/discovery.c   |   4 +-
 drivers/nvme/target/fabrics-cmd.c |   6 +-
 drivers/nvme/target/fc.c          |   8 +-
 drivers/nvme/target/loop.c        |   3 +-
 drivers/nvme/target/nvmet.h       |   1 -
 drivers/nvme/target/rdma.c        |   7 +-
 include/linux/nvme-rdma.h         |  24 ++++
 include/linux/nvme.h              |  10 +-
 17 files changed, 349 insertions(+), 80 deletions(-)
