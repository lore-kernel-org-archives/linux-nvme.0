From: hare@suse.de (Hannes Reinecke)
Date: Wed, 18 Jan 2017 08:41:22 +0100
Subject: [PATCH 08/17] lpfc: NVME Initiator: Merge into FC discovery
In-Reply-To: <587ec2f3.tTtsqdflq8F2Y4Tt%jsmart2021@gmail.com>
References: <587ec2f3.tTtsqdflq8F2Y4Tt%jsmart2021@gmail.com>
Message-ID: <6a367b18-6566-964a-98c5-04d9bfce79d0@suse.de>

On 01/18/2017 02:20 AM, James Smart wrote:
> 
> NVME Initiator: Merge into FC discovery
> 
> Adds NVME PRLI support and Nameserver registrations and Queries for NVME
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/scsi/lpfc/lpfc.h           |   6 +-
>  drivers/scsi/lpfc/lpfc_ct.c        | 441 +++++++++++++++++++++++--------------
>  drivers/scsi/lpfc/lpfc_disc.h      |  19 +-
>  drivers/scsi/lpfc/lpfc_els.c       | 320 +++++++++++++++++++--------
>  drivers/scsi/lpfc/lpfc_hbadisc.c   | 169 +++++++++++---
>  drivers/scsi/lpfc/lpfc_hw.h        |  77 +++++--
>  drivers/scsi/lpfc/lpfc_hw4.h       |  43 ++++
>  drivers/scsi/lpfc/lpfc_nportdisc.c | 198 +++++++++++++++--
>  8 files changed, 938 insertions(+), 335 deletions(-)
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
