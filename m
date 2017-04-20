From: luto@kernel.org (Andy Lutomirski)
Date: Wed, 19 Apr 2017 20:02:13 -0700
Subject: [PATCH 0/5] nvme APST fixes/improvements for 4.11
Message-ID: <cover.1492656278.git.luto@kernel.org>

Sorry for waiting so long for this.  I was waiting for feedback from
Samsung, but they haven't root-caused the issue yet, and I should
have just done this from the beginning.

This series makes APST more debuggable and updates the quirk list.
The quirks I'm aware of are:

 - Samsung 950 series SSDs in Dell XPS 15 9550 and Precision 5510
   laptops (which are essentially the same laptop) can lose their
   PCIe link if they're allowed to use the deepest APST state.
   Samsung engineers have an affected system and are working on
   it.  The same exact SSDs in other machines (even an XPS 13)
   seem to work fine.

 - One Toshiba device malfunctions if APST is used at all.

One thing that improves my confidence that there aren't too many
more problems with APST is that Ubuntu has backported APST to Zesty,
so it's already gotten a bit of testing in a widely used (if very
new) release.

Andy Lutomirski (5):
  nvme: Fix APST comment
  nvme: Display raw APST configuration via DYNAMIC_DEBUG
  nvme: Add nvme_core.force_apst to ignore the NO_APST quirk
  nvme: Adjust the Samsung APST quirk
  nvme: Quirk APST off on "THNSF5256GPUK TOSHIBA"

 drivers/nvme/host/core.c | 61 ++++++++++++++++++++++++++++++++++++++++--------
 drivers/nvme/host/nvme.h |  5 ++++
 drivers/nvme/host/pci.c  | 26 ++++++++++++++++++++-
 3 files changed, 81 insertions(+), 11 deletions(-)

-- 
2.9.3
