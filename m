From: y@dcgshare.lm.intel.com (y@dcgshare.lm.intel.com)
Date: Mon,  4 Mar 2013 17:24:19 -0700
Subject: [PATCH 0/4] NVMe: bio request handling
In-Reply-To: <y>
References: <y>
Message-ID: <1362443063-18994-1-git-send-email-y>

From: Keith Busch <keith.busch@intel.com>

This is a series of patches that allow nvme requests to handle T10
data integrity. I tried sending this patch before but botched the format
when emailing to the list!

The block integrity extensions require that the bio values stay
consistent. The first patch changes how non mergable io vectors are
handled by splitting the request and submitting child bios so the
parent will remain intact. The data integrity functions were copied from
sd_dif.c. The last patch resubmits failed commands since splitting the
bio requests makes it easy to do that.

Keith Busch (4):
  NVMe: Split non-mergeable bio requests
  fs: Starting sector size calculation
  NVMe: End-to-end data protection
  NVMe: Retry failed bio requests

 drivers/block/nvme.c |  369 +++++++++++++++++++++++++++++++++++++++++++++++---
 fs/bio-integrity.c   |    4 +-
 include/linux/nvme.h |   30 ++++-
 3 files changed, 375 insertions(+), 28 deletions(-)
