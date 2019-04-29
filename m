From: ednadols@linux.microsoft.com (Edmund Nadolski)
Date: Mon, 29 Apr 2019 10:35:31 -0700
Subject: [PATCH 0/2] nvme: some cleanup
Message-ID: <20190429173533.10366-1-ednadols@linux.microsoft.com>

This series clarifies the code by adding some macros, comments,
and fixing a few miscellaneous typos.

Edmund Nadolski (2):
  nvme: nvme_set_queue_count should use descriptive macros
  nvme: add clarifying comments and fix some typos

 drivers/nvme/host/core.c |  8 ++++++--
 drivers/nvme/host/nvme.h | 32 ++++++++++++++++----------------
 drivers/nvme/host/pci.c  |  2 +-
 3 files changed, 23 insertions(+), 19 deletions(-)

-- 
2.20.1
