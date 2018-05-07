From: logang@deltatee.com (Logan Gunthorpe)
Date: Mon, 7 May 2018 17:09:46 -0600
Subject: [PATCH v4 01/14] PCI/P2PDMA: Support peer-to-peer memory
In-Reply-To: <20180507230034.GE161390@bhelgaas-glaptop.roam.corp.google.com>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180423233046.21476-2-logang@deltatee.com>
 <20180507230034.GE161390@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <092f3da9-764e-2ece-b3a8-a9b3ab3c49a8@deltatee.com>

Thanks for the review. I'll apply all of these for the changes for next
version of the set.
>> +/*
>> + * If a device is behind a switch, we try to find the upstream bridge
>> + * port of the switch. This requires two calls to pci_upstream_bridge():
>> + * one for the upstream port on the switch, one on the upstream port
>> + * for the next level in the hierarchy. Because of this, devices connected
>> + * to the root port will be rejected.
>> + */
>> +static struct pci_dev *get_upstream_bridge_port(struct pci_dev *pdev)
> 
> This function doesn't seem to be used anymore.  Thanks for all your hard
> work to get rid of it!

Oops, I thought I had gotten rid of it entirely, but I guess I messed it
up a bit and it gets removed in patch 4. I'll fix it for v5.

Logan
