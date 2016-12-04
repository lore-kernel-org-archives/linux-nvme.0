From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon,  5 Dec 2016 00:02:06 +0200
Subject: [GIT PULL] nvme fabrics patches for 4.10
Message-ID: <1480888926-19235-1-git-send-email-sagi@grimberg.me>

Hey Jens,

The major addition here is the nvme FC transport implementation
from James.

What else:
- some cleanups and memory leak fixes in the host side fabrics code from Bart
- possible rcu violation fix from Sasha
- logging change from Max
- small include cleanup

Please pull from:

  git://git.infradead.org/nvme-fabrics.git nvmf-4.10

----------------------------------------------------------------
Bart Van Assche (5):
      nvmet-rdma: Fix REJ status code
      nvme-fabrics: Fix memory leaks in nvmf_parse_options()
      nvme-fabrics: Fix a memory leak in an nvmf_create_ctrl() error path
      nvme/scsi: Remove set-but-not-used variables
      nvme-fabrics: Adjust source code indentation

James Smart (10):
      parser: add u64 number parser
      nvme-fabrics: set sqe.command_id in core not transports
      nvme-fabrics: patch target code in prep for FC transport support
      Add type 0x28 NVME type code to scsi fc headers
      nvme-fabrics: Add FC transport error codes to nvme.h
      nvme-fabrics: Add FC transport FC-NVME definitions
      nvme-fabrics: Add FC transport LLDD api definitions
      nvme-fabrics: Add host support for FC transport
      nvme-fabrics: Add target support for FC transport
      nvme-fabrics: Add FC LLDD loopback driver to test FC-NVME

Max Gurtovoy (2):
      nvmet-rdma: align to generic ib_event logging helper
      nvme-rdma: align to generic ib_event logging helper

Sagi Grimberg (1):
      nvme-rdma: remove redundant define

Samuel Jones (1):
      nvme-rdma: force queue size to respect controller capability

Solganik Alexander (1):
      nvmet: Fix possible infinite loop triggered on hot namespace removal

 MAINTAINERS                    |   10 +
 drivers/nvme/host/Kconfig      |   17 +
 drivers/nvme/host/Makefile     |    3 +
 drivers/nvme/host/core.c       |    3 +-
 drivers/nvme/host/fabrics.c    |    7 +-
 drivers/nvme/host/fc.c         | 2586 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/pci.c        |    1 -
 drivers/nvme/host/rdma.c       |   14 +-
 drivers/nvme/host/scsi.c       |   11 +-
 drivers/nvme/target/Kconfig    |   24 +
 drivers/nvme/target/Makefile   |    4 +
 drivers/nvme/target/configfs.c |   20 +-
 drivers/nvme/target/core.c     |   14 +-
 drivers/nvme/target/fc.c       | 2288 +++++++++++++++++++++++++++++++++++
 drivers/nvme/target/fcloop.c   | 1148 ++++++++++++++++++
 drivers/nvme/target/loop.c     |    1 -
 drivers/nvme/target/nvmet.h    |    6 +-
 drivers/nvme/target/rdma.c     |    8 +-
 include/linux/nvme-fc-driver.h |  851 +++++++++++++
 include/linux/nvme-fc.h        |  268 +++++
 include/linux/nvme.h           |   13 +
 include/linux/parser.h         |    1 +
 include/uapi/scsi/fc/fc_fs.h   |    2 +
 lib/parser.c                   |   47 +
 24 files changed, 7313 insertions(+), 34 deletions(-)
 create mode 100644 drivers/nvme/host/fc.c
 create mode 100644 drivers/nvme/target/fc.c
 create mode 100644 drivers/nvme/target/fcloop.c
 create mode 100644 include/linux/nvme-fc-driver.h
 create mode 100644 include/linux/nvme-fc.h
