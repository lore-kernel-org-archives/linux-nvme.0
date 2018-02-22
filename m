From: keith.busch@intel.com (Keith Busch)
Date: Thu, 22 Feb 2018 08:31:52 -0700
Subject: [PATCH 2/3] nvme-rdma: use blk_rq_payload_bytes instead of
 blk_rq_bytes
In-Reply-To: <20180222152410.19222-3-hch@lst.de>
References: <20180222152410.19222-1-hch@lst.de>
 <20180222152410.19222-3-hch@lst.de>
Message-ID: <20180222153152.GG7076@localhost.localdomain>

On Thu, Feb 22, 2018@07:24:09AM -0800, Christoph Hellwig wrote:
> blk_rq_bytes does the wrong thing for special payloads like discards and
> might cause the driver to not set up a SGL.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
