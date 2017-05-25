From: keith.busch@intel.com (Keith Busch)
Date: Thu, 25 May 2017 06:20:57 -0400
Subject: [PATCH 1/3] nvme-pci: consistencly use ctrl->device for logging
In-Reply-To: <20170520131445.16078-1-hch@lst.de>
References: <20170520131445.16078-1-hch@lst.de>
Message-ID: <20170525102056.GA24894@localhost.localdomain>

On Sat, May 20, 2017@03:14:43PM +0200, Christoph Hellwig wrote:
> This is what most of the code already does and gives much more useful
> prefixes than the device embedded in the pci_dev.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
