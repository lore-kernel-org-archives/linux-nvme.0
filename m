From: keith.busch@intel.com (Keith Busch)
Date: Fri, 24 May 2019 14:20:33 -0600
Subject: [PATCH 0/3] nvme: Improve processing paused support
Message-ID: <20190524202036.17265-1-keith.busch@intel.com>

From: Keith Busch <kbusch@kernel.org>

Improve firmware activation over what we're currently doing. The main
thing is that we do not want to esacalate recovery while the current
status has CSTS.PP set as the recovery attempt may interfere with a
critical controller operation.

There still exists a race where the controller may clear CSTS Processing
Paused at the same time a stalled request times out. We would normally
want to reset the timer for that, but this is at least a state that can
handle error recovery without interrupting background operations, so
the only harm caused from encountering this unlikely event is a longer
latency back to ready.

My previous patch to address this used help from the block layer, but
had some issues. This series only involves the nvme driver and just
addresses the main concern without addressing the corner cases.

Keith Busch (3):
  nvme-pci: reset timeout when processing is paused
  nvme: rearm fw notification in admin only state
  nvme: quiesce admin queue for fw activation

 drivers/nvme/host/core.c | 9 ++++++++-
 drivers/nvme/host/pci.c  | 2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.14.4
