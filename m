From: javier@cnexlabs.com (Javier Gonzalez)
Date: Tue, 17 Apr 2018 09:26:29 +0000
Subject: [PATCH] nvme: lightnvm: add granby support
In-Reply-To: <1523930112-7402-1-git-send-email-wxu@cnexlabs.com>
References: <1523930112-7402-1-git-send-email-wxu@cnexlabs.com>
Message-ID: <C98EF5A1-0836-40B8-BEDD-8D66C0820257@cnexlabs.com>

> On 17 Apr 2018,@03.55, Wei Xu <wxu@cnexlabs.com> wrote:
> 
> Add a new lightnvm quirk to identify CNEX?s Granby controller.
> 
> Signed-off-by: Wei Xu <wxu at cnexlabs.com>
> ---
> drivers/nvme/host/pci.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index cb73bc8..9419e88 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2529,6 +2529,8 @@ static const struct pci_device_id nvme_id_table[] = {
> 		.driver_data = NVME_QUIRK_LIGHTNVM, },
> 	{ PCI_DEVICE(0x1d1d, 0x2807),	/* CNEX WL */
> 		.driver_data = NVME_QUIRK_LIGHTNVM, },
> +	{ PCI_DEVICE(0x1d1d, 0x2601),	/* CNEX Granby */
> +		.driver_data = NVME_QUIRK_LIGHTNVM, },
> 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
> 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
> 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
> --
> 2.7.4


Reviewed-by: Javier Gonz?lez <javier at cnexlabs.com>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180417/7e5ba093/attachment.sig>
