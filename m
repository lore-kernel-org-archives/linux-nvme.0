From: mlin@kernel.org (Ming Lin)
Date: Mon, 25 Apr 2016 14:20:17 -0700
Subject: [PATCH v2 0/2] nvme_ns_remove() deadlock fix
Message-ID: <1461619219-18144-1-git-send-email-mlin@kernel.org>

From: Ming Lin <ming.l@ssi.samsung.com>

Hi Sunad,

I don't have device that can do namespace attribute change.
Could you help to verify these 2 patches fix the ns remove deadlock?

Thanks.

v2:
  - switch to RCU freeing the namespace

Ming Lin (2):
  nvme: switch to RCU freeing the namespace
  nvme: fix nvme_ns_remove() deadlock

 drivers/nvme/host/core.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

-- 
1.9.1
