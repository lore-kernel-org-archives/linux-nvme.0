From: keith.busch@intel.com (Keith Busch)
Date: Tue, 5 Feb 2019 07:39:06 -0700
Subject: [PATCH] nvme: Enable acceleration feature of A64FX processor
In-Reply-To: <20190205124757.GA28465@esprimo>
References: <20190201124615.16107-1-indou.takao@jp.fujitsu.com>
 <20190201145414.GA22199@localhost.localdomain>
 <20190205124757.GA28465@esprimo>
Message-ID: <20190205143905.GG22199@localhost.localdomain>

On Tue, Feb 05, 2019@09:56:05PM +0900, Takao Indoh wrote:
> On Fri, Feb 01, 2019@07:54:14AM -0700, Keith Busch wrote:
> > On Fri, Feb 01, 2019@09:46:15PM +0900, Takao Indoh wrote:
> > > From: Takao Indoh <indou.takao at fujitsu.com>
> > > 
> > > Fujitsu A64FX processor has a feature to accelerate data transfer of
> > > internal bus by relaxed ordering. It is enabled when the bit 56 of dma
> > > address is set to 1.
> > 
> > Wait, what? RO is a standard PCIe TLP attribute. Why would we need this?
> 
> I should have explained this patch more carefully.
> 
> Standard PCIe devices can use Relaxed Ordering (RO) by setting Attr
> field in the TLP header, however, this mechanism cannot be utilized if
> the device does not support RO feature. Fujitsu A64FX processor has an
> alternate feature to enable RO in its Root Port by setting the bit 56 of
> DMA address. This mechanism enables to utilize RO feature even if the
> device does not support standard PCIe RO.

I think you're better of just purchasing devices that support the
capability per spec rather than with a non-standard work around.
