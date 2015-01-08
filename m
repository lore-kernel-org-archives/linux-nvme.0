From: keith.busch@intel.com (Keith Busch)
Date: Wed,  7 Jan 2015 18:55:41 -0700
Subject: [PATCHv3 00/12] nvme and blk-mq hot plug fixes
Message-ID: <1420682153-3756-1-git-send-email-keith.busch@intel.com>

Changes since version 2:

Attribute patch from Jens. There was no change log with the diff, so I
just made one up. You're a better wordsmith so I won't be feel bad
if you modify it.

Added new cmd_flag for REQ_NO_TIMEOUT, as opposed to using a magic value
for "rq->timeout" from v2.

Fixed the irq save/restore locking when checking for stopped queue in
req_completion requeue.

I noticed the timeout handling was accessing unlocked queues and dev
list nodes, so I added one last patch for that.

I split the admin queue reference count into its own patch. The previous
patch was changing too many logically separate things.

I put a "FIXME" in the timeout handling on a failed shutdown to speed
things up. I know how to fix this but it's a more radical change that
can go in a different series; making hot-plug and resets work safely is
a higher priority.

Jens Axboe (1):
  blk-mq: Add helper to abort requeued requests

Keith Busch (11):
  blk-mq: Wake tasks entering queue on dying
  blk-mq: Export if requests were started
  blk-mq: Let drivers cancel requeue_work
  blk-mq: Allow requests to never expire
  blk-mq: End unstarted requests on a dying queue
  NVMe: Start all requests
  NVMe: Reference count admin queue usage
  NVMe: Admin queue removal handling
  NVMe: Command abort handling fixes
  NVMe: Start and stop h/w queues on reset
  NVMe: Fix locking on abort handling

 block/blk-mq.c            |   44 ++++++++++++-
 block/blk-timeout.c       |    3 +
 drivers/block/nvme-core.c |  158 ++++++++++++++++++++++++++++++++-------------
 include/linux/blk-mq.h    |    3 +
 include/linux/blk_types.h |    2 +
 5 files changed, 164 insertions(+), 46 deletions(-)

-- 
1.7.10.4
