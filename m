From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Fri, 12 Apr 2019 00:18:30 +0900
Subject: [PATCH 0/2] nvme: Check size of command structures
Message-ID: <20190411151832.26481-1-minwoo.im.dev@gmail.com>

Many command structures have been added in linux/nvme.h wihtout
BUILD_BUG_ON() check.  It also needs to be assured to avoid unintended
growth of structures.

Minwoo Im (2):
  nvme: fabrics: Make sure command struct size fixed
  nvme: pci: Make sure command struct size fixed

 drivers/nvme/host/fabrics.c | 1 +
 drivers/nvme/host/pci.c     | 7 +++++++
 2 files changed, 8 insertions(+)

-- 
2.17.1
