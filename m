From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 26 Dec 2018 18:37:53 +0800
Subject: [PATCH 0/2] nvme pci: two fixes on nvme_setup_irqs
Message-ID: <20181226103755.2101-1-ming.lei@redhat.com>

Hi,

The 1st one fixes the case that -ENOSPC is returned from
pci_alloc_irq_vectors_affinity().

The 2nd one fixes the case that -EINVAL is returned from
pci_alloc_irq_vectors_affinity().


Ming Lei (2):
  nvme pci: fix nvme_setup_irqs()
  nvme pci: try to allocate multiple irq vectors again in case of
    -EINVAL

 drivers/nvme/host/pci.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

Cc: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at fb.com>

-- 
2.9.5
