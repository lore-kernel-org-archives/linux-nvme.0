From: hare@suse.de (Hannes Reinecke)
Date: Thu, 11 May 2017 08:21:09 +0200
Subject: [PATCH 06/15] lpfc: Fix NMI watchdog assertions when running
 nvmet IOPS tests
In-Reply-To: <20170510190713.30171-7-jsmart2021@gmail.com>
References: <20170510190713.30171-1-jsmart2021@gmail.com>
 <20170510190713.30171-7-jsmart2021@gmail.com>
Message-ID: <26548783-b861-a415-5d39-03d040a0b998@suse.de>

On 05/10/2017 09:07 PM, James Smart wrote:
> After running IOPS test for 30 second we get
> kernel:NMI watchdog: Watchdog detected hard LOCKUP on cpu 0
> 
> The driver is speend too much time in it's ISR.
> 
> In ISR EQ and CQ processing routines, if we hit the entry_repost
> numbers of EQE/CQEs just break out of the routine as opposed to
> hitting the doorbell with NOARM and continue processing.
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/scsi/lpfc/lpfc_debugfs.c | 30 +++++++++++++++---------------
>  drivers/scsi/lpfc/lpfc_sli.c     |  8 ++------
>  2 files changed, 17 insertions(+), 21 deletions(-)
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
