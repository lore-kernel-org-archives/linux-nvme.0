From: ming.lei@redhat.com (Ming Lei)
Date: Tue, 12 Feb 2019 21:04:35 +0800
Subject: [PATCH V2 0/4] genirq/affinity: add .calc_sets for improving IRQ
 allocation & spread
Message-ID: <20190212130439.14501-1-ming.lei@redhat.com>

Hi,

Currently pre-caculated set vectors are provided by driver for
allocating & spread vectors. This way only works when drivers passes
same 'max_vecs' and 'min_vecs' to pci_alloc_irq_vectors_affinity(),
also requires driver to retry the allocating & spread.

As Bjorn and Keith mentioned, the current usage & interface for irq sets
is a bit awkward because the retrying should have been avoided by providing
one resonable 'min_vecs'. However, if 'min_vecs' isn't same with
'max_vecs', number of the allocated vectors is unknown before calling
pci_alloc_irq_vectors_affinity(), then each set's vectors can't be
pre-caculated.

Add a new callback of .calc_sets into 'struct irq_affinity' so that
driver can caculate set vectors after IRQ vector is allocated and
before spread IRQ vectors. Add 'priv' so that driver may retrieve
its private data via the 'struct irq_affinity'.


V2:
	- add .calc_sets instead of .setup_affinity() which is easy to
	be abused by drivers

Ming Lei (4):
  genirq/affinity: store irq set vectors in 'struct irq_affinity'
  genirq/affinity: add new callback for caculating set vectors
  nvme-pci: avoid irq allocation retrying via .calc_sets
  genirq/affinity: Document .calc_sets as required in case of multiple
    sets

 drivers/nvme/host/pci.c   | 63 ++++++++++++-----------------------------------
 drivers/pci/msi.c         |  4 +--
 include/linux/interrupt.h | 13 +++++++---
 kernel/irq/affinity.c     | 19 +++++++++-----
 4 files changed, 41 insertions(+), 58 deletions(-)

-- 
2.9.5
