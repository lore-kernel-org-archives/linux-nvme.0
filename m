From: kbusch@kernel.org (Keith Busch)
Date: Tue, 12 Mar 2019 09:59:56 -0600
Subject: [PATCH 3/3] nvme: add proper write zeroes setup for the
 multipath device
In-Reply-To: <20190312152453.9550-4-hch@lst.de>
References: <20190312152453.9550-1-hch@lst.de>
 <20190312152453.9550-4-hch@lst.de>
Message-ID: <20190312155955.GC12696@localhost.localdomain>

On Tue, Mar 12, 2019@04:24:53PM +0100, Christoph Hellwig wrote:
> Add a gendisk argument to nvme_config_write_zeroes so that the call to
> nvme_update_disk_info for the multipath device node updates the
> proper request_queue.

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
