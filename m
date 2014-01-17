From: agordeev@redhat.com (Alexander Gordeev)
Date: Fri, 17 Jan 2014 17:02:14 +0100
Subject: [PATCH v2 0/9] Phase out pci_enable_msi_block()
Message-ID: <cover.1389904166.git.agordeev@redhat.com>

This series is against "next" branch in Bjorn's repo:
git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git

Changes from v1 to v2:
  - added a regression fix "ahci: Fix broken fallback to single
    MSI mode" as patch 1/9;
  - the series is reordered to move the regression fix in front;
  - at Bjorn's request pci_enable_msi() is un-deprecated;
  - as result, pci_enable_msi_range(pdev, 1, 1) styled calls
    rolled back to pci_enable_msi(pdev);
  - nvme bug fix moved out as a separate patch 5/9 "nvme: Fix
    invalid call to irq_set_affinity_hint()"
  - patches changelog elaborated a bit;

Bjorn,

As the release is supposedly this weekend, do you prefer
the patches to go to your tree or to individual trees after
the release?

Thanks!

Alexander Gordeev (9):
  ahci: Fix broken fallback to single MSI mode
  ahci: Use pci_enable_msi_range()
  ipr: Get rid of superfluous call to pci_disable_msi/msix()
  ipr: Use pci_enable_msi_range() and pci_enable_msix_range()
  nvme: Fix invalid call to irq_set_affinity_hint()
  nvme: Use pci_enable_msi_range() and pci_enable_msix_range()
  vfio: Use pci_enable_msi_range() and pci_enable_msix_range()
  ath10k: Use pci_enable_msi_range()
  wil6210: Use pci_enable_msi_range()

 drivers/ata/ahci.c                          |   18 +++++-----
 drivers/block/nvme-core.c                   |   33 ++++-------------
 drivers/net/wireless/ath/ath10k/pci.c       |   20 +++++-----
 drivers/net/wireless/ath/wil6210/pcie_bus.c |   36 ++++++++++---------
 drivers/scsi/ipr.c                          |   51 +++++++++-----------------
 drivers/vfio/pci/vfio_pci_intrs.c           |   12 ++++--
 6 files changed, 72 insertions(+), 98 deletions(-)

-- 
1.7.7.6
