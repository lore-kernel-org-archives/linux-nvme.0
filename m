From: logang@deltatee.com (Logan Gunthorpe)
Date: Fri, 31 Aug 2018 09:44:53 -0600
Subject: [PATCH v5 06/13] PCI/P2PDMA: Add P2P DMA driver writer's
 documentation
In-Reply-To: <382af881-0ae1-0274-4628-0137071125b1@infradead.org>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-7-logang@deltatee.com>
 <382af881-0ae1-0274-4628-0137071125b1@infradead.org>
Message-ID: <f0edec85-02d1-4592-5bce-629fb5e0ceae@deltatee.com>

Hey,

Thanks for the review. I'll make the fixes for the next version.

On 30/08/18 06:34 PM, Randy Dunlap wrote:
>> +With the client list in hand, the orchestrator may then call> +:c:func:`pci_p2pmem_find()` to obtain a published P2P memory provider
>> +that is supported (behind the same root port) as all the clients. If more
>> +than one provider is supported, the one nearest to all the clients will
>> +be chosen first. If there are more than one provider is an equal distance
>> +away, the one returned will be chosen at random. This function returns the PCI
> 
> random or just arbitrarily?

Randomly. See pci_p2pmem_find() in patch 1. We use prandom_u32_max() to
select any of the supported devices.

Logan
