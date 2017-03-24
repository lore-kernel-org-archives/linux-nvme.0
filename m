From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Thu, 23 Mar 2017 20:41:21 -0700
Subject: [PATCH 0/6] nvme_fc: repost spec updates and fixes
Message-ID: <20170324034127.8676-1-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

The following items have been posted prior, but not pulled in. Resubmitting


James Smart (6):
  nvme_fc: Sync FC-NVME header with standard
  nvme_fc: Add check of status_code in ERSP_IU
  nvmet_fc: Sync NVME LS reject reasons with spec
  nvme_fc: correct LS validation
  nvmet_fc: Clear SG list to avoid double frees
  nvme_fc: Clean up host fcpio done status handling

 drivers/nvme/host/fc.c         | 24 ++++++++-------
 drivers/nvme/target/fc.c       | 21 ++++++++-----
 include/linux/nvme-fc-driver.h |  6 ++--
 include/linux/nvme-fc.h        | 68 ++++++++++++++++++++++++++++++++++++------
 4 files changed, 89 insertions(+), 30 deletions(-)

-- 
2.9.3
