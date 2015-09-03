From: sagig@mellanox.com (Sagi Grimberg)
Date: Thu,  3 Sep 2015 19:28:19 +0300
Subject: [PATCH 0/4] Fix gaps detection in bio merges
Message-ID: <1441297703-10753-1-git-send-email-sagig@mellanox.com>

This series makes gaps go away for real if a driver
asked to not see them (nvme and soon iser).

patch 1 addresses front merges where gaps weren't
checked at all.

patches 2,3 adds gap detection for integrity payloads.

patch 4 makes blk_rq_map_user_iov turn to bounce buffer
in case of an iovec with gaps.

I've been testing this for a couple of days now and I'll
run some more tests on this, but since it was very easy
to trigger these cases before I'm pretty sure we are covered.

Once this lands in, I will be able to get rid of the
bounce buffer logic in the iser driver as it will rely
on the block layer to get it right.

Jens Axboe (1):
  block: Check for gaps on front and back merges

Sagi Grimberg (3):
  block: Refuse request/bio merges with gaps in the integrity payload
  block: Refuse adding appending a gaped integrity page to a bio
  block: Copy a user iovec if it includes gaps

 block/bio-integrity.c  |  5 +++++
 block/blk-integrity.c  |  3 +++
 block/blk-map.c        | 26 ++++++++++++++++++++++++--
 block/blk-merge.c      | 25 ++++++++++++-------------
 include/linux/blkdev.h | 40 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 84 insertions(+), 15 deletions(-)

-- 
1.8.4.3
