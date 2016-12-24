From: jsmart2021@gmail.com (James Smart)
Date: Sat, 24 Dec 2016 09:46:37 -0800
Subject: [PATCH 0/3] nvme fc: Sync with FC-NVME spec rev 1.14
Message-ID: <585eb47d.k1ljfudCPAIbKa+X%jsmart2021@gmail.com>


Update FC-NVME definitions to match FC-NVME r1.14 (16-020vB).
Includes the following:
- Addition of "status_code" field to ERSP IU
- Addition of FC-NVME LS RJT reason_codes and reason_explanations

James Smart (3):
  Sync FC-NVME header with standard
  nvme_fc: Add check of status_code in ERSP_IU
  nvmet_fc: Sync NVME LS reject reasons with spec

 drivers/nvme/host/fc.c   |  1 +
 drivers/nvme/target/fc.c | 19 +++++++++-----
 include/linux/nvme-fc.h  | 66 ++++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 71 insertions(+), 15 deletions(-)

-- 
2.5.0
