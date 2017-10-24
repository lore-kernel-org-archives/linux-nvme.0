From: hare@suse.de (Hannes Reinecke)
Date: Tue, 24 Oct 2017 09:34:11 +0200
Subject: [PATCH 15/17] nvme: track shared namespaces
In-Reply-To: <20171023145126.2471-16-hch@lst.de>
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-16-hch@lst.de>
Message-ID: <bc631b91-a555-5bd7-aa99-61010bcee8b2@suse.de>

On 10/23/2017 04:51 PM, Christoph Hellwig wrote:
> Introduce a new struct nvme_ns_head that holds information about an actual
> namespace, unlike struct nvme_ns, which only holds the per-controller
> namespace information.  For private namespaces there is a 1:1 relation of
> the two, but for shared namespaces this lets us discover all the paths to
> it.  For now only the identifiers are moved to the new structure, but most
> of the information in struct nvme_ns should eventually move over.
> 
> To allow lockless path lookup the list of nvme_ns structures per
> nvme_ns_head is protected by SRCU, which requires freeing the nvme_ns
> structure through call_srcu.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Reviewed-by: Keith Busch <keith.busch at intel.com>
> Reviewed-by: Javier Gonz?lez <javier at cnexlabs.com>
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  drivers/nvme/host/core.c     | 190 +++++++++++++++++++++++++++++++++++++------
>  drivers/nvme/host/lightnvm.c |  14 ++--
>  drivers/nvme/host/nvme.h     |  21 ++++-
>  3 files changed, 190 insertions(+), 35 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
