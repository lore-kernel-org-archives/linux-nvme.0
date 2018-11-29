From: keith.busch@intel.com (Keith Busch)
Date: Thu, 29 Nov 2018 13:19:50 -0700
Subject: [PATCH 02/13] nvme-pci: use atomic bitops to mark a queue enabled
In-Reply-To: <20181129191310.9795-3-hch@lst.de>
References: <20181129191310.9795-1-hch@lst.de>
 <20181129191310.9795-3-hch@lst.de>
Message-ID: <20181129201950.GC9377@localhost.localdomain>

On Thu, Nov 29, 2018@08:12:59PM +0100, Christoph Hellwig wrote:
> This gets rid of all the messing with cq_vector and the ->polled field
> by using an atomic bitop to mark the queue enabled or not.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
