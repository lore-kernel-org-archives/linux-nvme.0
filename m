From: jeffrey.t.kirsher@intel.com (Jeff Kirsher)
Date: Wed, 08 Jun 2016 16:04:46 -0700
Subject: [PATCH v3 0/6] Introduce pci_(request|release)_(mem|io)_regions
In-Reply-To: <20160608072854.ivcfvtlgxab2xkmp@c203.arch.suse.de>
References: <cover.1465200424.git.jthumshirn@suse.de>
 <20160608072854.ivcfvtlgxab2xkmp@c203.arch.suse.de>
Message-ID: <1465427086.2736.93.camel@intel.com>

On Wed, 2016-06-08@09:28 +0200, Johannes Thumshirn wrote:
> On Tue, Jun 07, 2016@09:44:00AM +0200, Johannes Thumshirn wrote:
> > The first patch in this series introduces the following 4 helper
> functions to
> > the PCI core:
> >?
> > * pci_request_mem_regions()
> > * pci_request_io_regions()
> > * pci_release_mem_regions()
> > * pci_release_io_regions()
> >?
> > which encapsulate the request and release of a PCI device's memory or
> I/O
> > bars.
> >?
> > The subsequent patches convert the drivers, which use the
> > pci_request_selected_regions(pdev,?
> >???????pci_select_bars(pdev, IORESOURCE_MEM), name);?
> > and similar pattern to use the new interface.
> >?
> > This was suggested by Christoph Hellwig in
> > http://lists.infradead.org/pipermail/linux-nvme/2016-May/004570.html?an
> d
> > tested on kernel v4.6 with NVMe.
> >?
> 
> Btw, as I've seen already Jeff applying the Intel Ethernet patch to his
> tree, I think this should go via the PCI tree as the build dependency is
> the PCI patch.

Bjorn should pick up the entire series, I just applied the Intel patch (and
dependent patches) so we could touch test it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20160608/37d3a717/attachment-0001.sig>
