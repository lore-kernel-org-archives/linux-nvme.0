From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Fri, 17 May 2019 01:51:38 +0900
Subject: [PATCH] nvme-cli: remove unused NVME_AER_NOTICE_*
In-Reply-To: <1558024889-9474-1-git-send-email-akinobu.mita@gmail.com>
References: <1558024889-9474-1-git-send-email-akinobu.mita@gmail.com>
Message-ID: <20190516165137.GG24001@minwooim-desktop>

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

It looks like we can sync-up the header files sooner or later from the
kernel code to avoid kind of conflicts you mentioned.

Anyway,

Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>
