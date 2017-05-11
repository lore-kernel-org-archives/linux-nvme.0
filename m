From: hare@suse.de (Hannes Reinecke)
Date: Thu, 11 May 2017 08:04:55 +0200
Subject: [PATCH 01/15] lpfc: Fix used-RPI accounting problem.
In-Reply-To: <20170510190713.30171-2-jsmart2021@gmail.com>
References: <20170510190713.30171-1-jsmart2021@gmail.com>
 <20170510190713.30171-2-jsmart2021@gmail.com>
Message-ID: <8727c83e-9064-e53c-34ed-f46edb6dd6c2@suse.de>

On 05/10/2017 09:06 PM, James Smart wrote:
> With 255 vports created a link trasition can casue a crash.
> 
> When going through discovery after a link bounce the driver is using
> rpis before the cmd FCOE_POST_HDR_TEMPLATES completes. By doing that
> the next rpi bumps the rpi range out of the boundary.
> 
> The fix it to increment the next_rpi only when the FCOE_POST_HDR_TEMPLATE
> succeeds.
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/scsi/lpfc/lpfc_els.c  |  3 ++-
>  drivers/scsi/lpfc/lpfc_init.c | 24 +++++-------------------
>  drivers/scsi/lpfc/lpfc_sli.c  |  8 ++++++++
>  drivers/scsi/lpfc/lpfc_sli4.h |  1 +
>  4 files changed, 16 insertions(+), 20 deletions(-)
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
