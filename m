From: gklkml16@gmail.com (Ganapatrao Kulkarni)
Date: Mon, 22 Jan 2018 22:52:59 +0530
Subject: Why NVMe MSIx vectors affinity set across NUMA nodes?
In-Reply-To: <20180122171437.GL12043@localhost.localdomain>
References: <CAKTKpr6V=UPtRRApvQ_TAEuRQB8qqgvDmaaXFjch4wpZUqoAfw@mail.gmail.com>
 <20180122171437.GL12043@localhost.localdomain>
Message-ID: <CAKTKpr59h-PXz60BNkx4_80gHyeFawcJW17dt9Y5VRrmHRsSQA@mail.gmail.com>

On Mon, Jan 22, 2018@10:44 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Mon, Jan 22, 2018@09:55:55AM +0530, Ganapatrao Kulkarni wrote:
>> Hi,
>>
>> I  have observed that NVMe driver splitting interrupt affinity of MSIx
>> vectors among available NUMA nodes,
>> any specific reason for that?
>>
>> i see this is happening due to pci flag PCI_IRQ_AFFINITY is set in
>> function nvme_setup_io_queues
>>
>>    nr_io_queues = pci_alloc_irq_vectors(pdev, 1, nr_io_queues,
>>                         PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY);
>>
>> IMO, having all vectors on same node CPUs improves interrupt latency
>> than distributing among all nodes.
>
> What affinity maps are you seeing? It's not supposed to share one vector
> across two NUMA nodes, unless you simply don't have enough vectors.

There are 31 MSIx vectors getting initialised(one per NVMe queue) and
out of it, 0-15 are getting
affinity set to node 0 CPUs and vectors 16-30 are getting set to node 1.
My question is, why not set affinity to all vectors from same node
CPUs, what was need to use flag PCI_IRQ_AFFINITY?

thanks
Ganapat
