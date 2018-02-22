From: keith.busch@intel.com (Keith Busch)
Date: Thu, 22 Feb 2018 08:32:10 -0700
Subject: [PATCH 3/3] nvmet-loop: use blk_rq_payload_bytes for sgl selection
In-Reply-To: <20180222152410.19222-4-hch@lst.de>
References: <20180222152410.19222-1-hch@lst.de>
 <20180222152410.19222-4-hch@lst.de>
Message-ID: <20180222153209.GH7076@localhost.localdomain>

On Thu, Feb 22, 2018@07:24:10AM -0800, Christoph Hellwig wrote:
> blk_rq_bytes does the wrong thing for special payloads like discards and
> might cause the driver to not set up a SGL.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
