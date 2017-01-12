From: leon@kernel.org (Leon Romanovsky)
Date: Thu, 12 Jan 2017 15:09:30 +0200
Subject: [PATCH 9/9] treewide: Inline ib_dma_map_*() functions
In-Reply-To: <20170111005648.14988-10-bart.vanassche@sandisk.com>
References: <20170111005648.14988-1-bart.vanassche@sandisk.com>
 <20170111005648.14988-10-bart.vanassche@sandisk.com>
Message-ID: <20170112130930.GH20392@mtr-leonro.local>

On Tue, Jan 10, 2017@04:56:48PM -0800, Bart Van Assche wrote:
> Almost all changes in this patch except the removal of local variables
> that became superfluous and the actual removal of the ib_dma_map_*()
> functions have been generated as follows:
>
> git grep -lE 'ib_(sg_|)dma_' |
>   xargs -d\\n \
>     sed -i -e 's/\([^[:alnum:]_]\)ib_dma_\([^(]*\)(\&\([^,]\+\),/\1dma_\2(\3.dma_device,/g' \
>            -e 's/\([^[:alnum:]_]\)ib_dma_\([^(]*\)(\([^,]\+\),/\1dma_\2(\3->dma_device,/g' \
> 	   -e 's/ib_sg_dma_\(len\|address\)(\([^,]\+\), /sg_dma_\1(/g'
>
> Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> Cc: Andreas Dilger <andreas.dilger at intel.com>
> Cc: Anna Schumaker <anna.schumaker at netapp.com>
> Cc: David S. Miller <davem at davemloft.net>
> Cc: Eric Van Hensbergen <ericvh at gmail.com>
> Cc: James Simmons <jsimmons at infradead.org>
> Cc: Latchesar Ionkov <lucho at ionkov.net>
> Cc: Oleg Drokin <oleg.drokin at intel.com>
> Cc: Ron Minnich <rminnich at sandia.gov>
> Cc: Trond Myklebust <trond.myklebust at primarydata.com>
> Cc: devel at driverdev.osuosl.org
> Cc: linux-nfs at vger.kernel.org
> Cc: linux-nvme at lists.infradead.org
> Cc: linux-rdma at vger.kernel.org
> Cc: lustre-devel at lists.lustre.org
> Cc: netdev at vger.kernel.org
> Cc: rds-devel at oss.oracle.com
> Cc: target-devel at vger.kernel.org
> Cc: v9fs-developer at lists.sourceforge.net
> ---
>  drivers/infiniband/core/mad.c                      |  28 +--
>  drivers/infiniband/core/rw.c                       |  30 ++-
>  drivers/infiniband/core/umem.c                     |   4 +-
>  drivers/infiniband/core/umem_odp.c                 |   6 +-
>  drivers/infiniband/hw/mlx4/cq.c                    |   2 +-
>  drivers/infiniband/hw/mlx4/mad.c                   |  28 +--
>  drivers/infiniband/hw/mlx4/mr.c                    |   4 +-
>  drivers/infiniband/hw/mlx4/qp.c                    |  10 +-
>  drivers/infiniband/hw/mlx5/mr.c                    |   4 +-

For mlx5 and mlx4 parts.
Acked-by: Leon Romanovsky <leonro at mellanox.com>

Thanks
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170112/7c2fc5e1/attachment.sig>
