From: hch@lst.de (Christoph Hellwig)
Date: Tue, 4 Apr 2017 15:09:26 +0200
Subject: [PATCH rfc 5/6] block: Add rdma affinity based queue mapping
 helper
In-Reply-To: <becb84ac-7819-a207-56b1-70f16cb80e42@mellanox.com>
References: <1491140492-25703-1-git-send-email-sagi@grimberg.me>
 <1491140492-25703-6-git-send-email-sagi@grimberg.me>
 <becb84ac-7819-a207-56b1-70f16cb80e42@mellanox.com>
Message-ID: <20170404130926.GA16338@lst.de>

On Tue, Apr 04, 2017@10:46:54AM +0300, Max Gurtovoy wrote:
>> +	if (set->nr_hw_queues > dev->num_comp_vectors)
>> +		goto fallback;
>> +
>> +	for (queue = 0; queue < set->nr_hw_queues; queue++) {
>> +		mask = ib_get_vector_affinity(dev, first_vec + queue);
>> +		if (!mask)
>> +			goto fallback;
>
> Christoph,
> we can use fallback also in the blk-mq-pci.c in case pci_irq_get_affinity 
> fails, right ?

For PCI it shouldn't fail as the driver calling pci_irq_get_affinity
knows how it set up the interrupts.  So I don't think it's necessary there.
