From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 8 Jun 2016 09:28:54 +0200
Subject: [PATCH v3 0/6] Introduce pci_(request|release)_(mem|io)_regions
In-Reply-To: <cover.1465200424.git.jthumshirn@suse.de>
References: <cover.1465200424.git.jthumshirn@suse.de>
Message-ID: <20160608072854.ivcfvtlgxab2xkmp@c203.arch.suse.de>

On Tue, Jun 07, 2016@09:44:00AM +0200, Johannes Thumshirn wrote:
> The first patch in this series introduces the following 4 helper functions to
> the PCI core:
> 
> * pci_request_mem_regions()
> * pci_request_io_regions()
> * pci_release_mem_regions()
> * pci_release_io_regions()
> 
> which encapsulate the request and release of a PCI device's memory or I/O
> bars.
> 
> The subsequent patches convert the drivers, which use the
> pci_request_selected_regions(pdev, 
> 	pci_select_bars(pdev, IORESOURCE_MEM), name); 
> and similar pattern to use the new interface.
> 
> This was suggested by Christoph Hellwig in
> http://lists.infradead.org/pipermail/linux-nvme/2016-May/004570.html and
> tested on kernel v4.6 with NVMe.
> 

Btw, as I've seen already Jeff applying the Intel Ethernet patch to his
tree, I think this should go via the PCI tree as the build dependency is
the PCI patch.

Thanks,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
