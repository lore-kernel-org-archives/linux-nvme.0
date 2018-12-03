From: keith.busch@intel.com (Keith Busch)
Date: Mon, 3 Dec 2018 11:23:00 -0700
Subject: [PATCH 04/13] nvme-pci: only allow polling with separate poll
 queues
In-Reply-To: <20181202164628.1116-5-hch@lst.de>
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-5-hch@lst.de>
Message-ID: <20181203182300.GH14775@localhost.localdomain>

On Sun, Dec 02, 2018@08:46:19AM -0800, Christoph Hellwig wrote:
> This will allow us to simplify both the regular NVMe interrupt handler
> and the upcoming aio poll code.  In addition to that the separate
> queues are generally a good idea for performance reasons.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
