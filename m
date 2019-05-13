From: hare@suse.de (Hannes Reinecke)
Date: Mon, 13 May 2019 08:36:55 +0200
Subject: [PATCH 2/2] nvme: validate cntlid during controller initialisation
In-Reply-To: <20190513062510.756-3-hch@lst.de>
References: <20190513062510.756-1-hch@lst.de> <20190513062510.756-3-hch@lst.de>
Message-ID: <4890b5c7-6a6d-95eb-f0d8-f29c978fdb81@suse.de>

On 5/13/19 8:25 AM, Christoph Hellwig wrote:
> The CNTLID value is required to be unique, and we do rely on this
> for correct operation. So reject any controller for which a non-unique
> CNTLID has been detected.
> 
> Based on a patch from Hannes Reinecke.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/host/core.c | 41 +++++++++++++++++++++++-----------------
>   1 file changed, 24 insertions(+), 17 deletions(-)
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
