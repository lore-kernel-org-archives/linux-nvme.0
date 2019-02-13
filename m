From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 13 Feb 2019 22:26:45 +0100 (CET)
Subject: [PATCH V3 4/5] nvme-pci: avoid irq allocation retrying via
 .calc_sets
In-Reply-To: <20190213151339.GE96272@google.com>
References: <20190213105041.13537-1-ming.lei@redhat.com>
 <20190213105041.13537-5-ming.lei@redhat.com>
 <20190213151339.GE96272@google.com>
Message-ID: <alpine.DEB.2.21.1902132159230.1659@nanos.tec.linutronix.de>

On Wed, 13 Feb 2019, Bjorn Helgaas wrote:

> On Wed, Feb 13, 2019@06:50:40PM +0800, Ming Lei wrote:
> > Currently pre-caculate each set vectors, and this way requires same
> > 'max_vecs' and 'min_vecs' passed to pci_alloc_irq_vectors_affinity(),
> > then nvme_setup_irqs() has to retry in case of allocation failure.
> 
> s/pre-caculate/precalculate/
> My usual "set vectors" question as on other patches.
> 
> > This usage & interface is a bit awkward because the retry should have
> > been avoided by providing one reasonable 'min_vecs'.
> > 
> > Implement the callback of .calc_sets, so that pci_alloc_irq_vectors_affinity()
> > can calculate each set's vector after IRQ vectors is allocated and
> > before spread IRQ, then NVMe's retry in case of irq allocation failure
> > can be removed.
> 
> s/irq/IRQ/

Let me rephrase that thing as well

  Subject: nvme-pci: Simplify interrupt allocation

  The NVME PCI driver contains a tedious mechanism for interrupt
  allocation, which is necessary to adjust the number and size of interrupt
  sets to the maximum available number of interrupts which depends on the
  underlying PCI capabilities and the available CPU resources.

  It works around the former short comings of the PCI and core interrupt
  allocation mechanims in combination with interrupt sets.

  The PCI interrupt allocation function allows to provide a maximum and a
  minimum number of interrupts to be allocated and tries to allocate as
  many as possible. This worked without driver interaction as long as there
  was only a single set of interrupts to handle.

  With the addition of support for multiple interrupt sets in the generic
  affinity spreading logic, which is invoked from the PCI interrupt
  allocation, the adaptive loop in the PCI interrupt allocation did not
  work for multiple interrupt sets. The reason is that depending on the
  total number of interrupts which the PCI allocation adaptive loop tries
  to allocate in each step, the number and the size of the interrupt sets
  need to be adapted as well. Due to the way the interrupt sets support was
  implemented there was no way for the PCI interrupt allocation code or the
  core affinity spreading mechanism to invoke a driver specific function
  for adapting the interrupt sets configuration.

  As a consequence the driver had to implement another adaptive loop around
  the PCI interrupt allocation function and calling that with maximum and
  minimum interrupts set to the same value. This ensured that the
  allocation either succeeded or immediately failed without any attempt to
  adjust the number of interrupts in the PCI code.

  The core code now allows drivers to provide a callback to recalculate the
  number and the size of interrupt sets during PCI interrupt allocation,
  which in turn allows the PCI interrupt allocation function to be called
  in the same way as with a single set of interrupts. The PCI code handles
  the adaptive loop and the interrupt affinity spreading mechanism invokes
  the driver callback to adapt the interrupt set configuration to the
  current loop value. This replaces the adaptive loop in the driver
  completely.

  Implement the NVME specific callback which adjusts the interrupt sets
  configuration and remove the adaptive allocation loop.

Thanks,

	tglx
