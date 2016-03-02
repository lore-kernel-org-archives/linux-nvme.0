From: hch@lst.de (Christoph Hellwig)
Date: Wed, 2 Mar 2016 22:20:01 +0100
Subject: [PATCH 5/5] block: support large requests in blk_rq_map_user_iov
In-Reply-To: <20160302193422.GE27636@localhost.localdomain>
References: <1456938434-20387-1-git-send-email-hch@lst.de>
 <1456938434-20387-6-git-send-email-hch@lst.de>
 <20160302193422.GE27636@localhost.localdomain>
Message-ID: <20160302212001.GC3803@lst.de>

On Wed, Mar 02, 2016@07:34:22PM +0000, Keith Busch wrote:
> This looks good too, though I think patch 2/5 in this series on its
> own should have fixed the transfer issues for NVMe. AFAICT, the only
> reason the iterator couldn't be fully copied into a single bio is if
> blk_add_pc_page already hit a queue limit, and blk_rq_append_bio would
> fail for the same reason.

For requests <= 1MB that's true.  But the firmware dump is using larger
transfers, and unless we can merge enough fragments we're still going
to need multiple bios.
