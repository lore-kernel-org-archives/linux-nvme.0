From: keith.busch@intel.com (Keith Busch)
Date: Thu,  3 Jan 2019 15:50:29 -0700
Subject: [PATCHv2 0/4] NVMe IRQ sets fixups
Message-ID: <20190103225033.11249-1-keith.busch@intel.com>

Changes from v1:

  Added documentation to Documentation/PCI/MSI-HOWTO.txt

  Grammar, spelling, and format fixes to commit logs and code comments.

Keith Busch (4):
  nvme-pci: Set tagset nr_maps just once
  nvme-pci: Distribute io queue types after creation
  PCI/MSI: Handle vector reduce and retry
  nvme-pci: Use PCI to handle IRQ reduce and retry

 Documentation/PCI/MSI-HOWTO.txt |  36 +++++++++++-
 drivers/nvme/host/pci.c         | 126 +++++++++++++++++++---------------------
 drivers/pci/msi.c               |  20 ++-----
 include/linux/interrupt.h       |   5 ++
 4 files changed, 107 insertions(+), 80 deletions(-)

-- 
2.14.4
