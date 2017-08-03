From: hare@suse.de (Hannes Reinecke)
Date: Thu, 3 Aug 2017 08:36:23 +0200
Subject: [PATCH v2 06/13] mpt3sas: API's to remove nvme drive from sml
In-Reply-To: <1500038560-11231-7-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1500038560-11231-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1500038560-11231-7-git-send-email-suganath-prabu.subramani@broadcom.com>
Message-ID: <d037976e-5e7d-aecd-772c-1d1244406089@suse.de>

On 07/14/2017 03:22 PM, Suganath Prabu S wrote:
> Below API's are included in nvme drive remove path.
> _scsih_pcie_device_remove_by_handle
> _scsih_pcie_device_remove_from_sml
> 
> Signed-off-by: Chaitra P B <chaitra.basappa at broadcom.com>
> Signed-off-by: Suganath Prabu S <suganath-prabu.subramani at broadcom.com>
> ---
>  drivers/scsi/mpt3sas/mpt3sas_scsih.c |  148 +++++++++++++++++++++++++++++++++-
>  1 files changed, 145 insertions(+), 3 deletions(-)
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
