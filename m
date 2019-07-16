From: leon@kernel.org (Leon Romanovsky)
Date: Tue, 16 Jul 2019 11:41:26 +0300
Subject: [PATCH for-rc] RDMA/bnxt_re: Honor vlan_id in GID entry comparison
In-Reply-To: <20190716071644.GA21780@kroah.com>
References: <20190715091913.15726-1-selvin.xavier@broadcom.com>
 <20190716071030.GH10130@mtr-leonro.mtl.com>
 <20190716071644.GA21780@kroah.com>
Message-ID: <20190716084126.GJ10130@mtr-leonro.mtl.com>

On Tue, Jul 16, 2019@04:16:44PM +0900, Greg KH wrote:
> On Tue, Jul 16, 2019@10:10:30AM +0300, Leon Romanovsky wrote:
> > On Mon, Jul 15, 2019@05:19:13AM -0400, Selvin Xavier wrote:
> > > GID entry consist of GID, vlan, netdev and smac.
> > > Extend GID duplicate check companions to consider vlan_id as well
> > > to support IPv6 VLAN based link local addresses. Introduce
> > > a new structure (bnxt_qplib_gid_info) to hold gid and vlan_id information.
> > >
> > > The issue is discussed in the following thread
> > > https://www.spinics.net/lists/linux-rdma/msg81594.html
> > >
> > > Fixes: 823b23da7113 ("IB/core: Allow vlan link local address based RoCE GIDs")
> > > Cc: <stable at vger.kernel.org> # v5.2+
> > > Reported-by: Yi Zhang <yi.zhang at redhat.com>
> >
> > > Co-developed-by: Parav Pandit <parav at mellanox.com>
> > > Signed-off-by: Parav Pandit <parav at mellanox.com>
> >
> > I never understood why bad habits are so stinky.
> >
> > Can you please explain us what does it mean Co-developed-by and
> > Signed-off-by of the same person in the same patch?
>
> See Documentation/process/submitting-patches.rst for what that tag
> means.

Read it, it doesn't help me to understand if I should now add
Co-developed-by tag to most of RDMA Mellanox upstreamed patches,
which already care my Signed-off-by, because I'm changing and fixing
them many times.

Maybe I should write for my upstreamed patched something like this?
Co-developed-by: Leon R...
Reviewed-By: Leon R...
Tested-by: Leon R...
Signed-by: Leon R...

Thanks

>
> thanks,
>
> greg k-h
