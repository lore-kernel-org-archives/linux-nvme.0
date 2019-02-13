From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 13 Feb 2019 18:50:36 +0800
Subject: [PATCH V3 0/5] genirq/affinity: add .calc_sets for improving IRQ
 allocation & spread
Message-ID: <20190213105041.13537-1-ming.lei@redhat.com>

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
before spread IRQ vectors.

V3:
	- don't mark 'affd' as const in related functions
	- add sanity check on affd->nr_sets
	- remove the local variable of 'nr_sets' in irq_create_affinity_masks
	- set .nr_sets as 2 in nvme
	- update comment in msi.c

V2:
	- add .calc_sets instead of .setup_affinity() which is easy to
	be abused by drivers

Ming Lei (5):
  genirq/affinity: don't mark 'affd' as const
  genirq/affinity: store irq set vectors in 'struct irq_affinity'
  genirq/affinity: add new callback for caculating set vectors
  nvme-pci: avoid irq allocation retrying via .calc_sets
  genirq/affinity: Document .calc_sets as required in case of multiple
    sets

 drivers/nvme/host/pci.c   | 63 ++++++++++++-----------------------------------
 drivers/pci/msi.c         | 34 ++++++++++++++-----------
 include/linux/interrupt.h | 13 +++++++---
 include/linux/pci.h       |  4 +--
 kernel/irq/affinity.c     | 26 ++++++++++++-------
 5 files changed, 64 insertions(+), 76 deletions(-)

-- 
2.9.5
