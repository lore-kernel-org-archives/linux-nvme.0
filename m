From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 22 Jul 2018 14:44:13 +0200
Subject: [GIT PULL] NVMe fixes for 4.18-rc6
Message-ID: <20180722124413.GA16254@infradead.org>

Hi Linus,

please pull these NVMe fixes directly instead of through Jens so that
he can enjoy more of his vacation!

The following changes since commit 70dbcc2254fa2a9add74a122b9dac954c4736e01:

  bsg: fix bogus EINVAL on non-data commands (2018-07-11 08:48:28 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-for-4.18

for you to fetch changes up to 9b382768135ee3ff282f828c906574a8478e036b:

  nvme: fix handling of metadata_len for NVME_IOCTL_IO_CMD (2018-07-20 07:43:59 -0700)

----------------------------------------------------------------
NVMe fixes for 4.18-rc6:

 - fix a regression in 4.18 that causes a memory leak on probe failure
   (Keith Bush)
 - fix a deadlock in the passthrough ioctl code (Scott Bauer)
 - don't enable AENs if not supported (Weiping Zhang)
 - fix an old regression in metadata handling in the passthrough ioctl
   code (Roland Dreier)

----------------------------------------------------------------
Keith Busch (1):
      nvme-pci: fix memory leak on probe failure

Roland Dreier (1):
      nvme: fix handling of metadata_len for NVME_IOCTL_IO_CMD

Scott Bauer (1):
      nvme: ensure forward progress during Admin passthru

Weiping Zhang (1):
      nvme: don't enable AEN if not supported

 drivers/nvme/host/core.c | 63 ++++++++++++++++++++++++++----------------------
 drivers/nvme/host/pci.c  | 12 +++++----
 2 files changed, 41 insertions(+), 34 deletions(-)
