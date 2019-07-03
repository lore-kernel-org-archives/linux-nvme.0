From: logang@deltatee.com (Logan Gunthorpe)
Date: Wed,  3 Jul 2019 17:03:02 -0600
Subject: [PATCH v2 0/2] Fix use-after-free bug when ports are removed
Message-ID: <20190703230304.22905-1-logang@deltatee.com>

Hey,

This is the second attempt at fixing this.

Per Sagi's feedback on the first attempt, I've found an approach
that disconnects active controllers when the subsys is removed from
the port (Patch 1). Patch 2 fixes a race that still exists in the
loop transport which requires us to flush the nvme_delete_wq before
freeing the port to prevent the use-after-free bug.

Logan

--

NVME target ports can be removed while there are still active
controllers. Largely this is fine, except some admin commands
can access the req->port (for example, id-ctrl uses the port's
inline date size as part of it's response). This was found
while testing with KASAN.

--

Logan Gunthorpe (2):
  nvmet: Fix use-after-free bug when a port is removed
  nvmet-loop: Flush nvme_delete_wq when removing the port

 drivers/nvme/target/configfs.c |  1 +
 drivers/nvme/target/core.c     | 12 ++++++++++++
 drivers/nvme/target/loop.c     |  8 ++++++++
 drivers/nvme/target/nvmet.h    |  3 +++
 4 files changed, 24 insertions(+)

--
2.20.1
