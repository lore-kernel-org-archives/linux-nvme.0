From: luto@kernel.org (Andy Lutomirski)
Date: Thu, 20 Apr 2017 09:11:14 -0700
Subject: [PATCH v2 0/2] nvme APST quirk updates, take two
Message-ID: <cover.1492704577.git.luto@kernel.org>

Hi Jens-

These are just the quirk updates, split out.  The patches are
unchanged.

I think that, even if we want to apply a broader quirk for 4.11, we
should still apply these so that we can cleanly revert the broader
quirk later.  IOW, let's get the known regressions fixed before we
get too excited about the unknown regressions.

Andy Lutomirski (2):
  nvme: Adjust the Samsung APST quirk
  nvme: Quirk APST off on "THNSF5256GPUK TOSHIBA"

 drivers/nvme/host/core.c | 28 ++++++++++++++++++++--------
 drivers/nvme/host/nvme.h |  5 +++++
 drivers/nvme/host/pci.c  | 26 +++++++++++++++++++++++++-
 3 files changed, 50 insertions(+), 9 deletions(-)

-- 
2.9.3
