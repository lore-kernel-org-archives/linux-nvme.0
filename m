From: keith.busch@intel.com (Keith Busch)
Date: Thu, 29 Nov 2018 13:37:41 -0700
Subject: [PATCH 06/13] nvme-pci: refactor nvme_disable_io_queues
In-Reply-To: <20181129191310.9795-7-hch@lst.de>
References: <20181129191310.9795-1-hch@lst.de>
 <20181129191310.9795-7-hch@lst.de>
Message-ID: <20181129203740.GF9377@localhost.localdomain>

On Thu, Nov 29, 2018@08:13:03PM +0100, Christoph Hellwig wrote:
> Pass the opcode for the delete SQ/CQ command as an argument instead of
> the somewhat confusing pass loop.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
