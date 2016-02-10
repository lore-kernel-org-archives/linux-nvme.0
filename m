From: mlin@kernel.org (Ming Lin)
Date: Tue,  9 Feb 2016 16:07:48 -0800
Subject: [PATCH v2 0/5] split pci module out of core module
Message-ID: <1455062873-18392-1-git-send-email-mlin@kernel.org>

From: Ming Lin <ming.l@ssi.samsung.com>

We'll have nvme over fabric dirver soon.
This series split nvme pci module out of nvme core module.

nvme.ko is split into 2 modules:
nvme-core.ko: the core part
nvme.ko: the PCI driver

v2:
  - add Sagi's patch to take proper references to the transport driver on open
  - add review tags
  - don't change the CONFIG name

Ming Lin (4):
  nvme: move timeout variables to core.c and export it
  nvme: export more functions
  nvme: split dev_list_lock
  nvme: split pci module out of core module

Sagi Grimberg (1):
  nvme/host: reference the fabric module for each bdev open callout

 drivers/nvme/host/Kconfig  |  6 ++++-
 drivers/nvme/host/Makefile | 10 ++++----
 drivers/nvme/host/core.c   | 57 ++++++++++++++++++++++++++++++++++++++++++----
 drivers/nvme/host/nvme.h   |  3 +--
 drivers/nvme/host/pci.c    | 27 +++-------------------
 5 files changed, 67 insertions(+), 36 deletions(-)

-- 
1.9.1
