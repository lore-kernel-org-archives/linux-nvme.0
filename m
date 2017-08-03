From: hare@suse.de (Hannes Reinecke)
Date: Thu, 3 Aug 2017 08:44:44 +0200
Subject: [PATCH v2 12/13] mpt3sas: Fix nvme drives checking for tlr.
In-Reply-To: <1500038560-11231-13-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1500038560-11231-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1500038560-11231-13-git-send-email-suganath-prabu.subramani@broadcom.com>
Message-ID: <c5bfb7b9-49bc-a503-9674-591a9bcaa6fa@suse.de>

On 07/14/2017 03:22 PM, Suganath Prabu S wrote:
> Check for NVMe drives before enabling or checking tlr.
> 
> Signed-off-by: Chaitra P B <chaitra.basappa at broadcom.com>
> Signed-off-by: Suganath Prabu S <suganath-prabu.subramani at broadcom.com>
> ---
>  drivers/scsi/mpt3sas/mpt3sas_scsih.c |   22 ++++++++++++++++------
>  1 files changed, 16 insertions(+), 6 deletions(-)
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
