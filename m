From: axboe@fb.com (Jens Axboe)
Date: Thu, 8 Sep 2016 10:18:04 -0600
Subject: [PATCH] nvme/quirk: Add a delay before checking device ready for
 memblaze device
In-Reply-To: <1473351131-11811-1-git-send-email-mail_weber_wang@163.com>
References: <1473351131-11811-1-git-send-email-mail_weber_wang@163.com>
Message-ID: <5ec7070e-a3d5-ba90-fedf-cb707d4655d5@fb.com>

On 09/08/2016 10:12 AM, Wenbo Wang wrote:
> From: Wenbo Wang <wenbo.wang at memblaze.com>
>
> Signed-off-by: Wenbo Wang <wenbo.wang at memblaze.com>
> ---
>  drivers/nvme/host/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 663c40c..2fec23c 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2141,6 +2141,8 @@ static const struct pci_device_id nvme_id_table[] = {
>  		.driver_data = NVME_QUIRK_IDENTIFY_CNS, },
>  	{ PCI_DEVICE(0x1c58, 0x0003),	/* HGST adapter */
>  		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
> +	{ PCI_DEVICE(0x1c5f, 0x0540),	/* Memblaze Pblaze4 adapter */
> +		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
>  	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
>  	{ 0, }

Thanks, applied for 4.8.

-- 
Jens Axboe
