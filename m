From: hch@lst.de (Christoph Hellwig)
Date: Thu, 8 Aug 2019 09:29:47 +0200
Subject: [PATCH v2 13/14] PCI/P2PDMA: No longer require no-mmu for host
 bridge whitelist
In-Reply-To: <20190807124259.GX151852@google.com>
References: <20190730163545.4915-1-logang@deltatee.com>
 <20190730163545.4915-14-logang@deltatee.com> <20190807055958.GC6627@lst.de>
 <20190807124259.GX151852@google.com>
Message-ID: <20190808072947.GB29852@lst.de>

On Wed, Aug 07, 2019@07:43:01AM -0500, Bjorn Helgaas wrote:
> On Wed, Aug 07, 2019@07:59:58AM +0200, Christoph Hellwig wrote:
> > no-mmu sounds stange, as we use that for linux ports without paging
> > hardware.  I think an "io" got lost somewhere..
> 
> I had already changed the subject to
> 
>   PCI/P2PDMA: Allow IOMMU for host bridge whitelist
> 
> but certainly open to better suggestions.

Maybe:

PCI/P2PDMA: Allow P2P transfers behind IOMMUs

?
