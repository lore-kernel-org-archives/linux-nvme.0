From: mwilck@suse.com (Martin Wilck)
Date: Thu, 20 Jul 2017 18:33:59 +0200
Subject: [PATCH v3 0/3] Improve readbility of NVME "wwid" attribute
Message-ID: <20170720163402.17793-1-mwilck@suse.com>

With the current implementation, the default "fallback" WWID generation
code (if no nguid, euid etc. are defined) for Linux NVME host and target
results in the following WWID format:

nvme.0000-3163653363666438366239656630386200-4c696e75780000000000000000000000000000000000000000000000000000000000000000000000-00000002

This is not only hard to read, it poses real problems e.g. for multipath
(dm WWIDs are limited to 128 characters).

With this patch series, the WWID on a Linux host connected to a Linux target
looks like this:

nvme.0000-65613435333665653738613464363961-4c696e7578-00000001

Changes wrt v1:
 * 1/3: new, moved helper to include/linux/string.h (Christoph Hellwig)
        (you suggested kernel.h, but I think this matches string.h better)      
 * Dropped the last patch from the v1 series that would have changed valid WWIDs for
   HW NVME controllers.

Changes wrt v2:
 * 3/3: Make sure no underflow occurs (Joe Perches)

Martin Wilck (3):
  string.h: add memcpy_and_pad()
  nvmet: identify controller: improve standard compliance
  nvme: wwid_show: strip trailing 0-bytes

 drivers/nvme/host/core.c        |  6 ++++--
 drivers/nvme/target/admin-cmd.c | 13 ++++++-------
 include/linux/string.h          | 30 ++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 9 deletions(-)

-- 
2.13.2
