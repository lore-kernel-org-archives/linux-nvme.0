From: hch@lst.de (Christoph Hellwig)
Date: Mon, 11 Jun 2018 08:26:58 +0200
Subject: [PATCH 1/1] nvme-rdma: fix error flow during mapping request data
In-Reply-To: <1528639109-1978-1-git-send-email-maxg@mellanox.com>
References: <1528639109-1978-1-git-send-email-maxg@mellanox.com>
Message-ID: <20180611062658.GA32714@lst.de>

On Sun, Jun 10, 2018@04:58:29PM +0300, Max Gurtovoy wrote:
> After dma mapping the sgl, we map the sgl to nvme sgl descriptor. In case
> of failure during the last mapping we never dma unmap the sgl.
> 
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
