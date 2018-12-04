From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 3 Dec 2018 17:08:44 -0800
Subject: [PATCH 08/13] nvme-pci: remove the CQ lock for interrupt driven
 queues
In-Reply-To: <20181202164628.1116-9-hch@lst.de>
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-9-hch@lst.de>
Message-ID: <9c0d0bdf-cf47-ae54-8277-73ac608d99cd@grimberg.me>


> Now that we can't poll regular, interrupt driven I/O queues there
> is almost nothing that can race with an interrupt.  The only
> possible other contexts polling a CQ are the error handler and
> queue shutdown, and both are so far off in the slow path that
> we can simply use the big hammer of disabling interrupts.
> 
> With that we can stop taking the cq_lock for normal queues.

Nice,

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
