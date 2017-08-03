From: hare@suse.de (Hannes Reinecke)
Date: Thu, 3 Aug 2017 08:43:28 +0200
Subject: [PATCH v2 10/13] mpt3as:
 Add-Task-management-debug-info-for-NVMe-drives.
In-Reply-To: <1500038560-11231-11-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1500038560-11231-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1500038560-11231-11-git-send-email-suganath-prabu.subramani@broadcom.com>
Message-ID: <a8522797-3bc3-1441-3d22-0683e2446869@suse.de>

On 07/14/2017 03:22 PM, Suganath Prabu S wrote:
> Added debug information for NVMe/PCIe drives in target rest path.
> 
> Signed-off-by: Chaitra P B <chaitra.basappa at broadcom.com>
> Signed-off-by: Suganath Prabu S <suganath-prabu.subramani at broadcom.com>
> ---
>  drivers/scsi/mpt3sas/mpt3sas_scsih.c |   83 ++++++++++++++++++++++++++++-----
>  1 files changed, 70 insertions(+), 13 deletions(-)
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
