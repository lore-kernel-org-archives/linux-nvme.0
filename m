From: israelr@mellanox.com (Israel Rukshin)
Date: Tue, 13 Aug 2019 16:17:25 +0300
Subject: [PATCH 0/5 V2] nvme: Add type of service (TOS) configuration
Message-ID: <1565702251-17198-1-git-send-email-israelr@mellanox.com>

Hi All,

This series adds TOS configuration for TCP and RDMA transports.
It provides clients the ability to segregate traffic flows for different
type of data.
One of the TOS usage is bandwidth management which allows setting bandwidth
limits for QoS classes, e.g. 80% bandwidth to controllers at QoS class A
and 20% to controllers at QoS class B.

Changes from v1:
 - Add TCP TOS configuration

Israel Rukshin (5):
  nvme-fabrics: Add type of service (TOS) configuration
  nvme-rdma: Add TOS for rdma transport
  nvme-tcp: Use struct nvme_ctrl directly
  nvme-tcp: Add TOS for tcp transport
  nvmet-tcp: Add TOS for tcp transport

 drivers/nvme/host/fabrics.c | 16 +++++++++++++++-
 drivers/nvme/host/fabrics.h |  3 +++
 drivers/nvme/host/rdma.c    |  6 ++++--
 drivers/nvme/host/tcp.c     | 32 ++++++++++++++++++++++----------
 drivers/nvme/target/tcp.c   | 11 +++++++++++
 5 files changed, 55 insertions(+), 13 deletions(-)

-- 
1.8.3.1
