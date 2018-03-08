From: keith.busch@intel.com (Keith Busch)
Date: Thu, 8 Mar 2018 16:10:36 -0700
Subject: [GIT PULL] nvme fixes for 4.16-rc
Message-ID: <20180308231036.GB14765@localhost.localdomain>

Hi Jens,

A few late fixes for 4.16:

 * Reverting sysfs slave device links for native nvme multipathing.
   The hidden disk attributes broke common user tools.

 * A fix for a PPC pci error handling regression.

 * Update pci interrupt count to consider the actual IRQ spread, fixing
   potentially poor initial queue affinity.

 * Off-by-one errors in nvme-fc queue sizes

 * A fabrics discovery fix to be more tolerant with user tools.

Please pull!

The following changes since commit 468f098734ab095b72d8af26bcd4bcb2ed31a3be:

  Merge branch 'for-jens' of git://git.infradead.org/nvme into for-linus (2018-02-28 12:18:58 -0700)

are available in the Git repository at:

  http://git.infradead.org/nvme.git/shortlog/refs/heads/nvme-4.16-rc5 

for you to fetch changes up to d157e5343cb360a525e6b3e7924612a9a90df3b7:

  nvme_fc: rework sqsize handling (2018-03-08 10:39:58 -0700)

----------------------------------------------------------------
Christoph Hellwig (1):
      Revert "nvme: create 'slaves' and 'holders' entries for hidden controllers"

James Smart (1):
      nvme_fc: rework sqsize handling

Ming Lei (1):
      nvme: pci: pass max vectors as num_possible_cpus() to pci_alloc_irq_vectors

Roland Dreier (1):
      nvme-fabrics: Ignore nr_io_queues option for discovery controllers

Wen Xiong (1):
      nvme-pci: Fix EEH failure on ppc

 drivers/nvme/host/core.c      |  2 --
 drivers/nvme/host/fabrics.c   |  5 +++++
 drivers/nvme/host/fc.c        | 27 +++++++++++++++++----------
 drivers/nvme/host/multipath.c | 30 ------------------------------
 drivers/nvme/host/nvme.h      |  8 --------
 drivers/nvme/host/pci.c       | 15 ++++++++-------
 6 files changed, 30 insertions(+), 57 deletions(-)
