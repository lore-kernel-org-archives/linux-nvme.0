From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 24 Jun 2019 08:12:41 +0200
Subject: [GIT PULL] nvme updates for 5.3
Message-ID: <20190624061241.GA31634@infradead.org>

A large chunk of NVMe updates for 5.3.  Highlights:

 - improved PCIe suspent support (Keith Busch)
 - error injection support for the admin queue (Akinobu Mita)
 - Fibre Channel discovery improvements (James Smart)
 - tracing improvements including nvmetc tracing support (Minwoo Im)
 - misc fixes and cleanups (Anton Eidelman, Minwoo Im, Chaitanya Kulkarni)


The following changes since commit 474a280036e8d319ef852f1dec59bedf4eda0107:

  cgroup: export css_next_descendant_pre for bfq (2019-06-21 02:48:34 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.3

for you to fetch changes up to 7e31d8215fd8cb1c13b47e23f1136545010e00de:

  Documentation: nvme: add an example for nvme fault injection (2019-06-21 11:15:50 +0200)

----------------------------------------------------------------
Akinobu Mita (3):
      nvme: prepare for fault injection into admin commands
      nvme: enable to inject errors into admin commands
      Documentation: nvme: add an example for nvme fault injection

Anton Eidelman (1):
      nvme: fix possible io failures when removing multipathed ns

Chaitanya Kulkarni (2):
      nvme-pci: set the errno on ctrl state change error
      nvme-pci: clean up nvme_remove_dead_ctrl a bit

James Smart (8):
      nvmet: add transport discovery change op
      nvmet-fc: add transport discovery change event callback support
      nvme-fcloop: add support for nvmet discovery_event op
      lpfc: add support to generate RSCN events for nport
      lpfc: add nvmet discovery_event op support
      lpfc: add support for translating an RSCN rcv into a discovery rescan
      lpfc: add sysfs interface to post NVME RSCN
      nvme-fc: add message when creating new association

Keith Busch (2):
      nvme: export get and set features
      nvme-pci: use host managed power state for suspend

Minwoo Im (10):
      nvme: introduce nvme_is_fabrics to check fabrics cmd
      nvme-pci: remove unnecessary zero for static var
      nvme-pci: remove queue_count_ops for write_queues and poll_queues
      nvme-pci: adjust irq max_vector using num_possible_cpus()
      nvme-pci: properly report state change failure in nvme_reset_work
      nvme-trace: do not export nvme_trace_disk_name
      nvme-trace: move opcode symbol print to nvme.h
      nvme-trace: support for fabrics commands in host-side
      nvme-trace: print result and status in hex format
      nvmet: introduce target-side trace

 .../fault-injection/nvme-fault-injection.txt       |  56 ++++++
 drivers/nvme/host/core.c                           |  45 +++--
 drivers/nvme/host/fabrics.c                        |   2 +-
 drivers/nvme/host/fault_inject.c                   |  41 +++--
 drivers/nvme/host/fc.c                             |   6 +
 drivers/nvme/host/nvme.h                           |  42 +++--
 drivers/nvme/host/pci.c                            | 143 +++++++++++----
 drivers/nvme/host/trace.c                          |  64 ++++++-
 drivers/nvme/host/trace.h                          |  66 ++-----
 drivers/nvme/target/Makefile                       |   3 +
 drivers/nvme/target/core.c                         |  12 +-
 drivers/nvme/target/discovery.c                    |   4 +
 drivers/nvme/target/fabrics-cmd.c                  |   2 +-
 drivers/nvme/target/fc.c                           |  13 +-
 drivers/nvme/target/fcloop.c                       |  37 ++++
 drivers/nvme/target/nvmet.h                        |   2 +
 drivers/nvme/target/trace.c                        | 201 +++++++++++++++++++++
 drivers/nvme/target/trace.h                        | 141 +++++++++++++++
 drivers/scsi/lpfc/lpfc.h                           |   2 +
 drivers/scsi/lpfc/lpfc_attr.c                      |  60 ++++++
 drivers/scsi/lpfc/lpfc_crtn.h                      |   4 +
 drivers/scsi/lpfc/lpfc_els.c                       | 127 +++++++++++++
 drivers/scsi/lpfc/lpfc_hbadisc.c                   |  35 ++++
 drivers/scsi/lpfc/lpfc_hw.h                        |   2 +
 drivers/scsi/lpfc/lpfc_nvme.c                      |  44 +++++
 drivers/scsi/lpfc/lpfc_nvmet.c                     |  17 ++
 drivers/scsi/lpfc/lpfc_sli.c                       |   1 +
 include/linux/nvme-fc-driver.h                     |   6 +
 include/linux/nvme.h                               |  66 ++++++-
 29 files changed, 1110 insertions(+), 134 deletions(-)
 create mode 100644 drivers/nvme/target/trace.c
 create mode 100644 drivers/nvme/target/trace.h
