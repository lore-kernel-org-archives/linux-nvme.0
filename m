From: hare@suse.de (Hannes Reinecke)
Date: Sat, 29 Sep 2018 14:09:15 +0200
Subject: [PATCH] nvme: take node locality into account when selecting a
 path
In-Reply-To: <20180927230557.29444-1-hch@lst.de>
References: <20180927230557.29444-1-hch@lst.de>
Message-ID: <0bd80d4b-3ae8-a9e2-c19b-5531fbfac8b3@suse.de>

On 9/28/18 1:05 AM, Christoph Hellwig wrote:
> Make current_path an array with an entry for every possible node, and
> cache the best path on a per-node basis.  Take the node distance into
> account when selecting it.  This is primarily useful for dual-ported PCIe
> devices which are connected to PCIe root ports on different sockets.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/host/core.c      |  7 ++++-
>  drivers/nvme/host/multipath.c | 50 +++++++++++++++++++++++++++--------
>  drivers/nvme/host/nvme.h      | 25 +++++++-----------
>  3 files changed, 54 insertions(+), 28 deletions(-)
> 
Actually I would love to have some statistic or debug info showing the
NUMA locality mapping somewhere. Otherwise the admin might have a hard
time figuring out what's going on here, plus debugging any I/O routing
issues will be tricky.

But I guess we can do it with a later patch.

So:

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
