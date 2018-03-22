From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 22 Mar 2018 21:02:59 +0200
Subject: [PATCH rfc 0/3] nvmet-rdma automatic port re-activation
Message-ID: <20180322190303.10951-1-sagi@grimberg.me>

When a RDMA device goes away we must destroy all it's associated
RDMA resources. RDMa device resets also manifest as device removal
events and a short while after they come back. We want to re-activate
a port listener on this RDMA device when it comes back in to the system.

In order to make it happen, we save the RDMA device node_guid on a
ULP listener representation (nvmet_rdma_port) and when a RDMA device
comes into the system, we check if there is a listener port that needs
to be re-activated.

In addition, reflect the port state to the sysadmin.

Israel Rukshin (2):
  nvmet: Add fabrics ops to port
  nvmet: Add port transport active flag

Sagi Grimberg (1):
  nvmet-rdma: automatic listening port re-activation

 drivers/nvme/target/configfs.c |  10 ++
 drivers/nvme/target/core.c     |  17 ++-
 drivers/nvme/target/nvmet.h    |   3 +
 drivers/nvme/target/rdma.c     | 231 +++++++++++++++++++++++++----------------
 4 files changed, 169 insertions(+), 92 deletions(-)

-- 
2.14.1
