From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 22 Feb 2017 21:35:45 +0200
Subject: [PATCH] lpfc: add missing Kconfig NVME dependencies
In-Reply-To: <58adba5f.BoP49Cv2S5zD9ZuD%jsmart2021@gmail.com>
References: <58adba5f.BoP49Cv2S5zD9ZuD%jsmart2021@gmail.com>
Message-ID: <e2550d34-6453-73b0-8470-7b6ff9fec73f@grimberg.me>


> add missing Kconfig NVME dependencies
>
> Can't believe I missed posting this
>
> -- james

Heh, the this sort of comment should come after
the '---' separator (below) unless you want it to live forever
in the git log...

>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---

[here]

>  drivers/scsi/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> index d4023bf..2558434 100644
> --- a/drivers/scsi/Kconfig
> +++ b/drivers/scsi/Kconfig
> @@ -1240,6 +1240,7 @@ config SCSI_LPFC
>  	tristate "Emulex LightPulse Fibre Channel Support"
>  	depends on PCI && SCSI
>  	depends on SCSI_FC_ATTRS
> +	depends on NVME_FC && NVME_TARGET_FC
>  	select CRC_T10DIF
>  	help
>            This lpfc driver supports the Emulex LightPulse
>
