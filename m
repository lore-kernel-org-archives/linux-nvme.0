From: hare@suse.de (Hannes Reinecke)
Date: Thu, 3 Aug 2017 08:27:13 +0200
Subject: [PATCH v2 02/13] mpt3sas: Add nvme device support in slave alloc, 
 target alloc and probe
In-Reply-To: <1500038560-11231-3-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1500038560-11231-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1500038560-11231-3-git-send-email-suganath-prabu.subramani@broadcom.com>
Message-ID: <5fb13656-0f40-fdc4-8612-ec1bf04cf696@suse.de>

On 07/14/2017 03:22 PM, Suganath Prabu S wrote:
> 1) Added support for probing pcie device and adding NVMe drives to
> SML and driver's internal list pcie_device_list.
> 
> 2) Added support for determing NVMe as boot device.
> 
> 3) Added nvme device support for call back functions scan_finished
> target_alloc,slave_alloc,target destroy and slave destroy.
> 
>  a) During scan, pcie devices are probed and added to SML to drivers
> internal list.
> 
>  b) target_alloc & slave alloc API's allocates resources for
> (MPT3SAS_TARGET & MPT3SAS_DEVICE) private datas and holds
> information like handle, target_id etc.
> 
>  c) slave_destroy & target_destroy are called when driver unregisters
> or removes device. Also frees allocated resources and info.
> 
> Signed-off-by: Chaitra P B <chaitra.basappa at broadcom.com>
> Signed-off-by: Suganath Prabu S <suganath-prabu.subramani at broadcom.com>
> ---
>  drivers/scsi/mpt3sas/mpt3sas_base.h  |  110 ++++++++-
>  drivers/scsi/mpt3sas/mpt3sas_scsih.c |  431 +++++++++++++++++++++++++++++++---
>  2 files changed, 507 insertions(+), 34 deletions(-)
> 
Have you considered using 'scan_start()/scan_finished()' SCSI midlayer
callbacks here?
Seeing that you are enumerating the devices internally already that
should give you better control about the scanning process.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
