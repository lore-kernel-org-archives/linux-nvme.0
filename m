From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 28 Jun 2017 10:27:09 +0300
Subject: [PATCH] nvme: Quirks for PM1725 controllers
In-Reply-To: <20170628022757.32309-1-martin.petersen@oracle.com>
References: <20170628022757.32309-1-martin.petersen@oracle.com>
Message-ID: <f3690fd0-caa7-fb84-3a81-9a90c90f6db4@grimberg.me>


> PM1725 controllers have a couple of quirks that need to be handled in
> the driver:
> 
>   - I/O queue depth must be limited to 64 entries on controllers that do
>     not report MQES.

I think this can be a new quirk (NVME_QUIRK_QD_LIMIT_64 or something)

> @@ -1908,6 +1908,12 @@ static int nvme_pci_enable(struct nvme_dev *dev)
>   		dev_warn(dev->ctrl.device, "detected Apple NVMe controller, "
>   			"set queue depth=%u to work around controller resets\n",
>   			dev->q_depth);
> +	} else if (pdev->vendor == PCI_VENDOR_ID_SAMSUNG &&
> +		   (pdev->device == 0xa821 || pdev->device == 0xa822) &&
> +		   NVME_CAP_MQES(cap) == 0) {

and the this is:

	} else if (dev->ctrl.quirks & NVME_QUIRK_QD_LIMIT_64) {

While its inside the pci driver, I think it would be cleaner to
use the quirks mechanism.

Kieth? thoughts?
