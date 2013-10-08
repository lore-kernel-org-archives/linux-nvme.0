From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Tue,  8 Oct 2013 11:34:20 +0200
Subject: [PATCH RFC 0/2] Convert from bio-based to blk-mq
Message-ID: <1381224862-5299-1-git-send-email-m@bjorling.me>

These patches are against the "new-queue" branch in Axboe's repo:

git://git.kernel.dk/linux-block.git

The nvme driver implements itself as a bio-based driver. This primarily because
of high lock congestion for high-performance nvm devices. To remove the
congestion, a multi-queue block layer is being implemented.

These patches enable mq within the nvme driver. The first patch is a simple
blkmq fix. While the second implements the beginning of the nvme mq support.

Outstanding work:

 * Use reserved tags for admin queue. Should this be implemented as an admin
   queue within mq?
 * Move cmdid into blk mq and use request tagging.
 * Notify mq of nvme device stripe size.
 * Let mq know and handle BIOVEC_NOT_VIRT_MERGEABLE.

I crave some feedback on whether it's on the right path, before I break the bio
path apart and put it together again.

Matias Bj?rling (2):
  blk-mq: call exit_hctx on hw queue teardown
  NVMe: rfc blk-mq support

 block/blk-mq.c            |   2 +
 drivers/block/nvme-core.c | 404 +++++++++++++++++-----------------------------
 include/linux/nvme.h      |   3 +-
 3 files changed, 155 insertions(+), 254 deletions(-)

-- 
1.8.1.2
