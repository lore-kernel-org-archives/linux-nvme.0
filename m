From: jsmart2021@gmail.com (James Smart)
Date: Fri, 20 Oct 2017 16:17:05 -0700
Subject: [PATCH v2 0/4] Add duplicate_connect option for ctlr connect requests
Message-ID: <20171020231709.3183-1-jsmart2021@gmail.com>

This patch adds a duplicate_connect option option to those supported by
fabric connection requests. When set to true (1), duplicate connections
are allowed. When set to false (0), duplicate connections are rejected.

The option is set in the fabrics layer and acted upon by each transport.

This patch set came about as of this prior patch review:
http://lists.infradead.org/pipermail/linux-nvme/2017-September/012783.html

---
v2:
 split compare for hostnqn, hostid, subnqn to a helper function
 duplicate_connection converted to a boolean option (presence means true)

James Smart (4):
  nvme: add duplicate_connect option
  nvme: add helper to compare options to controller
  nvme_fc: add support for duplicate_connect option
  RFC: nvme-rdma: add support for duplicate_connect option

 drivers/nvme/host/fabrics.c |  7 +++-
 drivers/nvme/host/fabrics.h | 14 ++++++++
 drivers/nvme/host/fc.c      | 33 ++++++++++++++++++
 drivers/nvme/host/rdma.c    | 82 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 135 insertions(+), 1 deletion(-)

-- 
2.13.1
