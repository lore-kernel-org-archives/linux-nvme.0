From: ming.lei@redhat.com (Ming Lei)
Date: Tue, 26 Mar 2019 11:19:24 +0800
Subject: [PATCH 0/4] nvmet: fix file & block device backed ns
Message-ID: <20190326031928.9499-1-ming.lei@redhat.com>

Hi,

The 1st patch sets loop queue's segment boundary mask as PAGE_SIZE - 1
because nvme target only accepts single-page sg list.

The 2nd & 3rd patches fix computation io vector.

The last patch builds bvec from sg directly.

Ming Lei (4):
  nvmet: set loop queue's segment boundary mask as PAGE_SIZE - 1
  nvmet: fix computation of io vector number
  nvmet: fix computation of bvec->bv_len
  nvmet: build bvec from sg directly

 drivers/nvme/target/io-cmd-file.c | 20 ++++++++++----------
 drivers/nvme/target/loop.c        |  3 +++
 2 files changed, 13 insertions(+), 10 deletions(-)

Cc: Yi Zhang <yi.zhang at redhat.com>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

-- 
2.9.5
