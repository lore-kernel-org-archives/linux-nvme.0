From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 12 Apr 2018 11:06:52 +0300
Subject: [PATCH v1 0/3] nvmet-rdma automatic port re-activation
Message-ID: <20180412080656.1691-1-sagi@grimberg.me>

When a RDMA device goes away we must destroy all it's associated
RDMA resources. RDMa device resets also manifest as device removal
events and a short while after they come back. We want to re-activate
a port listener on this RDMA device when it comes back in to the system.

In order to make it happen, we save the RDMA device node_guid on a
ULP listener representation (nvmet_rdma_port) and when a RDMA device
comes into the system, we check if there is a listener port that needs
to be re-activated.

In addition, reflect the port state to the sysadmin nicely with a patch
to nvmetcli.

Changes from v0 (rfc):
- renamed tractive to trstate
- trstate configfs file without addr_ prefix to prevent json serialization on it
- nvmet_rdma_port_enable_work self requeue delay was increased to 5 seconds

Israel Rukshin (2):
  nvmet: Add fabrics ops to port
  nvmet: Add port transport state flag

Sagi Grimberg (1):
  nvmet-rdma: automatic listening port re-activation

 drivers/nvme/target/configfs.c |  11 ++
 drivers/nvme/target/core.c     |  17 ++-
 drivers/nvme/target/nvmet.h    |   3 +
 drivers/nvme/target/rdma.c     | 237 ++++++++++++++++++++++++++---------------
 4 files changed, 175 insertions(+), 93 deletions(-)

-- 
2.14.1
