From: dan.j.williams@intel.com (Dan Williams)
Date: Fri, 21 Oct 2016 17:25:21 -0700
Subject: [PATCH 0/5] ahci: nvme remap support
Message-ID: <147709592108.3733.7194541797066785254.stgit@dwillia2-desk3.amr.corp.intel.com>

Some Intel ahci implementations have the capability to expose another
pci-express device's memory resources through an ahci memory bar.  Add
the enabling to detect these configurations and register the resources
for the nvme driver to consume. Otherwise, the nvme device is
effectively hidden from the kernel for this configuration.

---

Dan Williams (5):
      ahci: nvme remap support
      nvme: rename "pci" operations to "mmio"
      nvme: introduce nvme_dev_ops
      nvme: move common definitions to pci.h
      nvme: ahci remap support

 drivers/ata/Kconfig        |   11 +
 drivers/ata/ahci.c         |  165 +++++++++++++++++++++
 drivers/ata/ahci.h         |   14 ++
 drivers/nvme/host/Makefile |    2 
 drivers/nvme/host/ahci.c   |  198 +++++++++++++++++++++++++
 drivers/nvme/host/pci.c    |  344 +++++++++++++++++++++++---------------------
 drivers/nvme/host/pci.h    |   98 +++++++++++++
 7 files changed, 664 insertions(+), 168 deletions(-)
 create mode 100644 drivers/nvme/host/ahci.c
 create mode 100644 drivers/nvme/host/pci.h
