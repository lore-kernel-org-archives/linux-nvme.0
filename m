From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 20 Sep 2017 14:29:28 -0700
Subject: [GIT PULL] nvme fixes for 4.14-rc2
Message-ID: <20170920212928.wfzm34jajrpzmmdy@infradead.org>

Hi Jens,

a couple nvme fixes for -rc2 are below:

 - fixes for the Fibre Channel host/target to fix spec compliance
 - allow a zero keep alive timeout
 - make the debug printk for broken SGLs work better
 - fix queue zeroing during initialization

The following changes since commit da357321837921f52c386f2123c6718443fbb844:

  bsg-lib: don't free job in bsg_prepare_job (2017-09-14 22:32:03 -0600)

are available in the git repository at:

  ssh://git.infradead.org/srv/git/nvme.git nvme-4.14

for you to fetch changes up to f48b6b902ead0f3a1b5cfb0d157cc022f676de94:

  nvmet: implement valid sqhd values in completions (2017-09-20 10:52:40 -0700)

----------------------------------------------------------------
Guilherme G. Piccoli (1):
      nvme-fabrics: Allow 0 as KATO value

James Smart (12):
      nvme-fc: remove use of FC-specific error codes
      nvmet-fc: remove use of FC-specific error codes
      nvmet-fcloop: remove use of FC-specific error codes
      lpfc: remove use of FC-specific error codes
      qla2xxx: remove use of FC-specific error codes
      nvme.h: remove FC transport-specific error values
      nvme: add transport SGL definitions
      nvme-fc: use transport-specific sgl format
      nvmet-fc: fix failing max io queue connections
      nvme: stop aer posting if controller state not live
      nvme: allow timed-out ios to retry
      nvmet: implement valid sqhd values in completions

Keith Busch (2):
      nvme-pci: initialize queue memory before interrupts
      nvme-pci: Print invalid SGL only once

 drivers/nvme/host/core.c          |  7 +++----
 drivers/nvme/host/fabrics.c       | 18 +++++++++---------
 drivers/nvme/host/fc.c            | 21 +++++++++++----------
 drivers/nvme/host/pci.c           | 34 ++++++++++++++++++++--------------
 drivers/nvme/target/core.c        |  8 ++++----
 drivers/nvme/target/fabrics-cmd.c |  9 +++++++--
 drivers/nvme/target/fc.c          | 15 ++++++---------
 drivers/nvme/target/fcloop.c      |  2 +-
 drivers/nvme/target/nvmet.h       |  1 +
 drivers/scsi/lpfc/lpfc_nvme.c     |  2 +-
 drivers/scsi/qla2xxx/qla_nvme.c   |  2 +-
 include/linux/nvme.h              | 19 ++++++-------------
 12 files changed, 70 insertions(+), 68 deletions(-)
