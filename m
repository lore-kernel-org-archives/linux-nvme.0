From: hare@suse.de (Hannes Reinecke)
Date: Wed,  3 Jul 2019 15:12:30 +0200
Subject: [PATCH 0/2] nvme-multipath: path selection fixes
Message-ID: <20190703131232.58595-1-hare@suse.de>

Hi all,

during analysing a mysterious failure due to blk_queue_split() (again)
I've found that the multipath path selection might return invalid
namespaces under certain circumstances.
This patchset fixes those scenarios.

As usual, reviews and comments are welcome.

Hannes Reinecke (2):
  nvme-multipath: check singular list in vme_round_robin_path()
  nvme-multipath: do not select namespaces which are about to be removed

 drivers/nvme/host/multipath.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

-- 
2.16.4
