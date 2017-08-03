From: hare@suse.de (Hannes Reinecke)
Date: Thu, 3 Aug 2017 08:44:03 +0200
Subject: [PATCH v2 11/13] mpt3sas: NVMe drive support for BTDHMAPPING
 ioctl command and log info
In-Reply-To: <1500038560-11231-12-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1500038560-11231-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1500038560-11231-12-git-send-email-suganath-prabu.subramani@broadcom.com>
Message-ID: <f51a7368-1204-9dcc-a516-9552f5bddd4f@suse.de>

On 07/14/2017 03:22 PM, Suganath Prabu S wrote:
> * Added debug prints for pcie devices in ioctl debug path. Which
> will be helpful for debugging.
> * Added PCIe device support for ioctl BTDHMAPPING ioctl.
> 
> Signed-off-by: Chaitra P B <chaitra.basappa at broadcom.com>
> Signed-off-by: Suganath Prabu S <suganath-prabu.subramani at broadcom.com>
> ---
>  drivers/scsi/mpt3sas/mpt3sas_ctl.c |   88 +++++++++++++++++++++++------------
>  1 files changed, 58 insertions(+), 30 deletions(-)
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
