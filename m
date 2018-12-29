From: ming.lei@redhat.com (Ming Lei)
Date: Sat, 29 Dec 2018 11:26:47 +0800
Subject: [PATCH V2 0/3] nvme pci: two fixes on nvme_setup_irqs
Message-ID: <20181229032650.27256-1-ming.lei@redhat.com>

Hi,

The 1st one fixes the case that -EINVAL is returned from pci_alloc_irq_vectors_affinity(),
and it is found without this patch QEMU may fallback to single queue if CPU cores is >= 64.

The 2st one fixes the case that -ENOSPC is returned from pci_alloc_irq_vectors_affinity(),
and boot failure is observed on aarch64 system with less irq vectors.

The last one introduces modules parameter of 'default_queues' for addressing irq vector
exhaustion issue reported by Shan Hai.

Ming Lei (3):
  PCI/MSI: preference to returning -ENOSPC from
    pci_alloc_irq_vectors_affinity
  nvme pci: fix nvme_setup_irqs()
  nvme pci: introduce module parameter of 'default_queues'

 drivers/nvme/host/pci.c | 31 ++++++++++++++++++++++---------
 drivers/pci/msi.c       | 20 +++++++++++---------
 2 files changed, 33 insertions(+), 18 deletions(-)

Cc: Shan Hai <shan.hai at oracle.com>
Cc: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at fb.com>
Cc: linux-pci at vger.kernel.org,
Cc: Bjorn Helgaas <bhelgaas at google.com>,

-- 
2.9.5
