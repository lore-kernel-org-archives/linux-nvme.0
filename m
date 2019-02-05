From: hch@lst.de (Christoph Hellwig)
Date: Tue, 5 Feb 2019 17:13:47 +0100
Subject: [PATCH] nvme: Enable acceleration feature of A64FX processor
In-Reply-To: <20190205143905.GG22199@localhost.localdomain>
References: <20190201124615.16107-1-indou.takao@jp.fujitsu.com>
 <20190201145414.GA22199@localhost.localdomain>
 <20190205124757.GA28465@esprimo>
 <20190205143905.GG22199@localhost.localdomain>
Message-ID: <20190205161347.GA847@lst.de>

On Tue, Feb 05, 2019@07:39:06AM -0700, Keith Busch wrote:
> > Standard PCIe devices can use Relaxed Ordering (RO) by setting Attr
> > field in the TLP header, however, this mechanism cannot be utilized if
> > the device does not support RO feature. Fujitsu A64FX processor has an
> > alternate feature to enable RO in its Root Port by setting the bit 56 of
> > DMA address. This mechanism enables to utilize RO feature even if the
> > device does not support standard PCIe RO.
> 
> I think you're better of just purchasing devices that support the
> capability per spec rather than with a non-standard work around.

Agreed, this seems like a pretty gross hack.
