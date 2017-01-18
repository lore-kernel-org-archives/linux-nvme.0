From: hare@suse.de (Hannes Reinecke)
Date: Wed, 18 Jan 2017 09:03:25 +0100
Subject: [PATCH 13/17] lpfc: NVME Target: Merge into FC discovery
In-Reply-To: <587ec2f8.5mEXNd/HV7Rc1N2O%jsmart2021@gmail.com>
References: <587ec2f8.5mEXNd/HV7Rc1N2O%jsmart2021@gmail.com>
Message-ID: <629d1db3-0e2a-c730-87dd-520275ea1132@suse.de>

On 01/18/2017 02:20 AM, James Smart wrote:
> 
> NVME Target: Merge into FC discovery
> 
> Adds NVME PRLI handling and Nameserver registrations for NVME
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/scsi/lpfc/lpfc_ct.c        |  8 +++++++-
>  drivers/scsi/lpfc/lpfc_els.c       | 34 ++++++++++++++++++++++++++++++----
>  drivers/scsi/lpfc/lpfc_hbadisc.c   | 27 +++++++++++++++++++++++----
>  drivers/scsi/lpfc/lpfc_nportdisc.c | 35 ++++++++++++++++++++++++++++++++---
>  4 files changed, 92 insertions(+), 12 deletions(-)
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
