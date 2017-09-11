From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 11 Sep 2017 14:55:12 -0700
Subject: [GIT PULL] nvme fixes for 4.14, take 2
Message-ID: <20170911215512.GA9661@infradead.org>

Hi Jens,

below are a few small fixes for the current merge window:

 - fix string.h compilation failures with the new memcpy_and_pad
   helper (Martin Wilck)
 - fix incorrect dereference of a PCI data structure in the lightnvm
   support code (me)
 - HMB fixes (Akinobu Mita and me)

The following changes since commit 09c2c359be546df45be0b158ea1d3cc8ea83c876:

  block: fix integer overflow in __blkdev_sectors_to_bio_pages() (2017-09-11 09:46:49 -0600)

are available in the git repository at:

  git://git.infradead.org/nvme.git nvme-4.14

for you to fetch changes up to 1359798f9d4082eb04575efdd19512fbd9c28464:

  string.h: un-fortify memcpy_and_pad (2017-09-11 12:29:41 -0400)

----------------------------------------------------------------
Akinobu Mita (1):
      nvme-pci: use appropriate initial chunk size for HMB allocation

Christoph Hellwig (4):
      nvme: fix lightnvm check
      nvme-pci: fix host memory buffer allocation fallback
      nvme-pci: propagate (some) errors from host memory buffer setup
      nvme-pci: implement the HMB entry number and size limitations

Martin Wilck (1):
      string.h: un-fortify memcpy_and_pad

 drivers/nvme/host/core.c     | 11 ++++---
 drivers/nvme/host/lightnvm.c | 26 ----------------
 drivers/nvme/host/nvme.h     | 13 +++++---
 drivers/nvme/host/pci.c      | 74 ++++++++++++++++++++++++++++++--------------
 include/linux/nvme.h         |  4 ++-
 include/linux/string.h       | 15 ++-------
 6 files changed, 70 insertions(+), 73 deletions(-)
