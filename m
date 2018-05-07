From: logang@deltatee.com (Logan Gunthorpe)
Date: Mon, 7 May 2018 17:34:53 -0600
Subject: [PATCH v4 00/14] Copy Offload in NVMe Fabrics with P2P PCI Memory
In-Reply-To: <20180507232346.GI161390@bhelgaas-glaptop.roam.corp.google.com>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180507232346.GI161390@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <dc207a94-35a6-6182-1331-154ece9ac00d@deltatee.com>


> How do you envison merging this?  There's a big chunk in drivers/pci, but
> really no opportunity for conflicts there, and there's significant stuff in
> block and nvme that I don't really want to merge.
> 
> If Alex is OK with the ACS situation, I can ack the PCI parts and you could
> merge it elsewhere?

Honestly, I don't know. I guess with your ACK on the PCI parts, the vast
balance is NVMe stuff so we could look at merging it through that tree.
The block patch and IB patch are pretty small.

Thanks,

Logan
