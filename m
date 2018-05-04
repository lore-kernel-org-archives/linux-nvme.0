From: hare@suse.de (Hannes Reinecke)
Date: Fri,  4 May 2018 13:28:40 +0200
Subject: [RFC PATCH 0/5] nvme: ANA support
Message-ID: <20180504112845.38820-1-hare@suse.de>

Hi all,

here's a prototype implementation for ANA support in nvme.
The implementation itself is pretty straightforward; only the ANA group
linking for NVMe target required some fiddling.

As usual, comments and reviews are welcome.

Hannes Reinecke (5):
  nvmet: EUI64 support
  nvme: Add ANA base definitions
  nvmet: Add ANA base support
  block: BLK_STS_NEXUS is a path failure
  nvme: ANA base support

 drivers/nvme/host/core.c        | 122 ++++++++++++++-
 drivers/nvme/host/multipath.c   |  12 +-
 drivers/nvme/host/nvme.h        |   3 +
 drivers/nvme/target/admin-cmd.c |  75 ++++++++-
 drivers/nvme/target/configfs.c  | 328 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c      |  78 +++++++++-
 drivers/nvme/target/discovery.c |  16 ++
 drivers/nvme/target/io-cmd.c    |  10 ++
 drivers/nvme/target/nvmet.h     |  46 ++++++
 include/linux/blk_types.h       |   1 -
 include/linux/nvme.h            |  47 +++++-
 11 files changed, 723 insertions(+), 15 deletions(-)

-- 
2.12.3
