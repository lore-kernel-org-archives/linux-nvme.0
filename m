From: leon@kernel.org (Leon Romanovsky)
Date: Tue, 16 Jul 2019 10:10:30 +0300
Subject: [PATCH for-rc] RDMA/bnxt_re: Honor vlan_id in GID entry comparison
In-Reply-To: <20190715091913.15726-1-selvin.xavier@broadcom.com>
References: <20190715091913.15726-1-selvin.xavier@broadcom.com>
Message-ID: <20190716071030.GH10130@mtr-leonro.mtl.com>

On Mon, Jul 15, 2019@05:19:13AM -0400, Selvin Xavier wrote:
> GID entry consist of GID, vlan, netdev and smac.
> Extend GID duplicate check companions to consider vlan_id as well
> to support IPv6 VLAN based link local addresses. Introduce
> a new structure (bnxt_qplib_gid_info) to hold gid and vlan_id information.
>
> The issue is discussed in the following thread
> https://www.spinics.net/lists/linux-rdma/msg81594.html
>
> Fixes: 823b23da7113 ("IB/core: Allow vlan link local address based RoCE GIDs")
> Cc: <stable at vger.kernel.org> # v5.2+
> Reported-by: Yi Zhang <yi.zhang at redhat.com>

> Co-developed-by: Parav Pandit <parav at mellanox.com>
> Signed-off-by: Parav Pandit <parav at mellanox.com>

I never understood why bad habits are so stinky.

Can you please explain us what does it mean Co-developed-by and
Signed-off-by of the same person in the same patch?

> Signed-off-by: Selvin Xavier <selvin.xavier at broadcom.com>
> ---

Thanks
