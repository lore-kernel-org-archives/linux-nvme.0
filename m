From: ednadols@linux.microsoft.com (Edmund Nadolski)
Date: Tue, 30 Apr 2019 13:09:03 -0700
Subject: [PATCH v2 0/2] nvme: some cleanup
Message-ID: <20190430200905.28341-1-ednadols@linux.microsoft.com>

This series clarifies the code intent by adding some macros and fixing
a few miscellaneous typos.

v2 changes:
 - Move typo fixes into separate patch.
 - Drop struct member comments.
 - Clarify changelog remarks.

Edmund Nadolski (2):
  nvme: nvme_set_queue_count should use descriptive macros
  nvme: fix some typos

 drivers/nvme/host/core.c | 8 ++++++--
 drivers/nvme/host/nvme.h | 2 +-
 drivers/nvme/host/pci.c  | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.20.1
