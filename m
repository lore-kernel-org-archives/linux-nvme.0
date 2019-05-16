From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 16 May 2019 23:11:25 +0000
Subject: [PATCH] nvme-cli: remove unused NVME_AER_NOTICE_*
References: <1558024889-9474-1-git-send-email-akinobu.mita@gmail.com>
Message-ID: <DM6PR04MB45210B9B1183749E041084F0860A0@DM6PR04MB4521.namprd04.prod.outlook.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

On 5/16/19 9:41 AM, Akinobu Mita wrote:
> NVME_AER_NOTICE_* are unused and these values conflict with the values
> defined in the kernel nvme.h.
>
> Cc: Keith Busch <keith.busch at intel.com>
> Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
> ---
>  linux/nvme.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/linux/nvme.h b/linux/nvme.h
> index cac4d19..13fa52a 100644
> --- a/linux/nvme.h
> +++ b/linux/nvme.h
> @@ -589,9 +589,6 @@ enum {
>  	NVME_AER_SMART			= 1,
>  	NVME_AER_CSS			= 6,
>  	NVME_AER_VS			= 7,
> -	NVME_AER_NOTICE_NS_CHANGED	= 0x0002,
> -	NVME_AER_NOTICE_ANA		= 0x0003,
> -	NVME_AER_NOTICE_FW_ACT_STARTING = 0x0102,
>  };
>  
>  struct nvme_lba_range_type {
