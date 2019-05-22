From: keith.busch@intel.com (Keith Busch)
Date: Wed, 22 May 2019 11:48:10 -0600
Subject: [PATCH 0/2] Reset timeout for paused hardware
Message-ID: <20190522174812.5597-1-keith.busch@intel.com>

Hardware may temporarily stop processing commands that have
been dispatched to it while activating new firmware. Some target
implementation's paused state time exceeds the default request expiry,
so any request dispatched before the driver could quiesce for the
hardware's paused state will time out, and handling this may interrupt
the firmware activation.

This two-part series provides a way for drivers to reset dispatched
requests' timeout deadline, then uses this new mechanism from the nvme
driver's fw activation work.

Keith Busch (2):
  blk-mq: provide way to reset rq timeouts
  nvme: reset request timeouts during fw activation

 block/blk-mq.c           | 30 ++++++++++++++++++++++++++++++
 drivers/nvme/host/core.c | 20 ++++++++++++++++++++
 include/linux/blk-mq.h   |  1 +
 3 files changed, 51 insertions(+)

-- 
2.14.4
