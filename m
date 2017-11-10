From: hare@suse.de (Hannes Reinecke)
Date: Fri, 10 Nov 2017 09:21:20 +0100
Subject: [PATCH 5/7] nvme: also expose the namespace identification sysfs
 files for mpath nodes
In-Reply-To: <20171109174450.17142-6-hch@lst.de>
References: <20171109174450.17142-1-hch@lst.de>
 <20171109174450.17142-6-hch@lst.de>
Message-ID: <3d24b1ad-5fee-ee4b-8518-a040c1b39006@suse.de>

On 11/09/2017 06:44 PM, Christoph Hellwig wrote:
> We do this by adding a helper that returns the ns_head for a device that
> can belong to either the per-controller or per-subsystem block device
> nodes, and otherwise reuse all the existing code.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Reviewed-by: Keith Busch <keith.busch at intel.com>
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  drivers/nvme/host/core.c      | 57 +++++++++++++++++++++++--------------------
>  drivers/nvme/host/multipath.c |  6 +++++
>  drivers/nvme/host/nvme.h      |  1 +
>  3 files changed, 38 insertions(+), 26 deletions(-)
> 
In principle, yes, but I would like to have some more info (like
subsysnqn, and maybe 'model' etc) in the subsys sysfs entry, too.
But this can be handled in a later patch, so:

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
