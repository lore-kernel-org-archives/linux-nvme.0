From: vishal.l.verma@intel.com (Verma, Vishal L)
Date: Mon, 12 Jan 2015 19:04:22 +0000
Subject: [PATCH] NVMe: Fix scsi mode select llbaa setting
In-Reply-To: <1420849240-2259-1-git-send-email-keith.busch@intel.com>
References: <1420849240-2259-1-git-send-email-keith.busch@intel.com>
Message-ID: <1421089462.23334.3.camel@intel.com>

On Fri, 2015-01-09@17:20 -0700, Keith Busch wrote:
> It should be a logical bitwise AND, not conditional.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/block/nvme-scsi.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Acked-by: Vishal Verma <vishal.l.verma at linux.intel.com>

Thanks, good catch!

> diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
> index 046ae33..63efe40 100644
> --- a/drivers/block/nvme-scsi.c
> +++ b/drivers/block/nvme-scsi.c
> @@ -1600,7 +1600,7 @@ static inline void nvme_trans_modesel_get_bd_len(u8 *parm_list, u8 cdb10,
>  		/* 10 Byte CDB */
>  		*bd_len = (parm_list[MODE_SELECT_10_BD_OFFSET] << 8) +
>  			parm_list[MODE_SELECT_10_BD_OFFSET + 1];
> -		*llbaa = parm_list[MODE_SELECT_10_LLBAA_OFFSET] &&
> +		*llbaa = parm_list[MODE_SELECT_10_LLBAA_OFFSET] &
>  				MODE_SELECT_10_LLBAA_MASK;
>  	} else {
>  		/* 6 Byte CDB */
