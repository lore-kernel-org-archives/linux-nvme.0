From: hare@suse.de (Hannes Reinecke)
Date: Mon, 13 May 2019 08:36:33 +0200
Subject: [PATCH 1/2] nvme: change locking for the per-subsystem controller
 list
In-Reply-To: <20190513062510.756-2-hch@lst.de>
References: <20190513062510.756-1-hch@lst.de> <20190513062510.756-2-hch@lst.de>
Message-ID: <af4e245b-d1a8-d55a-0090-07981145c690@suse.de>

On 5/13/19 8:25 AM, Christoph Hellwig wrote:
> Life becomes a lot simpler if we just use the global
> nvme_subsystems_lock to protect this list.  Given that it is only
> accessed during controller probing and removal that isn't a scalability
> problem either.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/host/core.c | 32 ++++++++++++++------------------
>   1 file changed, 14 insertions(+), 18 deletions(-)
> 

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes

-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
