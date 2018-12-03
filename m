From: keith.busch@intel.com (Keith Busch)
Date: Mon, 3 Dec 2018 11:15:21 -0700
Subject: [PATCH 07/13] nvme-pci: don't poll from irq context when
 deleting queues
In-Reply-To: <20181202164628.1116-8-hch@lst.de>
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-8-hch@lst.de>
Message-ID: <20181203181520.GF14775@localhost.localdomain>

On Sun, Dec 02, 2018@08:46:22AM -0800, Christoph Hellwig wrote:
> This is the last place outside of nvme_irq that handles CQEs from
> interrupt context, and thus is in the way of removing the cq_lock for
> normal queues, and avoiding lockdep warnings on the poll queues, for
> which we already take it without IRQ disabling.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
