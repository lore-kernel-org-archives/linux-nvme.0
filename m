From: sagi@lightbitslabs.com (Sagi Grimberg)
Date: Thu, 15 Nov 2018 09:16:12 -0800
Subject: [PATCH 00/11] TCP transport binding for NVMe over Fabrics
Message-ID: <20181115171626.9306-1-sagi@lightbitslabs.com>

This patch set implements the NVMe over Fabrics TCP host and the target
drivers. Now NVMe over Fabrics can run on every Ethernet port in the world.
The implementation conforms to NVMe over Fabrics 1.1 specification (which
will include already publicly available NVMe/TCP transport binding, TP 8000).

The host driver hooks into the NVMe host stack and implements the TCP
transport binding for NVMe over Fabrics. The NVMe over Fabrics TCP host
driver is responsible for establishing a NVMe/TCP connection, TCP event
and error handling and data-plane messaging and stream processing.

The target driver hooks into the NVMe target core stack and implements
the TCP transport binding. The NVMe over Fabrics target driver is
responsible for accepting and establishing NVMe/TCP connections, TCP
event and error handling, and data-plane messaging and stream processing.

The implementation of both the host and target are fairly simple and
straight-forward. Every NVMe queue is backed by a TCP socket that provides
us reliable, in-order delivery of fabrics capsules and/or data.

All NVMe queues are sharded over a private bound workqueue such that we
always have a single context handling the byte stream and we don't need
to worry about any locking/serialization. In addition, close attention
was paid to a completely non-blocking data plane to minimize context
switching and/or unforced scheduling.

I piggybacked nvme-cli patches to the set for completeness.

Also, @netdev mailing list is cc'd as this patch set contains generic
helpers for online digest calculation (patches 1-3).

The patchset structure:
- patches 1-3 adds a helper for digest calculation online with data placement
- patches 4-8 are preparatory patches for NVMe/TCP
- patches 9-11 implements NVMe/TCP
- patches 12-14 are nvme-cli additions for NVMe/TCP

Thanks to the members of the Fabrics Linux Driver team that helped development,
testing and benchmarking this work.

Gitweb code is available at:

	git://git.infradead.org/nvme.git nvme-tcp

Sagi Grimberg (11):
  ath6kl: add ath6kl_ prefix to crypto_type
  iov_iter: introduce hash_and_copy iter helpers
  datagram: introduce skb_copy_and_hash_datagram_iter helper
  nvme-core: add work elements to struct nvme_ctrl
  nvmet: Add install_queue callout
  nvmet: allow configfs tcp trtype configuration
  nvme-fabrics: allow user passing header digest
  nvme-fabrics: allow user passing data digest
  nvme-tcp: Add protocol header
  nvmet-tcp: add NVMe over TCP target driver
  nvme-tcp: add NVMe over TCP host driver

 drivers/net/wireless/ath/ath6kl/cfg80211.c |    2 +-
 drivers/net/wireless/ath/ath6kl/common.h   |    2 +-
 drivers/net/wireless/ath/ath6kl/wmi.c      |    6 +-
 drivers/net/wireless/ath/ath6kl/wmi.h      |    6 +-
 drivers/nvme/host/Kconfig                  |   15 +
 drivers/nvme/host/Makefile                 |    3 +
 drivers/nvme/host/fabrics.c                |   10 +
 drivers/nvme/host/fabrics.h                |    4 +
 drivers/nvme/host/fc.c                     |   18 +-
 drivers/nvme/host/nvme.h                   |    2 +
 drivers/nvme/host/rdma.c                   |   19 +-
 drivers/nvme/host/tcp.c                    | 2305 ++++++++++++++++++++
 drivers/nvme/target/Kconfig                |   10 +
 drivers/nvme/target/Makefile               |    2 +
 drivers/nvme/target/configfs.c             |    1 +
 drivers/nvme/target/fabrics-cmd.c          |    9 +
 drivers/nvme/target/nvmet.h                |    1 +
 drivers/nvme/target/tcp.c                  | 1746 +++++++++++++++
 include/linux/nvme-tcp.h                   |  189 ++
 include/linux/nvme.h                       |    1 +
 include/linux/skbuff.h                     |    3 +
 include/linux/uio.h                        |    5 +
 lib/iov_iter.c                             |   31 +
 net/core/datagram.c                        |   90 +
 24 files changed, 4451 insertions(+), 29 deletions(-)
 create mode 100644 drivers/nvme/host/tcp.c
 create mode 100644 drivers/nvme/target/tcp.c
 create mode 100644 include/linux/nvme-tcp.h

-- 
2.17.1
