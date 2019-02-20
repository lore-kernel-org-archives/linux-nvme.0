From: indou.takao@fujitsu.com (Takao Indoh)
Date: Wed, 20 Feb 2019 18:46:11 +0900
Subject: [PATCH] nvme: Enable acceleration feature of A64FX processor
In-Reply-To: <AT5PR8401MB1169E9738C0A4754D0190F2FAB670@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <20190201124615.16107-1-indou.takao@jp.fujitsu.com>
 <20190201145414.GA22199@localhost.localdomain>
 <20190205124757.GA28465@esprimo>
 <20190205143905.GG22199@localhost.localdomain>
 <AT5PR8401MB1169E9738C0A4754D0190F2FAB670@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
Message-ID: <20190220094610.GB3559@esprimo>

On Thu, Feb 14, 2019@08:44:48PM +0000, Elliott, Robert (Persistent Memory) wrote:
> 
> 
> > -----Original Message-----
> > From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On Behalf Of Keith Busch
> > Sent: Tuesday, February 5, 2019 8:39 AM
> > To: Takao Indoh <indou.takao at fujitsu.com>
> > Cc: Takao Indoh <indou.takao at jp.fujitsu.com>; sagi at grimberg.me; linux-kernel at vger.kernel.org; linux-
> > nvme at lists.infradead.org; axboe at fb.com; hch at lst.de
> > Subject: Re: [PATCH] nvme: Enable acceleration feature of A64FX processor
> > 
> > On Tue, Feb 05, 2019@09:56:05PM +0900, Takao Indoh wrote:
> > > On Fri, Feb 01, 2019@07:54:14AM -0700, Keith Busch wrote:
> > > > On Fri, Feb 01, 2019@09:46:15PM +0900, Takao Indoh wrote:
> > > > > From: Takao Indoh <indou.takao at fujitsu.com>
> > > > >
> > > > > Fujitsu A64FX processor has a feature to accelerate data transfer of
> > > > > internal bus by relaxed ordering. It is enabled when the bit 56 of dma
> > > > > address is set to 1.
> > > >
> > > > Wait, what? RO is a standard PCIe TLP attribute. Why would we need this?
> > >
> > > I should have explained this patch more carefully.
> > >
> > > Standard PCIe devices can use Relaxed Ordering (RO) by setting Attr
> > > field in the TLP header, however, this mechanism cannot be utilized if
> > > the device does not support RO feature. Fujitsu A64FX processor has an
> > > alternate feature to enable RO in its Root Port by setting the bit 56 of
> > > DMA address. This mechanism enables to utilize RO feature even if the
> > > device does not support standard PCIe RO.
> > 
> > I think you're better of just purchasing devices that support the
> > capability per spec rather than with a non-standard work around.
> > 
> 
> The PCIe and NVMe specifications dosn't standardize a way to tell the device
> when to use RO, which leads to system workarounds like this.
> 
> The Enable Relaxed Ordering bit defined by PCIe tells the device when it
> cannot use RO, but doesn't advise when it should or shall use RO.
> 
> For SCSI Express (SOP+PQI), we were going to allow specifying these
> on a per-command basis:
> * TLP attributes (No Snoop, Relaxed Ordering, ID-based Ordering)
> * TLP processing hints (Processing Hints and Steering Tags)
> 
> to be used by the data transfers for the command. In some systems, one
> setting per queue or per device might suffice. Transactions to the
> queues and doorbells require stronger ordering.
> 
> For this workaround:
> * making an extra pass through the SGL to set the address bit is 
> inefficient; it should be done as the SGL is created.

Thanks for your comment, do you mean this should be done in
nvme_pci_setup_sgls()/nvme_pci_setup_prps()?

> * why doesn't it support PRP Lists?

This patch does not support PRP because PRP is used for small data and
we cannot get enough performance improvement by this feature. But I can
support PRP to improve performance of the device which is compliant with
NVMe Spec 1.0 or does not support SGL.

> * how does this interact with an iommu, if there is one? Must the 
> address with bit 56 also be granted permission, or is that
> stripped off before any iommu comparisons?

The latter. A bit 56 is cleared in Root Port before pass it to iommu.

Thanks,
Takao Indoh
