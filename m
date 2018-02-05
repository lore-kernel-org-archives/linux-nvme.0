From: dledford@redhat.com (Doug Ledford)
Date: Mon, 05 Feb 2018 10:57:20 -0500
Subject: [PATCH] mlx5: fix mlx5_get_vector_affinity to start from
 completion vector 0
In-Reply-To: <20180205142452.7630-1-sagi@grimberg.me>
References: <20180205142452.7630-1-sagi@grimberg.me>
Message-ID: <1517846240.3936.69.camel@redhat.com>

On Mon, 2018-02-05@16:24 +0200, Sagi Grimberg wrote:
> The consumers of this routine expects the affinity map of of vector
> index relative to the first completion vector. The upper layers are
> not aware of internal/private completion vectors that mlx5 allocates
> for its own usage.
> 
> Hence, return the affinity map of vector index relative to the first
> completion vector.
> 
> Fixes: 05e0cc84e00c ("net/mlx5: Fix get vector affinity helper function")
> Reported-by: Logan Gunthorpe <logang at deltatee.com>
> Tested-by: Max Gurtovoy <maxg at mellanox.com>
> Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
> Cc: <stable at vger.kernel.org> # v4.15
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Thanks, applied.

-- 
Doug Ledford <dledford at redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180205/45771bfc/attachment.sig>
