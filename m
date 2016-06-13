From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Mon, 13 Jun 2016 11:43:08 -0300
Subject: [PATCH v2] nvme/quirk: Add a delay before checking for adapter
 readiness
In-Reply-To: <BL2PR04MB1639B69DE3FC1B28913FEE392530@BL2PR04MB163.namprd04.prod.outlook.com>
References: <201606011754.u51HsKE4032778@mx0a-001b2d01.pphosted.com>
 <BL2PR04MB1639B69DE3FC1B28913FEE392530@BL2PR04MB163.namprd04.prod.outlook.com>
Message-ID: <575EC67C.60304@linux.vnet.ibm.com>

On 06/13/2016 10:57 AM, Jeff Lien wrote:
> I have reviewed this patch and approve it.
>

Thanks Jeff, I'll sent a v3 implementing Christoph's suggestion.
Cheers,


Guilherme

> ----------------------------------------------------------
> Jeff Lien
> Linux Device Driver Development
> Device Host Apps and Drivers
> Western Digital Corporation
> e.  jeff.lien at hgst.com
> o.  +1-507-322-2416
> m. +1-507-273-9124
>
>
>
>
>
> ________________________________________
> From: Guilherme G. Piccoli <gpiccoli at linux.vnet.ibm.com>
> Sent: Wednesday, June 01, 2016 12:54:20 PM
> To: linux-nvme at lists.infradead.org
> Cc: keith.busch at intel.com; axboe at fb.com; hch at infradead.org; brking at linux.vnet.ibm.com; krisman at linux.vnet.ibm.com; halves at linux.vnet.ibm.com; mniyer at us.ibm.com; David Darrington; Jeff Lien; Guilherme G. Piccoli
> Subject: [PATCH v2] nvme/quirk: Add a delay before checking for adapter readiness
>
> When disabling the controller, the specification says the register
> NVME_REG_CC should be written and then driver needs to wait the
> adapter to be ready, which is checked by reading another register
> bit (NVME_CSTS_RDY). There's a timeout validation in this checking,
> so in case this timeout is reached the driver gives up and removes
> the adapter from the system.
>
> After a firmware activation procedure, the PCI_DEVICE(0x1c58, 0x0003)
> (HGST adapter) end up being removed if we issue a reset_controller,
> because driver keeps verifying the NVME_REG_CSTS until the timeout is
> reached. This patch adds a necessary quirk for this adapter, by
> introducing a delay before nvme_wait_ready(), so the reset procedure
> is able to be completed. This quirk is needed because just increasing
> the timeout is not enough in case of this adapter - the driver must
> wait before start reading NVME_REG_CSTS register on this specific
> device.
>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli at linux.vnet.ibm.com>
> ---
>   drivers/nvme/host/core.c |  7 +++++++
>   drivers/nvme/host/nvme.h | 13 +++++++++++++
>   drivers/nvme/host/pci.c  |  2 ++
>   3 files changed, 22 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 1a51584..53e344d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -991,6 +991,13 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl, u64 cap)
>          ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
>          if (ret)
>                  return ret;
> +
> +       /* Checking for ctrl->tagset is a trick to avoid sleeping on module
> +        * load, since we only need the quirk on reset_controller.
> +        */
> +       if ((ctrl->quirks & NVME_QUIRK_DELAY_BEFORE_CHK_RDY) && ctrl->tagset)
> +               msleep(NVME_QUIRK_DELAY_AMOUNT);
> +
>          return nvme_wait_ready(ctrl, cap, false);
>   }
>   EXPORT_SYMBOL_GPL(nvme_disable_ctrl);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 1daa048..97ac7d1 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -65,8 +65,21 @@ enum nvme_quirks {
>           * logical blocks.
>           */
>          NVME_QUIRK_DISCARD_ZEROES               = (1 << 2),
> +
> +       /*
> +        * The controller needs a delay before starts checking the device
> +        * readiness, which is done by reading the NVME_CSTS_RDY bit.
> +        */
> +       NVME_QUIRK_DELAY_BEFORE_CHK_RDY         = (1 << 3),
>   };
>
> +/* The below value is the specific amount of delay needed before checking
> + * readiness in case of the PCI_DEVICE(0x1c58, 0x0003), which needs the
> + * NVME_QUIRK_DELAY_BEFORE_CHK_RDY quirk enabled. The value (in ms) was
> + * found empirically.
> + */
> +#define NVME_QUIRK_DELAY_AMOUNT                2000
> +
>   enum nvme_ctrl_state {
>          NVME_CTRL_NEW,
>          NVME_CTRL_LIVE,
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 78dca31..d02255c 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2117,6 +2117,8 @@ static const struct pci_device_id nvme_id_table[] = {
>                                  NVME_QUIRK_DISCARD_ZEROES, },
>          { PCI_VDEVICE(INTEL, 0x5845),   /* Qemu emulated controller */
>                  .driver_data = NVME_QUIRK_IDENTIFY_CNS, },
> +       { PCI_DEVICE(0x1c58, 0x0003),   /* HGST adapter */
> +               .driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
>          { PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
>          { PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
>          { 0, }
> --
> 2.1.0
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>
