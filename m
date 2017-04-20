From: luto@kernel.org (Andy Lutomirski)
Date: Thu, 20 Apr 2017 13:37:54 -0700
Subject: [PATCH v3 0/2] nvme APST quirk updates, take two
Message-ID: <cover.1492720361.git.luto@kernel.org>

Hi Jens-

These are just the quirk updates, split out.  The patches are
unchanged.

I think that, even if we want to apply a broader quirk for 4.11, we
should still apply these so that we can cleanly revert the broader
quirk later.  IOW, let's get the known regressions fixed before we
get too excited about the unknown regressions.

Changes from v2:
 - Rebased correctly so it actually compiles.  

Andy Lutomirski (2):
  nvme: Adjust the Samsung APST quirk
  nvme: Quirk APST off on "THNSF5256GPUK TOSHIBA"

 drivers/nvme/host/core.c | 23 +++++++++++++++--------
 drivers/nvme/host/nvme.h |  5 +++++
 drivers/nvme/host/pci.c  | 26 +++++++++++++++++++++++++-
 3 files changed, 45 insertions(+), 9 deletions(-)

-- 
2.9.3
