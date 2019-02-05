From: indou.takao@fujitsu.com (Takao Indoh)
Date: Tue, 5 Feb 2019 21:56:57 +0900
Subject: [PATCH] nvme: Enable acceleration feature of A64FX processor
In-Reply-To: <20190201155120.GA5180@lst.de>
References: <20190201124615.16107-1-indou.takao@jp.fujitsu.com>
 <20190201155120.GA5180@lst.de>
Message-ID: <20190205125657.GA1663@esprimo>

On Fri, Feb 01, 2019@04:51:20PM +0100, Christoph Hellwig wrote:
> On Fri, Feb 01, 2019@09:46:15PM +0900, Takao Indoh wrote:
> > From: Takao Indoh <indou.takao at fujitsu.com>
> > 
> > Fujitsu A64FX processor has a feature to accelerate data transfer of
> > internal bus by relaxed ordering. It is enabled when the bit 56 of dma
> > address is set to 1.
> > 
> > This patch introduces this acceleration feature to the NVMe driver to
> > enhance NVMe device performance.
> 
> This has absolutely no business in a PCIe driver, sorry.
> 

At first let me explain detail of this feature. I wrote the same
explanation in the reply to Keith, but I write here again just in case.

Standard PCIe devices can use Relaxed Ordering (RO) by setting Attr
field in the TLP header, however, this mechanism cannot be utilized if
the device does not support RO feature. Fujitsu A64FX processor has an
alternate feature to enable RO in its Root Port by setting the bit 56 of
DMA address. This mechanism enables to utilize RO feature even if the
device does not support standard PCIe RO.

The data packet with its DMA address bit 56 is set, is transferred from
the device to the PCI root port with Strong Ordering (SO), and then it
is transferred with RO to the host memory.

This patch adds new code into NVMe driver to set bit 56 of DMA address
to utilize this feature. The reason why I do this in NVMe driver is that
here is an only place where we can traverses a sgl list to update the
DMA addresses. We can transfer data buffers with RO, but we cannot use
RO as for writes to the admin completion queue and the I/O completion
queue from the NVMe controller to the host. These writes need to be done
with SO to avoid data corruption. This patch scans data buffers queued
in the sgl list and update their DMA addresses to send data buffers with
RO.

Thanks,
Takao Indoh
