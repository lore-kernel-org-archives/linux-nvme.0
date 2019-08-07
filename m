From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 7 Aug 2019 07:43:01 -0500
Subject: [PATCH v2 13/14] PCI/P2PDMA: No longer require no-mmu for host
 bridge whitelist
In-Reply-To: <20190807055958.GC6627@lst.de>
References: <20190730163545.4915-1-logang@deltatee.com>
 <20190730163545.4915-14-logang@deltatee.com>
 <20190807055958.GC6627@lst.de>
Message-ID: <20190807124259.GX151852@google.com>

On Wed, Aug 07, 2019@07:59:58AM +0200, Christoph Hellwig wrote:
> no-mmu sounds stange, as we use that for linux ports without paging
> hardware.  I think an "io" got lost somewhere..

I had already changed the subject to

  PCI/P2PDMA: Allow IOMMU for host bridge whitelist

but certainly open to better suggestions.
