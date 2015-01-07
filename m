From: keith.busch@intel.com (Keith Busch)
Date: Tue,  6 Jan 2015 19:57:54 -0700
Subject: [PATCHv2 00/10] Second attempt at blk-mq + nvme hotplug fixes
Message-ID: <1420599484-21582-1-git-send-email-keith.busch@intel.com>

Second try, this time tested against many more scenarios than before
with error injection and surprise hot-removal and intermittent resets.

I'm adding a lot of stuff outside the driver, but I didn't find a
cleaner way to a lot of these things. This makes me a little nervous,
so please let me know if anything seems amiss here. I don't think any
of the blk-mq changes could possibly be harmful to anyone else since
nvme is the only driver that uses most of the additions.

The only issue remaining I found is unfreezing queues might tigger the
percpu_ref_reinit WARN_ON_ONCE when the driver restarts a request_queue
with queued up IO's.

This is against linux-block/for-next.

Jens,
I believe fourth one ("abort requeue list") is from you, but I didn't find
the patch.

Keith Busch (10):
  blk-mq: Wake tasks entering a dying queue 
  blk-mq: Export test for started requests
  blk-mq: Let drivers cancel requeue_work
  blk-mq: Export abort requeue list
  blk-mq: Allow requests to never expire
  blk-mq: End unstarted requests on a dying queue
  NVMe: Start driver allocated requests
  NVMe: Start and stop h/w queues on reset
  NVMe: Admin queue error handling
  NVMe: Command abort handling fixes

 block/blk-mq.c            |   46 ++++++++++++++-
 drivers/block/nvme-core.c |  142 +++++++++++++++++++++++++++++++--------------
 include/linux/blk-mq.h    |    3 +
 include/linux/blkdev.h    |    1 +
 4 files changed, 146 insertions(+), 46 deletions(-)

-- 
1.7.10.4
