From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 24 Nov 2016 23:48:07 -0800
Subject: [PATCH v3 1/2] nvmet-rdma: align to generic ib_event logging
 helper
In-Reply-To: <9e7a1e2a-aa02-e6b1-4821-1b47c795f743@mellanox.com>
References: <1479893928-32445-1-git-send-email-maxg@mellanox.com>
 <1479893928-32445-2-git-send-email-maxg@mellanox.com>
 <1479925553.5486.4.camel@linux.intel.com>
 <9e7a1e2a-aa02-e6b1-4821-1b47c795f743@mellanox.com>
Message-ID: <20161125074807.GC1569@infradead.org>

On Thu, Nov 24, 2016@01:19:11PM +0200, Max Gurtovoy wrote:
> in that case you'll get something like:
> 
> "nvmet_rdma: received unrecognized IB QP event: last WQE reached (16)"
> 
> instead of
> 
> "nvmet_rdma: received IB QP event: last WQE reached (16)"
> 
> Sagi/Christoph, what do you think ?

I don't care, it's only a debug printk anyway.
