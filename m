From: hare@suse.de (Hannes Reinecke)
Date: Thu, 11 May 2017 09:35:15 +0200
Subject: [PATCH 10/15] lpfc: Fix NVME I+T not registering NVME as a
 supported FC4 type
In-Reply-To: <20170510190713.30171-11-jsmart2021@gmail.com>
References: <20170510190713.30171-1-jsmart2021@gmail.com>
 <20170510190713.30171-11-jsmart2021@gmail.com>
Message-ID: <5adc07ff-c925-b59f-2cb3-b5758856303c@suse.de>

On 05/10/2017 09:07 PM, James Smart wrote:
> When the driver send the RPA command, it does not
> send supported FC4 Type NVME to the management server.
> 
> Encode NVME (type x28) in the AttribEntry in the
> RPA command.
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/scsi/lpfc/lpfc_ct.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
> index c7962dae4dab..f2cd19c6c2df 100644
> --- a/drivers/scsi/lpfc/lpfc_ct.c
> +++ b/drivers/scsi/lpfc/lpfc_ct.c
> @@ -2092,6 +2092,7 @@ lpfc_fdmi_port_attr_fc4type(struct lpfc_vport *vport,
>  
>  	ae->un.AttrTypes[3] = 0x02; /* Type 1 - ELS */
>  	ae->un.AttrTypes[2] = 0x01; /* Type 8 - FCP */
> +	ae->un.AttrTypes[6] = 0x01; /* Type 40 - NVME */
>  	ae->un.AttrTypes[7] = 0x01; /* Type 32 - CT */
>  	size = FOURBYTES + 32;
>  	ad->AttrLen = cpu_to_be16(size);
> 
Are you sure about the 'Type 40' ?
I was under the impression that FC-4 Types is a bitmask of available
types, so if bit6 really refer to Type 40, how can bit7 refer to
type 32 ?

Please clarify.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
