From: a.dawn@samsung.com (Arnav Dawn)
Date: Mon, 29 May 2017 19:46:31 +0530
Subject: [PATCH v2 0/2] nvme: Support for FW activation without reset
References: <CGME20170529141634epcas5p3913fde49b40fcce3cc15971688820834@epcas5p3.samsung.com>
Message-ID: <1496067391-26143-1-git-send-email-a.dawn@samsung.com>

This series of two patches adds support for FW activation without reset.

Arnav Dawn (2):
  nvme: Adding support for FW Slot info log
  nvme: Add support for FW activation without reset

 drivers/nvme/host/core.c | 109 ++++++++++++++++++++++++++++++++++++++++-------
 drivers/nvme/host/nvme.h |   5 ++-
 drivers/nvme/host/scsi.c |  26 ++++++++---
 include/linux/nvme.h     |  10 +++++
 4 files changed, 127 insertions(+), 23 deletions(-)

-- 
1.9.1
