From: tom.leiming@gmail.com (Ming Lei)
Date: Fri, 11 Nov 2016 20:05:28 +0800
Subject: [PATCH 00/12] block: cleanup direct access to bvec table
Message-ID: <1478865957-25252-1-git-send-email-tom.leiming@gmail.com>

Hi,

This patchset cleans up direct access to bvec table.

The 1st patch passes bvec table to bio_init(), so that
direct access to bvec table in bio initialization is avoided.

For other patches, most of them uses bio_add_page()
to replace hardcode style of adding page to bvec,
and others avoids to access bio->bi_vcnt.

The most special one is to use bvec iterator helpers
to implement .get_page/.next_page for dm-io.c

One big motivation is to prepare for supporting multipage
bvec, but this patchset is one good cleanup too even not
for that purpose.

Thanks,
Ming

Ming Lei (12):
  block: bio: pass bvec table to bio_init()
  block: drbd: remove impossible failure handling
  block: floppy: use bio_add_page()
  target: avoid to access .bi_vcnt directly
  bcache: debug: avoid to access .bi_io_vec directly
  dm: crypt: use bio_add_page()
  dm: use bvec iterator helpers to implement .get_page and .next_page
  dm: dm.c: replace 'bio->bi_vcnt == 1' with !bio_multiple_segments
  fs: logfs: convert to bio_add_page() in sync_request()
  fs: logfs: use bio_add_page() in __bdev_writeseg()
  fs: logfs: use bio_add_page() in do_erase()
  fs: logfs: remove unnecesary check

 block/bio.c                        |   8 ++-
 drivers/block/drbd/drbd_receiver.c |  14 +----
 drivers/block/floppy.c             |  10 ++--
 drivers/md/bcache/debug.c          |  11 ++--
 drivers/md/bcache/io.c             |   4 +-
 drivers/md/bcache/journal.c        |   4 +-
 drivers/md/bcache/movinggc.c       |   6 +--
 drivers/md/bcache/request.c        |   2 +-
 drivers/md/bcache/super.c          |  12 ++---
 drivers/md/bcache/writeback.c      |   5 +-
 drivers/md/dm-bufio.c              |   4 +-
 drivers/md/dm-crypt.c              |   8 +--
 drivers/md/dm-io.c                 |  34 ++++++++----
 drivers/md/dm-rq.c                 |   7 ++-
 drivers/md/dm.c                    |   2 +-
 drivers/md/multipath.c             |   2 +-
 drivers/md/raid5-cache.c           |   2 +-
 drivers/md/raid5.c                 |   9 +---
 drivers/nvme/target/io-cmd.c       |   4 +-
 drivers/target/target_core_pscsi.c |   8 +--
 fs/logfs/dev_bdev.c                | 106 +++++++++++++------------------------
 include/linux/bio.h                |   3 +-
 22 files changed, 107 insertions(+), 158 deletions(-)

-- 
2.7.4
