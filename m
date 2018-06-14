From: srinath.mannam@broadcom.com (Srinath Mannam)
Date: Thu, 14 Jun 2018 15:37:28 +0530
Subject: Requirement to get BAR pci_bus_address in user space
Message-ID: <CABe79T41Cr0mjH_k2drzccHvObFwRcW3n+WKCj0JvFUBy0wz-A@mail.gmail.com>

Hi Bjorn,


We observed an issue in NVMe CMD cards in SPDK NVMe libraries.
Similar issue fixed with "nvme-pci: Use PCI bus address for
data/queues in CMB" commit in nvme kernel driver.
As per the fix, pci_bus_address of CMB bar is required to program to NVMe cards.

We need to implement similar fix for SPDK NVMe libraries also.

User space libraries get pci device resource information (resource phy
address, resource size) from resource file in sysfs.
But no mechanism available to get  pci_bus_address of corresponding
resource physical address in sysfs.

Please suggest me if any alternate mechanism available to get
pci_bus_address in user space.

Thank you.

Regards,
Srinath.
