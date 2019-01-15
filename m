From: hch@lst.de (Christoph Hellwig)
Date: Tue, 15 Jan 2019 14:11:40 +0100
Subject: [PATCH] PCI/MSI: preference to returning -ENOSPC from
 pci_alloc_irq_vectors_affinity
In-Reply-To: <20190114232338.GE33971@google.com>
References: <20190103013106.26452-1-ming.lei@redhat.com>
 <20190114232338.GE33971@google.com>
Message-ID: <20190115131140.GB28672@lst.de>

On Mon, Jan 14, 2019@05:23:39PM -0600, Bjorn Helgaas wrote:
> Applied to pci/msi for v5.1, thanks!
> 
> If this is something that should be in v5.0, let me know and include the
> justification, e.g., something we already merged for v5.0 or regression
> info, etc, and a Fixes: line, and I'll move it to for-linus.

I'd be tempted to queues this up for 5.0.  Ming, what is your position?
