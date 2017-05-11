From: hare@suse.de (Hannes Reinecke)
Date: Thu, 11 May 2017 08:05:26 +0200
Subject: [PATCH 02/15] lpfc: Fix system crash when port is reset.
In-Reply-To: <20170510190713.30171-3-jsmart2021@gmail.com>
References: <20170510190713.30171-1-jsmart2021@gmail.com>
 <20170510190713.30171-3-jsmart2021@gmail.com>
Message-ID: <f64876d0-0087-366d-e214-1082616863c3@suse.de>

On 05/10/2017 09:07 PM, James Smart wrote:
> The driver panic when using the els_wq during port reset.
> 
> Check for NULL els_wq before dereferencing.
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/scsi/lpfc/lpfc.h         | 8 ++++++--
>  drivers/scsi/lpfc/lpfc_hbadisc.c | 6 +++---
>  2 files changed, 9 insertions(+), 5 deletions(-)
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
