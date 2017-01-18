From: hare@suse.de (Hannes Reinecke)
Date: Wed, 18 Jan 2017 07:57:10 +0100
Subject: [PATCH 01/17] lpfc: Use new pci_alloc_irq_vectors() interface
In-Reply-To: <587ec2ec.lHOM16QZ9nmppg4/%jsmart2021@gmail.com>
References: <587ec2ec.lHOM16QZ9nmppg4/%jsmart2021@gmail.com>
Message-ID: <9773daca-af73-0575-c2b8-a5e44777e1b5@suse.de>

On 01/18/2017 02:20 AM, James Smart wrote:
> 
> Move to new pci_alloc_irq_vectors() interface for intx/msi/msix
> 
> Note: io channel paradigm remains, for now.
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/scsi/lpfc/lpfc_init.c | 227 ++++++++++++++++++++++++++++--------------
>  1 file changed, 154 insertions(+), 73 deletions(-)
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
