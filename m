From: hch@lst.de (Christoph Hellwig)
Date: Thu, 25 Jul 2019 08:02:12 +0200
Subject: [PATCH 07/14] PCI/P2PDMA: Add the provider's pci_dev to the
 dev_pgmap struct
In-Reply-To: <818e465d-3e57-b425-2431-e330a43fe7bd@deltatee.com>
References: <20190722230859.5436-1-logang@deltatee.com>
 <20190722230859.5436-8-logang@deltatee.com> <20190724063229.GA1804@lst.de>
 <818e465d-3e57-b425-2431-e330a43fe7bd@deltatee.com>
Message-ID: <20190725060212.GA24875@lst.de>

On Wed, Jul 24, 2019@09:50:03AM -0600, Logan Gunthorpe wrote:
> OK, I was going to do that, but you just removed the p2p specific page
> map. ;)

Only because it was empty at that time..
