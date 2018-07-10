From: keith.busch@linux.intel.com (Keith Busch)
Date: Tue, 10 Jul 2018 08:45:52 -0600
Subject: [PATCH v2 2/2] nvme-pci: release nvme_ctrl if failed to alloc
 memory in nvme_probe
In-Reply-To: <4f4b62ad826bc11debfab9eff3d460b03ec66f08.1530548893.git.zhangweiping@didichuxing.com>
References: <cover.1530548893.git.zhangweiping@didichuxing.com>
 <4f4b62ad826bc11debfab9eff3d460b03ec66f08.1530548893.git.zhangweiping@didichuxing.com>
Message-ID: <20180710144552.GC11548@localhost.localdomain>

On Tue, Jul 03, 2018@12:35:44AM +0800, Weiping Zhang wrote:
> release nvme_ctrl if failed to alloc memory for iod_mempool, otherwise
> /dev/nvmeX cann't be removed for this nvme controller, any ioctl to
> this device doesn't work.
> 
> Signed-off-by: Weiping Zhang <zhangweiping at didichuxing.com>
> ---
>  drivers/nvme/host/pci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 92a8b5b2b39e..29aff33c4b4c 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2576,8 +2576,10 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  						(void *) alloc_size,
>  						GFP_KERNEL, node);
>  	if (!dev->iod_mempool) {
> -		result = -ENOMEM;
> -		goto release_pools;
> +		nvme_uninit_ctrl(&dev->ctrl);
> +		/* all above resource will be released after put ctrl */
> +		nvme_put_ctrl(&dev->ctrl);
> +		return -ENOMEM;
>  	}
>  
>  	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
> -- 

I think it would be better to just move the mempool allocation above
nvme_init_ctrl.
