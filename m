From: hch@lst.de (Christoph Hellwig)
Date: Fri, 14 Apr 2017 17:58:07 +0200
Subject: [PATCH 3/4] PCI/irq: add pci_request_irq and pci_free_irq helpers
In-Reply-To: <20170414144649.GC29349@bhelgaas-glaptop.roam.corp.google.com>
References: <20170413070643.32165-1-hch@lst.de>
 <20170413070643.32165-4-hch@lst.de>
 <20170414144649.GC29349@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20170414155807.GD22412@lst.de>

On Fri, Apr 14, 2017@09:46:49AM -0500, Bjorn Helgaas wrote:
> Acked-by: Bjorn Helgaas <bhelgaas at google.com>
> 
> Let me know if you'd like me to take this series (given an appropriate
> ack for the genirq parts).

I want to hear from Thomas on the genirq bits.  But if he's fine with
it might be a good idea to take it through your tree.
