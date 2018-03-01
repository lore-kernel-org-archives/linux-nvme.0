From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 1 Mar 2018 12:36:43 -0700
Subject: [PATCH v2 03/10] PCI/P2PDMA: Add PCI p2pmem dma mappings to
 adjust the bus offset
In-Reply-To: <20180301174941.GG13722@bhelgaas-glaptop.roam.corp.google.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-4-logang@deltatee.com>
 <20180301174941.GG13722@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <731c648d-5af3-1d5c-7169-07df12b79a41@deltatee.com>



On 01/03/18 10:49 AM, Bjorn Helgaas wrote:
>> +int pci_p2pdma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>> +		      enum dma_data_direction dir)
> 
> Same question as before about why the mixture of "pci_*" interfaces
> that take "struct device *" parameters.

In this case, per the discussion in v1, it was felt the _map_sg() 
function should take the same arguments as dma_map_sg().

Logan
