From: hch@lst.de (Christoph Hellwig)
Date: Thu, 1 Jun 2017 12:46:01 +0200
Subject: [PATCH] PCI: ensure the PCI device is locked over
 ->reset_notify calls
In-Reply-To: <20170531165131.GA4496@bhelgaas-glaptop.roam.corp.google.com>
References: <20170523054202.7985-1-hch@lst.de>
 <20170523054202.7985-2-hch@lst.de>
 <20170530222844.GE14896@bhelgaas-glaptop.roam.corp.google.com>
 <20170531045848.GA4001@lst.de>
 <20170531165131.GA4496@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20170601104601.GA22620@lst.de>

On Wed, May 31, 2017@11:51:31AM -0500, Bjorn Helgaas wrote:
> Do you have any thoughts on whether the paths I mentioned above are
> also susceptible?

At least in theory ever method call that doesn't have the device
locked is susceptible, so yes.
