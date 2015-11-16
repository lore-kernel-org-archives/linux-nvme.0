From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Mon, 16 Nov 2015 15:34:34 +0100
Subject: [PATCH 00/13] lightnvm updates for 4.4-rc2
Message-ID: <1447684487-25539-1-git-send-email-m@bjorling.me>

Hi Jens,

This is the patches targeted for -rc2 of 4.4.

Ten of the patches fix bugs and small specification updates. While the
last two are larger patches. They are necessary because of specification
changes. The updates are applied now before it is set in stone for 4.4
(or at least makes it a lot harder to change)

Patch 1: Adds the linux-block list to the maintainers list for LightNVM.
Patch 2: Fixes a ushort bug reported by Geert.
Patch 3: Updates the implementation to support the new bad block table
         format.
Patch 4-9: Small fixes.
Patch 10: The specification had support for both linear and device
          specific addressing. It was replaced by ppa format, that
          defines the device ppa format used by the specific device.
          This patch adds the support and removes the previous two
          modes.
Patch 11-12: Two small cleanups to the lightnvm nvme integration.
          Caused by specification changes.

Patches 3 to 12 is the first time they are posted to the list for
review.

Will you pick up the patches when convenient (and reviewed):

  git at github.com:OpenChannelSSD/linux.git for-jens

I'll update the for-jens branch and post a separate patch if any
fixes is applied to the patches.

Javier Gonz?lez (1):
  lightnvm: cleanup queue before target removal

Matias Bj?rling (12):
  MAINTAINERS: Add linux-block list to LightNVM for patches
  lightnvm: change max_phys_sect to uint
  lightnvm: update bad block table format
  lightnvm: update alignments for identify command
  lightnvm: expose mccap in identify command
  lightnvm: remove unused attrs in nvm_id structs
  lightnvm: check for NAND flash and its type
  lightnvm: prematurely activate nvm_dev
  lightnvm: prevent double free on init error
  lightnvm: remove linear and device addr modes
  nvme: missing ppaf copy
  nvme: remove reserved double word

 MAINTAINERS                  |   1 +
 drivers/lightnvm/core.c      |  37 +++++-----
 drivers/lightnvm/gennvm.c    |  40 ++++++----
 drivers/lightnvm/gennvm.h    |   2 +
 drivers/lightnvm/rrpc.c      |  32 +++++++-
 drivers/nvme/host/lightnvm.c | 126 +++++++++++++++++++++++++-------
 include/linux/lightnvm.h     | 170 ++++++++++---------------------------------
 7 files changed, 219 insertions(+), 189 deletions(-)

-- 
2.1.4
