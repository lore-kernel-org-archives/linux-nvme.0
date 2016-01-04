From: keith.busch@intel.com (Keith Busch)
Date: Mon, 4 Jan 2016 15:11:03 +0000
Subject: [PATCH 1/4] nvme: Move nvme_freeze/unfreeze_queues to nvme core
In-Reply-To: <1450967222-10404-2-git-send-email-hch@lst.de>
References: <1450967222-10404-1-git-send-email-hch@lst.de>
 <1450967222-10404-2-git-send-email-hch@lst.de>
Message-ID: <20160104151102.GF31375@localhost.localdomain>

On Thu, Dec 24, 2015@03:26:59PM +0100, Christoph Hellwig wrote:
> From: Sagi Grimberg <sagig at mellanox.com>
> 
> Nothing pci specific about them and We'll need them exported
> in other transports too.
> 
> Signed-off-by: Sagi Grimberg <sagig at mellanox.com>
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Acked-by: Keith Busch <keith.busch at intel.com>
