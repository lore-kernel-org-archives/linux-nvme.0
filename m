From: keith.busch@intel.com (Keith Busch)
Date: Thu,  8 May 2014 12:07:32 -0600
Subject: [PATCH 0/2] Asynchronous device shutdown
Message-ID: <1399572454-30239-1-git-send-email-keith.busch@intel.com>

Device shutdown synchronization was recently reverted due to complications
from unrelated 'async_schedule's holding up shutdown forever and the
fact that no device driver was making use of the capability anyway.

I would like to make use of this capability though; I'm told by some
vendors that devices I develop drivers for may take a while to safely
shutdown and there might be a lot of these devices in a machine, so we
would benefit from letting this happen in parallel.

This patch set adds a slightly different shutdown synchronization using
a new domain, and I've added an implementation to the nvm-express driver
here so there's at least one user, assuming this is acceptable.

Keith Busch (2):
  driver-core: allow asynchronous device shutdown
  NVMe: Complete shutdown asynchronously

 drivers/base/core.c       |    4 ++++
 drivers/block/nvme-core.c |   28 ++++++++++++++++++++++++++--
 include/linux/device.h    |    1 +
 include/linux/nvme.h      |    1 +
 4 files changed, 32 insertions(+), 2 deletions(-)

-- 
1.7.10.4
