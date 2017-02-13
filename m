From: hare@suse.de (Hannes Reinecke)
Date: Mon, 13 Feb 2017 10:03:15 +0100
Subject: [PATCH v3 10/16] lpfc: NVME Target: Base modifications
In-Reply-To: <58a0d922./Gplb8MulYx0CHwV%jsmart2021@gmail.com>
References: <58a0d922./Gplb8MulYx0CHwV%jsmart2021@gmail.com>
Message-ID: <f16536c8-2824-d072-4400-b6c4e1d6ce1a@suse.de>

On 02/12/2017 10:52 PM, James Smart wrote:
> 
> NVME Target: Base modifications
> 
> This set of patches adds the base modifications for NVME target support
> 
> The base modifications consist of:
> - Additional module parameters or configuration tuning
> - Enablement of configuration mode for NVME target. Ties into the
>   queueing model put into place by the initiator basemods patches.
> - Target-specific buffer pools, dma pools, sgl pools
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
