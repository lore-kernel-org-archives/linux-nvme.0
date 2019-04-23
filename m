From: hare@suse.de (Hannes Reinecke)
Date: Tue, 23 Apr 2019 14:29:46 +0200
Subject: [PATCH 0/5] blk-mq: fixes for Ming Leis V6 patchset
Message-ID: <20190423122951.134531-1-hare@suse.de>

Hi Ming,

to clarify my comments to your patch to introduce dead_hctx_list here's
a small patchset to address my concerns.
If you agree it would possibly be best to fold it into your patchset.

Patches are relative to the 'nvme-5.2' branch of the nvme git repository
plus the 'V6' iteration of Mings patchset
'blk-mq: fix races related with freeing queue'.

Hannes Reinecke (5):
  blk-mq: rename 'dead_hctx_XX' to 'unused_hctx_XX'
  blk-mq: drop 'hctx_idx' argument from blk_mq_alloc_hctx()
  blk-mq: remove 'nr_queue' argument in blk_mq_exit_hw_queues()
  blk-mq: Set hctx pointer to NULL in blk_mq_exit_hw_queues()
  blk-mq: free q->queue_hw_ctx in blk_mq_exit_queue()

 block/blk-mq.c         | 45 +++++++++++++++++++++++++--------------------
 block/blk-mq.h         |  2 +-
 include/linux/blkdev.h |  6 +++---
 3 files changed, 29 insertions(+), 24 deletions(-)

-- 
2.16.4
