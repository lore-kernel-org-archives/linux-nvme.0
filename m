From: hch@lst.de (Christoph Hellwig)
Date: Tue, 11 Dec 2018 14:35:36 +0100
Subject: [PATCH 3/5] nvme-fabrics: allow user to set nr_write_queues
 for separate queue maps
In-Reply-To: <20181211104936.25333-4-sagi@grimberg.me>
References: <20181211104936.25333-1-sagi@grimberg.me>
 <20181211104936.25333-4-sagi@grimberg.me>
Message-ID: <20181211133536.GC20614@lst.de>

On Tue, Dec 11, 2018@02:49:33AM -0800, Sagi Grimberg wrote:
> This argument will specify how many I/O queues will be connected
> in create_ctrl in addition to nr_io_queues. With this configuration,
> I/O that carries payload from the host to the target, will use
> the default hctx queue map, and I/O that involves target to host
> transfers will use the read hctx queue map.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
