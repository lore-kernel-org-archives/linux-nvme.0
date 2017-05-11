From: hare@suse.de (Hannes Reinecke)
Date: Thu, 11 May 2017 09:51:29 +0200
Subject: [PATCH 14/15] lpfc: Add MDS Diagnostic support.
In-Reply-To: <20170510190713.30171-15-jsmart2021@gmail.com>
References: <20170510190713.30171-1-jsmart2021@gmail.com>
 <20170510190713.30171-15-jsmart2021@gmail.com>
Message-ID: <2a4b53a6-a9ea-cef0-ed46-9c93f571532b@suse.de>

On 05/10/2017 09:07 PM, James Smart wrote:
> Added code to support Cisco MDS loopback diagnostic. The diagnostics
> run various loopbacks including one which loops-back frame through
> the driver.
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/scsi/lpfc/lpfc.h         |   2 +
>  drivers/scsi/lpfc/lpfc_els.c     |   7 +++
>  drivers/scsi/lpfc/lpfc_hbadisc.c |   3 +-
>  drivers/scsi/lpfc/lpfc_hw4.h     |  15 ++++-
>  drivers/scsi/lpfc/lpfc_init.c    |  13 ++++
>  drivers/scsi/lpfc/lpfc_sli.c     | 131 ++++++++++++++++++++++++++++++++++++---
>  6 files changed, 161 insertions(+), 10 deletions(-)
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
