From: keith.busch@linux.intel.com (Keith Busch)
Date: Thu, 21 Jun 2018 08:09:48 -0600
Subject: [PATCH V2] nvme-pci: move nvme_kill_queues to
 nvme_remove_dead_ctrl
In-Reply-To: <1529473342-1886-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1529473342-1886-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <20180621140948.GA26662@localhost.localdomain>

On Wed, Jun 20, 2018@01:42:22PM +0800, Jianchao Wang wrote:
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index fc33804..73a97fc 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2289,6 +2289,7 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev, int status)
>  
>  	nvme_get_ctrl(&dev->ctrl);
>  	nvme_dev_disable(dev, false);
> +	nvme_kill_queues(&dev->ctrl);
>  	if (!queue_work(nvme_wq, &dev->remove_work))
>  		nvme_put_ctrl(&dev->ctrl);
>  }
> @@ -2405,7 +2406,6 @@ static void nvme_remove_dead_ctrl_work(struct work_struct *work)
>  	struct nvme_dev *dev = container_of(work, struct nvme_dev, remove_work);
>  	struct pci_dev *pdev = to_pci_dev(dev->dev);
>  
> -	nvme_kill_queues(&dev->ctrl);
>  	if (pci_get_drvdata(pdev))
>  		device_release_driver(&pdev->dev);
>  	nvme_put_ctrl(&dev->ctrl);

Looks good to me.

Reviewed-by: Keith Busch <keith.busch at intel.com>
