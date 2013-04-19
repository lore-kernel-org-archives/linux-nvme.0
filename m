From: keith.busch@intel.com (Keith Busch)
Date: Fri, 19 Apr 2013 14:11:04 -0600
Subject: [PATCH 0/2] Driver handling for broken devices
Message-ID: <1366402266-10131-1-git-send-email-keith.busch@intel.com>

These are just a couple simple patches for when the device stops working.
I think handling the unload was mentioned on another thread somewhere on
this mailing list. I'm not particularly thrilled with this since a truely
broken device will take 2 minutes per queue for the unload or hot-unplug
to complete, but I think it is a step in the right direction.

Keith Busch (2):
  NVMe: Clear timed out IO
  NVMe: Schedule timeout for sync commands

 drivers/block/nvme-core.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)
