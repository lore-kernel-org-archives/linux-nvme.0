From: hch@lst.de (Christoph Hellwig)
Date: Mon, 1 Aug 2016 13:07:44 +0200
Subject: [PATCH 1/2] nvme-rdma: Don't leak uninitialized memory in
 connect request private data
In-Reply-To: <1469950060-18098-1-git-send-email-roland@kernel.org>
References: <1469950060-18098-1-git-send-email-roland@kernel.org>
Message-ID: <20160801110744.GG16141@lst.de>

On Sun, Jul 31, 2016@12:27:39AM -0700, Roland Dreier wrote:
> From: Roland Dreier <roland at purestorage.com>
> 
> Zero out the full nvme_rdma_cm_req structure before sending it.
> Otherwise we end up leaking kernel memory in the reserved field, which
> might break forward compatibility in the future.
> 
> Signed-off-by: Roland Dreier <roland at purestorage.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
