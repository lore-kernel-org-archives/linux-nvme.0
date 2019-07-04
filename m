From: hare@suse.de (Hannes Reinecke)
Date: Thu,  4 Jul 2019 08:10:45 +0200
Subject: [PATCHv2 0/2] nvme-multipath: path selection fixes
Message-ID: <20190704061047.94976-1-hare@suse.de>

Hi all,

during analysing a mysterious failure due to blk_queue_split() (again)
I've found that the multipath path selection might return invalid
namespaces under certain circumstances.
This patchset fixes those scenarios.

As usual, reviews and comments are welcome.

Changes to v1:
- Use common helper nvme_path_is_disabled()

Hannes Reinecke (2):
  nvme-multipath: check singular list in vme_round_robin_path()
  nvme-multipath: do not select namespaces which are about to be removed

 drivers/nvme/host/multipath.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

-- 
2.16.4
