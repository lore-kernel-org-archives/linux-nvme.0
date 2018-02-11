From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 11 Feb 2018 13:19:15 +0200
Subject: [PATCH 4/9] nvme-pci: quiesce IO queues prior to disabling device
 HMB accesses
In-Reply-To: <1518341920-1060-5-git-send-email-jianchao.w.wang@oracle.com>
References: <1518341920-1060-1-git-send-email-jianchao.w.wang@oracle.com>
 <1518341920-1060-5-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <bf278273-ec7c-e711-b82a-215d45dbe739@grimberg.me>


> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 6fe7af0..00cffed 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2186,7 +2186,10 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>   	if (!dead) {
>   		if (shutdown)
>   			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
> +	}
> +	nvme_stop_queues(&dev->ctrl);

Nit, extra newline before nvme_stop_queues would be nice.

Other than that, looks good,

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
