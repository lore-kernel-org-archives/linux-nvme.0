From: hare@suse.de (Hannes Reinecke)
Date: Tue, 24 Oct 2017 09:27:32 +0200
Subject: [PATCH 14/17] nvme: introduce a nvme_ns_ids structure
In-Reply-To: <20171023145126.2471-15-hch@lst.de>
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-15-hch@lst.de>
Message-ID: <2917a1e5-b97d-bc2e-a640-c662a0670b2d@suse.de>

On 10/23/2017 04:51 PM, Christoph Hellwig wrote:
> This allows us to manage the various uniqueue namespace identifiers
> together instead needing various variables and arguments.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Reviewed-by: Keith Busch <keith.busch at intel.com>
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>  drivers/nvme/host/core.c | 69 +++++++++++++++++++++++++++---------------------
>  drivers/nvme/host/nvme.h | 14 +++++++---
>  2 files changed, 49 insertions(+), 34 deletions(-)
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
