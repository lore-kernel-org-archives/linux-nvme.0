From: jsmart2021@gmail.com (James Smart)
Date: Tue, 10 Oct 2017 17:35:09 -0700
Subject: [PATCH 0/3] Add duplicate_connect option for ctlr connect requests
Message-ID: <20171011003512.5946-1-jsmart2021@gmail.com>

This patch adds a duplicate_connect option option to those supported by
fabric connection requests. When set to true (1), duplicate connections
are allowed. When set to false (0), duplicate connections are rejected.

The option is set in the fabrics layer and acted upon by each transport.

This patch set came about as of this prior patch review:
http://lists.infradead.org/pipermail/linux-nvme/2017-September/012783.html

James Smart (3):
  nvme: add duplicate_connect option
  nvme_fc: add support for duplicate_connect option
  RFC: nvme rdma: add support for duplicate_connect option

 drivers/nvme/host/fabrics.c | 19 +++++++++-
 drivers/nvme/host/fabrics.h |  2 ++
 drivers/nvme/host/fc.c      | 46 +++++++++++++++++++++++++
 drivers/nvme/host/rdma.c    | 84 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 150 insertions(+), 1 deletion(-)

-- 
2.13.1
