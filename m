From: hare@suse.de (Hannes Reinecke)
Date: Thu, 11 May 2017 08:06:27 +0200
Subject: [PATCH 03/15] lpfc: Adding additional stats counters for nvme.
In-Reply-To: <20170510190713.30171-4-jsmart2021@gmail.com>
References: <20170510190713.30171-1-jsmart2021@gmail.com>
 <20170510190713.30171-4-jsmart2021@gmail.com>
Message-ID: <0b3bd7fb-2897-dfb2-3c87-8ed7e581ab56@suse.de>

On 05/10/2017 09:07 PM, James Smart wrote:
> More debug messages added for nvme statistics.
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/scsi/lpfc/lpfc_attr.c    | 24 ++++++++++++---------
>  drivers/scsi/lpfc/lpfc_debugfs.c | 27 +++++++++++++----------
>  drivers/scsi/lpfc/lpfc_nvmet.c   | 46 ++++++++++++++++++++++++++++++----------
>  drivers/scsi/lpfc/lpfc_nvmet.h   | 12 ++++++-----
>  drivers/scsi/lpfc/lpfc_sli.c     | 38 ++++++++++++++++++++++++++++-----
>  drivers/scsi/lpfc/lpfc_sli4.h    |  2 +-
>  6 files changed, 106 insertions(+), 43 deletions(-)
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
