From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 28 Jun 2017 10:01:27 +0300
Subject: [GIT PULL] some more early nvme patches for kernel 4.13
Message-ID: <1498633287-451-1-git-send-email-sagi@grimberg.me>

Hey Jens,

Another round of early patches for 4.13 to spend some time
in linux-next.

This includes:
- finally remove SCSI translations from Kieth 
- NQN handling fixes from Christoph
- several nvme(t)-fc fixes from James
- expose hostid configure knob to userspace from Johannes
- APST disable quirks from Kai-Heng Feng
- nvme-pci process_cq refactoring from me
- relax NVME_AQ_DEPTH to 32 and share it in fabrics and pci from me
- fix nvmet-rdma surprise device removal handling

please consider pulling from:

  git://git.infradead.org/nvme.git nvme-4.13

It's rebased on top of your for-next (2c4a9e73b3c6).

Thanks!

----------------------------------------------------------------
Christoph Hellwig (4):
      nvme: remove a misleading comment on struct nvme_ns
      nvme: read the subsystem NQN from Identify Controller
      nvme: simplify nvme_dev_attrs_are_visible
      nvme-fabrics: verify that a controller returns the correct NQN

James Smart (5):
      nvme_fc: fix double calls to nvme_cleanup_cmd()
      nvme_fc: replace ioabort msleep loop with completion
      nvme_fc: Fix crash when nvme controller connection fails.
      nvmet_fc: fix crashes on bad opcodes
      nvme_fc: fix error recovery on link down.

Johannes Thumshirn (1):
      nvme: add hostid token to fabric options

Kai-Heng Feng (1):
      nvme: explicitly disable APST on quirked devices

Keith Busch (1):
      nvme: Remove SCSI translations

Sagi Grimberg (6):
      nvme-pci: Introduce nvme_ring_cq_doorbell
      nvme-pci: factor out cqe handling into a dedicated routine
      nvme-pci: factor out the cqe reading mechanics from __nvme_process_cq
      nvme-pci: open-code polling logic in nvme_poll
      nvme: use a single NVME_AQ_DEPTH and relax it to 32
      nvmet-rdma: register ib_client to not deadlock in device removal

 drivers/nvme/host/Kconfig       |   12 -
 drivers/nvme/host/core.c        |  121 +-
 drivers/nvme/host/fabrics.c     |   49 +-
 drivers/nvme/host/fabrics.h     |    2 +-
 drivers/nvme/host/fc.c          |   32 +-
 drivers/nvme/host/nvme.h        |   20 +-
 drivers/nvme/host/pci.c         |  131 ++-
 drivers/nvme/host/rdma.c        |   11 +-
 drivers/nvme/host/scsi.c        | 2460 ---------------------------------------
 drivers/nvme/target/discovery.c |    2 +-
 drivers/nvme/target/fc.c        |   10 +-
 drivers/nvme/target/loop.c      |    5 +-
 drivers/nvme/target/rdma.c      |  102 +-
 include/linux/nvme.h            |    2 +-
 14 files changed, 249 insertions(+), 2710 deletions(-)
 delete mode 100644 drivers/nvme/host/scsi.c
