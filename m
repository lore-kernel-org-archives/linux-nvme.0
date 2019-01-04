From: keith.busch@intel.com (Keith Busch)
Date: Fri, 4 Jan 2019 11:33:40 -0700
Subject: [PATCHv2 4/4] nvme-pci: Use PCI to handle IRQ reduce and retry
In-Reply-To: <20190104181938.GB25730@lst.de>
References: <20190103225033.11249-1-keith.busch@intel.com>
 <20190103225033.11249-5-keith.busch@intel.com>
 <20190104181938.GB25730@lst.de>
Message-ID: <20190104183339.GA12508@localhost.localdomain>

On Fri, Jan 04, 2019@07:19:38PM +0100, Christoph Hellwig wrote:
> I can't say I am a huge fan of the complex callback.  If we just made
> the number of read vs write queues a factor instead of invidual
> scalar numbers we could just handle this in the irq code without
> the callback, and the concept might actually be understandable by
> mere humans..

Okay, we could express this as a ratio. I'll explore that path a bit
more.
