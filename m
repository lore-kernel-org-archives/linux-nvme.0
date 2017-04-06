From: leonro@mellanox.com (Leon Romanovsky)
Date: Thu, 6 Apr 2017 17:27:01 +0300
Subject: [PATCH v2 2/6] mlx5: move affinity hints assignments to generic
 code
In-Reply-To: <1491474998-16423-3-git-send-email-sagi@grimberg.me>
References: <1491474998-16423-1-git-send-email-sagi@grimberg.me>
 <1491474998-16423-3-git-send-email-sagi@grimberg.me>
Message-ID: <20170406142701.GL2269@mtr-leonro.local>

On Thu, Apr 06, 2017@01:36:34PM +0300, Sagi Grimberg wrote:
> generic api takes care of spreading affinity similar to
> what mlx5 open coded (and even handles better asymmetric
> configurations). Ask the generic API to spread affinity
> for us, and feed him pre_vectors that do not participate
> in affinity settings (which is an improvement to what we
> had before).
>
> The affinity assignments should match what mlx5 tried to
> do earlier but now we do not set affinity to async, cmd
> and pages dedicated vectors.
>
> Also, remove mlx5e_get_cpu routine as we have generic helpers
> to get cpumask and node given a irq vector, so use them
> directly.
>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---

Thanks,
Acked-by: Leon Romanovsky <leonro at mellanox.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170406/08eac1b4/attachment.sig>
