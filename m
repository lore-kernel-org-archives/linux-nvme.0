From: hch@lst.de (Christoph Hellwig)
Date: Sun, 28 May 2017 11:14:52 +0200
Subject: [PATCH v2 1/2] net/mlx5: Define interface bits for fencing UMR wqe
In-Reply-To: <1495957991-19223-1-git-send-email-maxg@mellanox.com>
References: <1495957991-19223-1-git-send-email-maxg@mellanox.com>
Message-ID: <20170528091452.GA13857@lst.de>

On Sun, May 28, 2017@10:53:10AM +0300, Max Gurtovoy wrote:
> HW can implement UMR wqe re-transmission in various ways.
> Thus, add HCA cap to distinguish the needed fence for UMR to make
> sure that the wqe wouldn't fail on mkey checks.
> 
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
> Acked-by: Leon Romanovsky <leon at kernel.org>
> ---
> 
> No changes from v1 in this patch (PATCH 1/2).

Still:

Reviewed-by: Christoph Hellwig <hch at lst.de>
