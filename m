From: gklkml16@gmail.com (Ganapatrao Kulkarni)
Date: Mon, 22 Jan 2018 09:55:55 +0530
Subject: Why NVMe MSIx vectors affinity set across NUMA nodes?
Message-ID: <CAKTKpr6V=UPtRRApvQ_TAEuRQB8qqgvDmaaXFjch4wpZUqoAfw@mail.gmail.com>

Hi,

I  have observed that NVMe driver splitting interrupt affinity of MSIx
vectors among available NUMA nodes,
any specific reason for that?

i see this is happening due to pci flag PCI_IRQ_AFFINITY is set in
function nvme_setup_io_queues

   nr_io_queues = pci_alloc_irq_vectors(pdev, 1, nr_io_queues,
                        PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY);

IMO, having all vectors on same node CPUs improves interrupt latency
than distributing among all nodes.


thanks
Ganapat
