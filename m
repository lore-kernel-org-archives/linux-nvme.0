From: hch@lst.de (Christoph Hellwig)
Date: Fri, 4 Jan 2019 19:19:38 +0100
Subject: [PATCHv2 4/4] nvme-pci: Use PCI to handle IRQ reduce and retry
In-Reply-To: <20190103225033.11249-5-keith.busch@intel.com>
References: <20190103225033.11249-1-keith.busch@intel.com>
 <20190103225033.11249-5-keith.busch@intel.com>
Message-ID: <20190104181938.GB25730@lst.de>

I can't say I am a huge fan of the complex callback.  If we just made
the number of read vs write queues a factor instead of invidual
scalar numbers we could just handle this in the irq code without
the callback, and the concept might actually be understandable by
mere humans..
