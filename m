From: israelr@mellanox.com (Israel Rukshin)
Date: Sun, 18 Aug 2019 12:08:49 +0300
Subject: [PATCH 0/5 V5] nvme: Add type of service (TOS) configuration
Message-ID: <1566119335-15058-1-git-send-email-israelr@mellanox.com>

Hi All,

This series adds TOS configuration for TCP and RDMA transports.
It provides clients the ability to segregate traffic flows for different
type of data.
One of the TOS usage is bandwidth management which allows setting bandwidth
limits for QoS classes, e.g. 80% bandwidth to controllers at QoS class A
and 20% to controllers at QoS class B.

Changes from v4:
 - Rebase over branch nvme-5.4 (PATCH 4/5)

Changes from v3:
 - Move NVMF_OPT_TOS from NVMF_ALLOWED_OPTS to .allowed_opts
   in rdma.c and tcp.c

Changes from v2:
 - Clamping tos to 255

Changes from v1:
 - Add TCP TOS configuration

Israel Rukshin (5):
  nvme-fabrics: Add type of service (TOS) configuration
  nvme-rdma: Add TOS for rdma transport
  nvme-tcp: Use struct nvme_ctrl directly
  nvme-tcp: Add TOS for tcp transport
  nvmet-tcp: Add TOS for tcp transport

 drivers/nvme/host/fabrics.c | 18 ++++++++++++++++++
 drivers/nvme/host/fabrics.h |  3 +++
 drivers/nvme/host/rdma.c    |  9 ++++++---
 drivers/nvme/host/tcp.c     | 35 ++++++++++++++++++++++++-----------
 drivers/nvme/target/tcp.c   | 11 +++++++++++
 5 files changed, 62 insertions(+), 14 deletions(-)

-- 
1.8.3.1
