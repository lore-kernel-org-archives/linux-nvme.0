From: mlin@kernel.org (Ming Lin)
Date: Wed, 18 May 2016 14:05:00 -0700
Subject: [PATCH v2 0/2] move nvme_cancel_io() to common code
Message-ID: <1463605502-27839-1-git-send-email-mlin@kernel.org>

From: Ming Lin <ming.l@samsung.com>

So it can be used by fabrics driver also.

v2:
  - not declare "ctrl"
  - rename nvme_cancel_io to nvme_cancel_request

Ming Lin (2):
  nvme: update and rename nvme_cancel_io to nvme_cancel_request
  nvme: move nvme_cancel_request() to common code

 drivers/nvme/host/core.c | 17 +++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  | 20 ++------------------
 3 files changed, 20 insertions(+), 18 deletions(-)

-- 
1.9.1
