From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Wed, 10 Aug 2016 21:07:14 -0700
Subject: [PATCH RFC 0/4] sqsize zero-based fixes
Message-ID: <1470888438-823-1-git-send-email-james_p_freyensee@linux.intel.com>

These patches are based on NVMe-over-Fabrics spec clarifcations
by Dave Minturn, one of the spec authors. 
In summary, sqsize and hsqsize are 0-based
values, and hrqsize cannot be smaller than hsqsize+1.

There is an issue with these patches I haven't worked out yet,
thus the reason for RFC.  The keep-alive timer is going
off then causes a kernel crash and I haven't worked out
exactly why yet, but I'm thinking
it has something to do with sqsize now being 0-based but
the RDMA implemenation layer's queue_size being 1's based.

Anyways, feedback appreciated as I continue
to work on how to fix this appropriately.

Jay Freyensee (4):
  fabrics: define admin sqsize min default, per spec
  nvme-rdma: fix sqsize/hsqsize/hrqsize per spec
  nvmet-rdma: +1 to *queue_size from hsqsize/hrqsize
  nvme-loop: set sqsize to 0-based value, per spec

 drivers/nvme/host/fabrics.c | 16 +++++++++++++++-
 drivers/nvme/host/nvme.h    |  1 +
 drivers/nvme/host/rdma.c    | 19 ++++++++++++++++---
 drivers/nvme/target/loop.c  |  2 +-
 drivers/nvme/target/rdma.c  |  8 ++++----
 5 files changed, 37 insertions(+), 9 deletions(-)

-- 
2.7.4
