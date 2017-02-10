From: keith.busch@intel.com (Keith Busch)
Date: Fri, 10 Feb 2017 18:15:48 -0500
Subject: [PATCH 0/5] NVMe pci fixes, for-4.11
Message-ID: <1486768553-13738-1-git-send-email-keith.busch@intel.com>

These are some fixes for some more device and CPU hot plug scenarios. The
end result should fix up a long-standing deadlock caused by requests
entering a quiesced queue that block blk_mq_freeze_queue_wait forever. I'd
previously tried to fix that here:

  http://lists.infradead.org/pipermail/linux-nvme/2017-January/007620.html

But that was overly complex and overkill anyway on ending requests that
could have been successful. This time is much simpler, isolated to the
nvme driver, and more likely to not fail good IO.

This is based off linux-block/for-next because I needed to make use
of the "was_suspend" bool that was recently added with the Opal patch
set. I also merged in the nvme git tree for final testing, and noticed
there is a conflict between the following to commits:

  https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git/commit/?h=for-next&id=06406d81a2d7cfb8abcc4fa6cdfeb8e5897007c5
  http://git.infradead.org/nvme.git/commitdiff/73494e87734f2c2cd4f9e91e98700cd4fd5f3e05

It's a trivial fix, but I think we gotta sort out our merging flow among
these trees.

Anyway, these are addressing real issues I'll be happy to see fixed for
4.11, but rare enough that I don't think any qualify for stable.

Keith Busch (5):
  nvme/pci: Disable on removal when disconnected
  nvme/pci: Cancel work after watchdog disabled
  nvme/core: Fix race kicking freed request_queue
  nvme/pci: No special case for queue busy on IO
  nvme/pci: Complete all stuck requests

 drivers/nvme/host/core.c | 39 ++++++++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h |  3 +++
 drivers/nvme/host/pci.c  | 45 ++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 77 insertions(+), 10 deletions(-)

-- 
1.8.3.1
