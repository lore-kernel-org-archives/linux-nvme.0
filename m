From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 13 Jul 2017 10:01:36 +0300
Subject: [PATCH] nvme: Add support for NVMe 1.3 Timestamp Feature
In-Reply-To: <20170712221101.1715-1-jonathan.derrick@intel.com>
References: <20170712221101.1715-1-jonathan.derrick@intel.com>
Message-ID: <59e271b0-00d8-d705-b56e-a93d7b21e393@grimberg.me>


> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 5d5aa7f..82ce677 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2156,6 +2156,10 @@ static void nvme_reset_work(struct work_struct *work)
>   	if (result)
>   		goto out;
>   
> +	if (dev->ctrl.vs >= NVME_VS(1, 3, 0) &&
> +	    dev->ctrl.oncs & NVME_CTRL_ONCS_TIMESTAMP)
> +		nvme_set_timestamp(&dev->ctrl);
> +

Why after setting up the I/O queues?
