From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 21 Nov 2018 17:55:58 -0800
Subject: [PATCH v3 00/13] TCP transport binding for NVMe over Fabrics
Message-ID: <20181122015615.15763-1-sagi@grimberg.me>

Changes from v2:
- fixed stupid missing symbol export for skb_copy_and_hash_datagram_iter 
- dropped patch that moved err_work and connect_work to nvme_ctrl
- fixed maxr2t icreq validation
- got rid of host and target send/recv context structures by moving
  the members directly to their parent structure along with some struct
  documentation
- removed bh disable when locking the queue lock
- moved definition in nvme-tcp.h to appropriate patch
- added patch to rework nvme-cli trtype handling for discovery log entries
  a bit
- rebased on top of nvme-4.21 branch
- cleaned up some checkpatch warnings
- collected review tags

Changes from v1:
- unified skb_copy_datagram_iter and skb_copy_and_csum_datagram (and the
  new skb_hash_and_copy_datagram_iter) to a single code path
- removed nvmet modparam budgets (made them a define set to their default
  values)
- fixed nvme-tcp host chained r2t transfers reported off-list
- made .install_queue callout return nvme status code
- Added some review tags
- rebased on top of nvme-4.21 branch (nvme tree) + sqflow disable patches

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
- patches 1-6 are prep to add a helper for digest calculation online
  with data placement
- patches 7-9 are preparatory patches for NVMe/TCP
- patches 10-13 implements NVMe/TCP
- patches 14-17 are nvme-cli additions for NVMe/TCP

Thanks to the members of the Fabrics Linux Driver team that helped
development, testing and benchmarking this work.

Gitweb code is available at:

	git://git.infradead.org/nvme.git nvme-tcp

Sagi Grimberg (13):
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

 drivers/net/wireless/ath/ath6kl/cfg80211.c |    2 +-
 drivers/net/wireless/ath/ath6kl/common.h   |    2 +-
 drivers/net/wireless/ath/ath6kl/wmi.c      |    6 +-
 drivers/net/wireless/ath/ath6kl/wmi.h      |    6 +-
 drivers/nvme/host/Kconfig                  |   15 +
 drivers/nvme/host/Makefile                 |    3 +
 drivers/nvme/host/fabrics.c                |   10 +
 drivers/nvme/host/fabrics.h                |    4 +
 drivers/nvme/host/tcp.c                    | 2290 ++++++++++++++++++++
 drivers/nvme/target/Kconfig                |   10 +
 drivers/nvme/target/Makefile               |    2 +
 drivers/nvme/target/configfs.c             |    1 +
 drivers/nvme/target/fabrics-cmd.c          |    9 +
 drivers/nvme/target/nvmet.h                |    1 +
 drivers/nvme/target/tcp.c                  | 1734 +++++++++++++++
 include/linux/nvme-tcp.h                   |  189 ++
 include/linux/nvme.h                       |    1 +
 include/linux/skbuff.h                     |    3 +
 include/linux/uio.h                        |    5 +-
 lib/iov_iter.c                             |   19 +-
 net/core/datagram.c                        |  159 +-
 21 files changed, 4366 insertions(+), 105 deletions(-)
 create mode 100644 drivers/nvme/host/tcp.c
 create mode 100644 drivers/nvme/target/tcp.c
 create mode 100644 include/linux/nvme-tcp.h

-- 
2.17.1
