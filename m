From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 23 May 2016 04:00:03 -0700
Subject: [PATCH] NVMe: Recognize the MacBook9,1 NVMe controller
In-Reply-To: <20160516175209.GA21751@speicherleck.de>
References: <20160516175209.GA21751@speicherleck.de>
Message-ID: <20160523110003.GD26331@infradead.org>

>  	 * some MacBook7,1 to avoid controller resets and data loss.
> +	 * For the controller found in the MacBook9,1 (device ID 0x2003), it
> +	 * seems that this workaround is not necessary.

No need for this comment.

>  	if (pdev->vendor == PCI_VENDOR_ID_APPLE && pdev->device == 0x2001) {
>  		dev->q_depth = 2;
> @@ -2181,6 +2183,7 @@ static const struct pci_device_id nvme_id_table[] = {
>  		.driver_data = NVME_QUIRK_IDENTIFY_CNS, },
>  	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },  /* for the MacBook 9,1 */

But it might be worth to have a comment above these two entries like

	/*
	 * Controller that don't use the NVMe class code:
         */

and skip the comment after your newly added entry.

Otherwise this looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>
