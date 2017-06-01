From: dledford@redhat.com (Doug Ledford)
Date: Thu, 01 Jun 2017 18:51:03 -0400
Subject: [PATCH v2 1/2] net/mlx5: Define interface bits for fencing UMR wqe
In-Reply-To: <1495957991-19223-1-git-send-email-maxg@mellanox.com>
References: <1495957991-19223-1-git-send-email-maxg@mellanox.com>
Message-ID: <1496357463.7171.74.camel@redhat.com>

On Sun, 2017-05-28@10:53 +0300, Max Gurtovoy wrote:
> HW can implement UMR wqe re-transmission in various ways.
> Thus, add HCA cap to distinguish the needed fence for UMR to make
> sure that the wqe wouldn't fail on mkey checks.
> 
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
> Acked-by: Leon Romanovsky <leon at kernel.org>

Series, with Christoph's fixup, applied.

-- 
Doug Ledford <dledford at redhat.com>
? ? GPG KeyID: B826A3330E572FDD
? ?
Key fingerprint = AE6B 1BDA 122B 23B4 265B ?1274 B826 A333 0E57 2FDD
