From: logang@deltatee.com (Logan Gunthorpe)
Date: Wed, 7 Aug 2019 09:58:06 -0600
Subject: [PATCH v2 03/14] PCI/P2PDMA: Add constants for not-supported
 result upstream_bridge_distance()
In-Reply-To: <20190807055455.GA6627@lst.de>
References: <20190730163545.4915-1-logang@deltatee.com>
 <20190730163545.4915-4-logang@deltatee.com> <20190807055455.GA6627@lst.de>
Message-ID: <4b0c012a-c3a1-a1c0-b098-8b350963aed1@deltatee.com>



On 2019-08-06 11:54 p.m., Christoph Hellwig wrote:
> On Tue, Jul 30, 2019@10:35:34AM -0600, Logan Gunthorpe wrote:
>> Add constant flags to indicate two devices are not supported or whether
>> the data path goes through the host bridge instead of using the negative
>> values -1 and -2.
>>
>> This helps annotate the code better, but the main reason is so we
>> can use the information to store the required mapping method in an
>> xarray.
>>
>> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
>> Reviewed-by: Christian K?nig <christian.koenig at amd.com>
> 
> Is there really no way to keep the distance separate from the type of
> the connection as I requested?  I think that would avoid a lot of
> confusion down the road.

Well I separated it in the xarray and the interface. It only stores the
type of mapping, not the distance and uses pci_p2pdma_map_type() to
retrieve it.

We only calculate it at the same time as we calculate the distance. This
is necessary because, to calculate the type, we have to walk the tree
and check the ACS bits. If we separated it, we'd have to walk the tree
twice in a very similar way just to determine both the distance and the
mapping type.

I'll apply your other feedback to a v3 next week.

Logan
