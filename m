From: logang@deltatee.com (Logan Gunthorpe)
Date: Wed,  3 Jul 2019 11:01:34 -0600
Subject: [PATCH 0/2]  Fix use-after-free bug when ports are removed
Message-ID: <20190703170136.21515-1-logang@deltatee.com>

Hey,

NVME target ports can be removed while there are still active
controllers. Largely this is fine, except some admin commands
can access the req->port (for example, id-ctrl uses the port's
inline date size as part of it's response). This was found
while testing with KASAN.

Two patches follow which disconnect active controllers when the
ports are removed for loop and rdma. I'm not sure if fc has the
same issue and have no way to test this.

Alternatively, we could add reference counting to the struct port,
but I think this is a more involved change and could be done later
after we fix the bug quickly.

Thanks,

Logan

--

Logan Gunthorpe (2):
  nvmet-loop: Fix use-after-free bug when a port is removed
  nvmet-rdma: Fix use-after-free bug when a port is removed

 drivers/nvme/target/loop.c | 11 +++++++++++
 drivers/nvme/target/rdma.c | 16 ++++++++++++++++
 2 files changed, 27 insertions(+)

--
2.20.1
