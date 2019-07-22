From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Mon, 22 Jul 2019 15:07:46 -0300
Subject: [PATCH for-rc] RDMA/bnxt_re: Honor vlan_id in GID entry comparison
In-Reply-To: <20190715091913.15726-1-selvin.xavier@broadcom.com>
References: <20190715091913.15726-1-selvin.xavier@broadcom.com>
Message-ID: <20190722180746.GA9441@ziepe.ca>

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
> Signed-off-by: Selvin Xavier <selvin.xavier at broadcom.com>
> Tested-by: Yi Zhang <yi.zhang at redhat.com>
> Reviewed-By: Leon R...
> Tested-by: Leon R...
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c  |  7 +++++--
>  drivers/infiniband/hw/bnxt_re/qplib_res.c | 13 +++++++++----
>  drivers/infiniband/hw/bnxt_re/qplib_res.h |  2 +-
>  drivers/infiniband/hw/bnxt_re/qplib_sp.c  | 14 +++++++++-----
>  drivers/infiniband/hw/bnxt_re/qplib_sp.h  |  7 ++++++-
>  5 files changed, 30 insertions(+), 13 deletions(-)

Applied to for-rc, thanks

Please also fix that sketchy use of the gid_index

Jason
