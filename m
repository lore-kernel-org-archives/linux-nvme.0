From: guenther@tum.de (Stephan =?utf-8?Q?G=C3=BCnther?=)
Date: Wed, 4 Nov 2015 00:31:51 +0100
Subject: [PATCH 0/2] nvme: adding support for Apple's NVMe controller
Message-ID: <33537e8a12dff1f96eaec9098724d01e@localhost>

Adding support for Apple's NVMe controller. Patches are tested on
linux-4.3 on a MacBook8,1. /dev/nvme0n1p* are recognized, bulk transfers
work, and the previous patches have been confirmed to work on NVMe-based
MacBookAir7,1 (see patches for details).

Stephan G?nther (2):
  nvme: enforce ordered split transfers
  nvme: add pci device id for Apple NVMe controller

 drivers/block/nvme-core.c | 9 +++++++++
 1 file changed, 9 insertions(+)
