From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Fri, 15 Mar 2019 16:57:36 +0800
Subject: [PATCH 0/8]: blk-mq: use static_rqs to iterate busy tags
Message-ID: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>

Hi Jens

As we know, there is a risk of accesing stale requests when iterate
in-flight requests with tags->rqs[] and this has been talked in following
thread,
[1] https://marc.info/?l=linux-scsi&m=154511693912752&w=2
[2] https://marc.info/?l=linux-block&m=154526189023236&w=2

A typical sence could be
blk_mq_get_request         blk_mq_queue_tag_busy_iter
  -> blk_mq_get_tag
                             -> bt_for_each
                               -> bt_iter
                                 -> rq = taags->rqs[]
                                 -> rq->q
  -> blk_mq_rq_ctx_init
    -> data->hctx->tags->rqs[rq->tag] = rq;

The root cause is that there is a window between set bit on tag sbitmap
and set tags->rqs[].

This patch would fix this issue by iterating requests with tags->static_rqs[]
instead of tags->rqs[] which would be changed dynamically. Moreover,
we will try to get a non-zero q_usage_counter before access hctxs and tags and
thus could avoid the race with updating nr_hw_queues, switching io scheduler
and even queue clean up which are all under a frozen and drained queue.

The 1st patch get rid of the useless of synchronize_rcu in __blk_mq_update_nr_hw_queues

The 2nd patch modify the blk_mq_queue_tag_busy_iter to use tags->static_rqs[]
instead of tags->rqs[] to iterate the busy tags.

The 3rd ~ 7th patch change the blk_mq_tagset_busy_iter to blk_mq_queue_tag_busy_iter
which is safer

The 8th patch get rid of the blk_mq_tagset_busy_iter.

Jianchao Wang(8)
	blk-mq: get rid of the synchronize_rcu in
	blk-mq: change the method of iterating busy tags of a
	blk-mq: use blk_mq_queue_tag_busy_iter in debugfs
	mtip32xx: use blk_mq_queue_tag_busy_iter
	nbd: use blk_mq_queue_tag_busy_iter
	skd: use blk_mq_queue_tag_busy_iter
	nvme: use blk_mq_queue_tag_busy_iter
	blk-mq: remove blk_mq_tagset_busy_iter

diff stat
 block/blk-mq-debugfs.c            |   4 +-
 block/blk-mq-tag.c                | 173 +++++++++++++++++++++++++-------------------------------------------------------------
 block/blk-mq-tag.h                |   2 -
 block/blk-mq.c                    |  35 ++++++------------
 drivers/block/mtip32xx/mtip32xx.c |   8 ++--
 drivers/block/nbd.c               |   2 +-
 drivers/block/skd_main.c          |   4 +-
 drivers/nvme/host/core.c          |  12 ++++++
 drivers/nvme/host/fc.c            |  12 +++---
 drivers/nvme/host/nvme.h          |   2 +
 drivers/nvme/host/pci.c           |   5 ++-
 drivers/nvme/host/rdma.c          |   6 +--
 drivers/nvme/host/tcp.c           |   5 ++-
 drivers/nvme/target/loop.c        |   6 +--
 include/linux/blk-mq.h            |   7 ++--
 15 files changed, 105 insertions(+), 178 deletions(-

Thanks
Jianchao
