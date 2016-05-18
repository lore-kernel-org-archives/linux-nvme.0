From: mlin@kernel.org (Ming Lin)
Date: Tue, 17 May 2016 22:56:57 -0700
Subject: [PATCH 0/2] move nvme_cancel_io() to common code
Message-ID: <1463551019-16687-1-git-send-email-mlin@kernel.org>

From: Ming Lin <ming.l@samsung.com>

So it can be used by fabrics driver also.

Ming Lin (2):
  nvme: update nvme_cancel_io() a bit
  nvme: move nvme_cancel_io() to core.c

 drivers/nvme/host/core.c | 17 +++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  | 20 ++------------------
 3 files changed, 20 insertions(+), 18 deletions(-)

-- 
1.9.1
