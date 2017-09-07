From: jsmart2021@gmail.com (James Smart)
Date: Thu,  7 Sep 2017 13:20:22 -0700
Subject: [PATCH 0/2] nvme/nvme-fc: add transport SGL type
Message-ID: <20170907202024.25207-1-jsmart2021@gmail.com>

These patches add the new transport-specific SGL type and updates
the fc transport for its use of the type.

James Smart (2):
  nvme: Add transport SGL definitions
  nvme-fc: use transport-specific sgl format

 drivers/nvme/host/fc.c | 13 +++++++------
 include/linux/nvme.h   |  6 ++++++
 2 files changed, 13 insertions(+), 6 deletions(-)

-- 
2.13.1
