From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 13 Dec 2018 20:56:07 +0100
Subject: [GIT PULL] second batch of nvme updates for 4.21
Message-ID: <20181213195607.GA7751@infradead.org>

Hi Jens,

here is the second large chunk of nvme updates for 4.21:

 - host and target support for NVMe over TCP (Sagi Grimberg,
	Roy Shterman, Solganik Alexander)
 - error log page support in target (Chaitanya Kulkarni)

plus small fixes and improvements from Jens Axboe and Chengguang Xu.

The following changes since commit 0273ac349f08f4ff9ef88aaaf9c9f2aa6e87d2be:

  blkcg: handle dying request_queue when associating a blkg (2018-12-12 17:43:33 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.21

for you to fetch changes up to b65bb777ef2237030f2802f2263ae9a0108f7acf:

  nvme-rdma: support separate queue maps for read and write (2018-12-13 09:59:10 +0100)

----------------------------------------------------------------
Chaitanya Kulkarni (12):
      nvme: remove nvme_common command cdw10 array
      nvme: add error log page slot definition
      nvmet: add error-log definitions
      nvmet: add interface to update error-log page
      nvmet: add error log support in the core
      nvmet: add error log support for fabrics-cmd
      nvmet: add error log support for rdma backend
      nvmet: add error log support for admin-cmd
      nvmet: add error log support for bdev backend
      nvmet: add error log support for file backend
      nvmet: add error log page cmd handler
      nvmet: update smart log with num err log entries

Chengguang Xu (1):
      nvme: add __exit annotation

Jens Axboe (1):
      nvme: provide fallback for discard alloc failure

Sagi Grimberg (19):
      ath6kl: add ath6kl_ prefix to crypto_type
      datagram: open-code copy_page_to_iter
      iov_iter: pass void csum pointer to csum_and_copy_to_iter
      datagram: consolidate datagram copy to iter helpers
      iov_iter: introduce hash_and_copy_to_iter helper
      datagram: introduce skb_copy_and_hash_datagram_iter helper
      nvmet: Add install_queue callout
      nvme-fabrics: allow user passing header digest
      nvme-fabrics: allow user passing data digest
      nvme-tcp: Add protocol header
      nvmet-tcp: add NVMe over TCP target driver
      nvmet: allow configfs tcp trtype configuration
      nvme-tcp: add NVMe over TCP host driver
      nvmet: remove unused variable
      blk-mq-rdma: pass in queue map to blk_mq_rdma_map_queues
      nvme-fabrics: add missing nvmf_ctrl_options documentation
      nvme-fabrics: allow user to set nr_write_queues for separate queue maps
      nvme-tcp: support separate queue maps for read and write
      nvme-rdma: support separate queue maps for read and write

 block/blk-mq-rdma.c                        |    8 +-
 drivers/net/wireless/ath/ath6kl/cfg80211.c |    2 +-
 drivers/net/wireless/ath/ath6kl/common.h   |    2 +-
 drivers/net/wireless/ath/ath6kl/wmi.c      |    6 +-
 drivers/net/wireless/ath/ath6kl/wmi.h      |    6 +-
 drivers/nvme/host/Kconfig                  |   15 +
 drivers/nvme/host/Makefile                 |    3 +
 drivers/nvme/host/core.c                   |   61 +-
 drivers/nvme/host/fabrics.c                |   23 +
 drivers/nvme/host/fabrics.h                |   10 +
 drivers/nvme/host/lightnvm.c               |    6 +-
 drivers/nvme/host/nvme.h                   |    5 +-
 drivers/nvme/host/rdma.c                   |   28 +-
 drivers/nvme/host/tcp.c                    | 2277 ++++++++++++++++++++++++++++
 drivers/nvme/host/trace.h                  |    4 +-
 drivers/nvme/target/Kconfig                |   10 +
 drivers/nvme/target/Makefile               |    2 +
 drivers/nvme/target/admin-cmd.c            |   76 +-
 drivers/nvme/target/configfs.c             |    1 +
 drivers/nvme/target/core.c                 |  106 +-
 drivers/nvme/target/discovery.c            |   14 +-
 drivers/nvme/target/fabrics-cmd.c          |   58 +-
 drivers/nvme/target/io-cmd-bdev.c          |   87 +-
 drivers/nvme/target/io-cmd-file.c          |   35 +-
 drivers/nvme/target/nvmet.h                |   16 +-
 drivers/nvme/target/rdma.c                 |   10 +-
 drivers/nvme/target/tcp.c                  | 1737 +++++++++++++++++++++
 include/linux/blk-mq-rdma.h                |    2 +-
 include/linux/nvme-tcp.h                   |  189 +++
 include/linux/nvme.h                       |   22 +-
 include/linux/skbuff.h                     |    3 +
 include/linux/uio.h                        |    5 +-
 lib/iov_iter.c                             |   19 +-
 net/core/datagram.c                        |  159 +-
 34 files changed, 4794 insertions(+), 213 deletions(-)
 create mode 100644 drivers/nvme/host/tcp.c
 create mode 100644 drivers/nvme/target/tcp.c
 create mode 100644 include/linux/nvme-tcp.h
