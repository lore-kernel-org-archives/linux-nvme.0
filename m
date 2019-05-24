From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 23 May 2019 23:35:45 -0700
Subject: [PATCH] nvme: Ignore timeouts while PCI config access is blocked
In-Reply-To: <20190523231429.21235-1-kenneth.heitke@intel.com>
References: <20190523231429.21235-1-kenneth.heitke@intel.com>
Message-ID: <99e76784-ce68-c053-9fde-d035d77f11d3@grimberg.me>


>   static void nvme_reset_done(struct pci_dev *pdev)
>   {
>   	struct nvme_dev *dev = pci_get_drvdata(pdev);
> -	nvme_reset_ctrl_sync(&dev->ctrl);
> +	nvme_reset_ctrl(&dev->ctrl);

This change is not explained in the change log. This opens a window
for nvme_reset_work to run concurrently from different contexts which
is not a good idea...
