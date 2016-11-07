From: hare@suse.de (Hannes Reinecke)
Date: Mon, 7 Nov 2016 07:50:30 +0100
Subject: [PATCH v5 1/7] Add type 0x28 NVME type code to scsi fc headers
In-Reply-To: <58201def.w5lxXYeII2Zh0+VN%jsmart2021@gmail.com>
References: <58201def.w5lxXYeII2Zh0+VN%jsmart2021@gmail.com>
Message-ID: <f0664b5d-714c-1ef4-b3d2-7a6eeffa35ed@suse.de>

On 11/07/2016 07:23 AM, James Smart wrote:
> 
> Add type 0x28 NVME type code to scsi fc headers
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> Reviewed-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  include/uapi/scsi/fc/fc_fs.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/uapi/scsi/fc/fc_fs.h b/include/uapi/scsi/fc/fc_fs.h
> index 50f28b1..dcf314d 100644
> --- a/include/uapi/scsi/fc/fc_fs.h
> +++ b/include/uapi/scsi/fc/fc_fs.h
> @@ -190,6 +190,7 @@ enum fc_fh_type {
>  	FC_TYPE_FCP =	0x08,	/* SCSI FCP */
>  	FC_TYPE_CT =	0x20,	/* Fibre Channel Services (FC-CT) */
>  	FC_TYPE_ILS =	0x22,	/* internal link service */
> +	FC_TYPE_NVME =	0x28,	/* FC-NVME */
>  };
>  
>  /*
> @@ -203,6 +204,7 @@ enum fc_fh_type {
>  	[FC_TYPE_FCP] =		"FCP",			\
>  	[FC_TYPE_CT] =		"CT",			\
>  	[FC_TYPE_ILS] =		"ILS",			\
> +	[FC_TYPE_NVME] =	"NVME",			\
>  }
>  
>  /*
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
