From: neilb@suse.com (NeilBrown)
Date: Thu, 02 Jun 2016 16:43:18 +1000
Subject: [PATCH 0/2] stop allocating unnecessary major numbers
Message-ID: <20160602064306.4403.72816.stgit@noble>

Hi Andrew,
 I sent these out to maintainer in March and got generally positive
 responses but these two didn't get upstreamed, so I assume that means
 it falls to your lot to handle them.

Thanks,
NeilBrown


---

NeilBrown (2):
      memstick: don't allocate unused major for ms_block
      NVMe: don't allocate unused nvme_major


 drivers/memstick/core/ms_block.c |   17 ++---------------
 drivers/nvme/host/core.c         |   15 +--------------
 2 files changed, 3 insertions(+), 29 deletions(-)

--
Signature
