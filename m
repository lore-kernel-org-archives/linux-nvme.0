From: hare@suse.de (Hannes Reinecke)
Date: Thu, 3 Aug 2017 08:33:13 +0200
Subject: [PATCH v2 04/13] mpt3sas: Added support for nvme encapsulated
 request message.
In-Reply-To: <1500038560-11231-5-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1500038560-11231-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1500038560-11231-5-git-send-email-suganath-prabu.subramani@broadcom.com>
Message-ID: <75dcdeda-5f3c-cef0-9957-4588ac9624cc@suse.de>

On 07/14/2017 03:22 PM, Suganath Prabu S wrote:
> * Mpt3sas driver uses the NVMe Encapsulated Request message to
> send an NVMe command to an NVMe device attached to the IOC.
> 
> * Normal I/O commands like reads and writes are passed to the
> controller as SCSI commands and the controller has the ability
> to translate the commands to NVMe equivalent.
> 
> * This encapsulated NVMe command is used by applications to send
> direct NVMe commands to NVMe drives or for handling unmap where
> the translation at controller/firmware level is having
> performance issues.
> 
> Signed-off-by: Chaitra P B <chaitra.basappa at broadcom.com>
> Signed-off-by: Suganath Prabu S <suganath-prabu.subramani at broadcom.com>
> ---
>  drivers/scsi/mpt3sas/mpt3sas_base.c |   56 ++++++++++++++++++++++++++++-
>  drivers/scsi/mpt3sas/mpt3sas_base.h |    1 +
>  drivers/scsi/mpt3sas/mpt3sas_ctl.c  |   69 ++++++++++++++++++++++++++++++++---
>  3 files changed, 119 insertions(+), 7 deletions(-)
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
