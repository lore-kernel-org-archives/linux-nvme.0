From: keith.busch@intel.com (Keith Busch)
Date: Mon, 22 Jan 2018 10:14:37 -0700
Subject: Why NVMe MSIx vectors affinity set across NUMA nodes?
In-Reply-To: <CAKTKpr6V=UPtRRApvQ_TAEuRQB8qqgvDmaaXFjch4wpZUqoAfw@mail.gmail.com>
References: <CAKTKpr6V=UPtRRApvQ_TAEuRQB8qqgvDmaaXFjch4wpZUqoAfw@mail.gmail.com>
Message-ID: <20180122171437.GL12043@localhost.localdomain>

On Mon, Jan 22, 2018@09:55:55AM +0530, Ganapatrao Kulkarni wrote:
> Hi,
> 
> I  have observed that NVMe driver splitting interrupt affinity of MSIx
> vectors among available NUMA nodes,
> any specific reason for that?
> 
> i see this is happening due to pci flag PCI_IRQ_AFFINITY is set in
> function nvme_setup_io_queues
> 
>    nr_io_queues = pci_alloc_irq_vectors(pdev, 1, nr_io_queues,
>                         PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY);
> 
> IMO, having all vectors on same node CPUs improves interrupt latency
> than distributing among all nodes.

What affinity maps are you seeing? It's not supposed to share one vector
across two NUMA nodes, unless you simply don't have enough vectors.
