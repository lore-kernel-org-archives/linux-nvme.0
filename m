From: hare@suse.de (Hannes Reinecke)
Date: Thu, 3 Aug 2017 08:35:11 +0200
Subject: [PATCH v2 05/13] mpt3sas: API 's to support NVMe drive addition
 to SML
In-Reply-To: <1500038560-11231-6-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1500038560-11231-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1500038560-11231-6-git-send-email-suganath-prabu.subramani@broadcom.com>
Message-ID: <55bb3055-9216-7b9d-32c5-25d29046e11d@suse.de>

On 07/14/2017 03:22 PM, Suganath Prabu S wrote:
> Below Functions are added in various paths to support NVMe
> drive addition.
> 
> _scsih_pcie_add_device
> _scsih_pcie_device_add
> _scsih_pcie_device_init_add
> _scsih_check_pcie_access_status
> _scsih_pcie_check_device
> 
> mpt3sas_get_pdev_by_handle
> 
> mpt3sas_config_get_pcie_device_pg0
> mpt3sas_config_get_pcie_device_pg2
> 
> Signed-off-by: Chaitra P B <chaitra.basappa at broadcom.com>
> Signed-off-by: Suganath Prabu S <suganath-prabu.subramani at broadcom.com>
> ---
>  drivers/scsi/mpt3sas/mpt3sas_base.h   |   10 +
>  drivers/scsi/mpt3sas/mpt3sas_config.c |  100 +++++++
>  drivers/scsi/mpt3sas/mpt3sas_scsih.c  |  473 ++++++++++++++++++++++++++++++++-
>  3 files changed, 575 insertions(+), 8 deletions(-)
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
