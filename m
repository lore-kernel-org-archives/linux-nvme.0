From: kbusch@kernel.org (Keith Busch)
Date: Fri, 17 May 2019 08:41:27 -0600
Subject: [PATCH v2 4/4] nvme: release namespace SRCU protection before
 performing controller ioctls
In-Reply-To: <20190517094736.14504-4-hch@lst.de>
References: <20190517094736.14504-1-hch@lst.de>
 <20190517094736.14504-4-hch@lst.de>
Message-ID: <20190517144127.GA24925@localhost.localdomain>

On Fri, May 17, 2019@11:47:36AM +0200, Christoph Hellwig wrote:
> Holding the SRCU critical section protecting the namespace list can
> cause deadlocks when using the per-namespace admin passthrough ioctl to
> delete as namespace.  Release it earlier when performing per-controller
> ioctls to avoid that.
> 
> Reported-by: Kenneth Heitke <kenneth.heitke at intel.com>
> Signed-off-by: Christoph Hellwig <hch at lst.de>

This looks fine.

Reviewed-by: Keith Busch <keith.busch at intel.com>
