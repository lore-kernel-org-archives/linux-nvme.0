From: keith.busch@intel.com (Keith Busch)
Date: Wed, 2 Mar 2016 19:34:22 +0000
Subject: [PATCH 5/5] block: support large requests in blk_rq_map_user_iov
In-Reply-To: <1456938434-20387-6-git-send-email-hch@lst.de>
References: <1456938434-20387-1-git-send-email-hch@lst.de>
 <1456938434-20387-6-git-send-email-hch@lst.de>
Message-ID: <20160302193422.GE27636@localhost.localdomain>

On Wed, Mar 02, 2016@06:07:14PM +0100, Christoph Hellwig wrote:
> This patch adds support for larger requests in blk_rq_map_user_iov by
> allowing it to build multiple bios for a request.  This functionality
> used to exist for the non-vectored blk_rq_map_user in the past, and
> this patch reuses the existing functionality for it on the unmap side,
> which stuck around.  Thanks to the iov_iter API supporting multiple
> bios is fairly trivial, as we can just iterate the iov until we've
> consumed the whole iov_iter.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Reported-by: Jeff Lien <Jeff.Lien at hgst.com>
> Tested-by: Jeff Lien <Jeff.Lien at hgst.com>

This looks good too, though I think patch 2/5 in this series on its
own should have fixed the transfer issues for NVMe. AFAICT, the only
reason the iterator couldn't be fully copied into a single bio is if
blk_add_pc_page already hit a queue limit, and blk_rq_append_bio would
fail for the same reason.

Reviewed-by: Keith Busch <keith.busch at intel.com>
