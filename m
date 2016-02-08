From: mlin@kernel.org (Ming Lin)
Date: Mon,  8 Feb 2016 14:24:40 -0800
Subject: [PATCH 0/4] nvme: split pci module out of core module
Message-ID: <1454970284-29543-1-git-send-email-mlin@kernel.org>

We'll have nvme over fabric dirver soon.
This series split nvme pci module out of nvme core module.

nvme.ko is split into 2 modules:
nvme-core.ko: the core part
nvme.ko: the PCI driver

Ming Lin (4):
  nvme: move timeout variables to core.c and export it
  nvme: export more symbols
  nvme: split dev_list_lock
  nvme: split pci module out of core module

 drivers/nvme/host/Kconfig  | 10 +++++++---
 drivers/nvme/host/Makefile | 10 ++++++----
 drivers/nvme/host/core.c   | 40 +++++++++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h   |  2 --
 drivers/nvme/host/pci.c    | 26 ++------------------------
 5 files changed, 52 insertions(+), 36 deletions(-)

-- 
1.9.1
