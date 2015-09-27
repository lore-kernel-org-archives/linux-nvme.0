From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 27 Sep 2015 12:14:51 -0700
Subject: [PATCH 2/4] nvme: split pci specifics out of nvme_dev and
 nvme_queue structures
In-Reply-To: <56079883.2070904@dev.mellanox.co.il>
References: <1443318691.4357.36.camel@linux.intel.com>
 <56079883.2070904@dev.mellanox.co.il>
Message-ID: <20150927191451.GA14711@infradead.org>

On Sun, Sep 27, 2015@10:19:31AM +0300, Sagi Grimberg wrote:
> Are serial, model, firmware_rev applicable for
> non-pcie fabrics?

I would expect anything reported from IDENTIFY CTRL to be architectural.

Note that someone in their infinite wisdom even added a PCI Vendor and
Device ID to it, which will create some fun for non-PCI implementations.
