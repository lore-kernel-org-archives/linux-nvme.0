From: keith.busch@intel.com (Keith Busch)
Date: Thu, 13 Apr 2017 16:02:55 -0400
Subject: [PATCH 4/4] nvme/pci: switch to pci_request_irq
In-Reply-To: <20170413070643.32165-5-hch@lst.de>
References: <20170413070643.32165-1-hch@lst.de>
 <20170413070643.32165-5-hch@lst.de>
Message-ID: <20170413200255.GB22775@localhost.localdomain>

On Thu, Apr 13, 2017@12:06:43AM -0700, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch at lst.de>

This is great. As an added bonus, more of struct nvme_queue's hot values
are in the same cache line!

Reviewed-by: Keith Busch <keith.busch at intel.com>
