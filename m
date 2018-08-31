From: logang@deltatee.com (Logan Gunthorpe)
Date: Fri, 31 Aug 2018 13:11:48 -0600
Subject: [PATCH v5 06/13] PCI/P2PDMA: Add P2P DMA driver writer's
 documentation
In-Reply-To: <30411655-9b90-749e-857f-318dac7cccbf@amd.com>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-7-logang@deltatee.com>
 <98bff500-4e4c-3a34-6762-16ef4b076d90@amd.com>
 <6820d451-9591-1979-00bf-60c65fc4f136@deltatee.com>
 <30411655-9b90-749e-857f-318dac7cccbf@amd.com>
Message-ID: <9452ee6c-e989-d178-cd51-f29782ad9b31@deltatee.com>



On 31/08/18 11:38 AM, Christian K?nig wrote:
> If you can separate out adding the detection I can take a look adding 
> this with my DMA-buf P2P efforts.

Oh, maybe my previous email wasn't clear, but I'd say that detection is
already separate from ZONE_DEVICE. Nothing really needs to be changed.
I just think you'll probably want to write you're own function similar
to pci_p2pdma_distance that perhaps just takes two pci_devs instead of
the list of clients as is needed by nvme-of-like users.

To enable a whitelist we just have to handle the case where
upstream_bridge_distance() returns -1 and check if the devices are in
the same root complex with supported root ports before deciding the
transaction is not supported.

Logan
