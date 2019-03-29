From: hare@suse.de (Hannes Reinecke)
Date: Fri, 29 Mar 2019 13:04:02 +0100
Subject: [PATCH 0/2] nvmet: add some more configfs attributes
Message-ID: <20190329120404.55637-1-hare@suse.de>

Hi all,

here are two small patches to make the 'MDTS' value and the 'CNTLID'
range configurable. The first is primarily for debugging, but the other
is required if the nvme target is deployed in a cluster.

As usual, comments and reviews are welcome.

Hannes Reinecke (2):
  nvmet: make MDTS value configurable
  nvmet: make CNTLID range configurable

 drivers/nvme/target/admin-cmd.c |  3 +-
 drivers/nvme/target/configfs.c  | 87 +++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c      |  4 +-
 drivers/nvme/target/nvmet.h     |  4 ++
 4 files changed, 95 insertions(+), 3 deletions(-)

-- 
2.16.4
