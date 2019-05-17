From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Fri, 17 May 2019 16:30:42 +0000
Subject: [PATCH v2 4/4] nvme: release namespace SRCU protection before
 performing controller ioctls
References: <20190517094736.14504-1-hch@lst.de>
 <20190517094736.14504-4-hch@lst.de>
Message-ID: <SN6PR04MB4527A3B33425E8E17B6C720C860B0@SN6PR04MB4527.namprd04.prod.outlook.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

On 5/17/19 2:48 AM, Christoph Hellwig wrote:
> Holding the SRCU critical section protecting the namespace list can
> cause deadlocks when using the per-namespace admin passthrough ioctl to
> delete as namespace.  Release it earlier when performing per-controller
> ioctls to avoid that.
>
> Reported-by: Kenneth Heitke <kenneth.heitke at intel.com>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/host/core.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 2d56cca1cded..6af88de83ea7 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1394,14 +1394,31 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
>  	if (unlikely(!ns))
>  		return -EWOULDBLOCK;
>  
> +	/*
> +	 * Handle ioctls that apply to the controller instead of the namespace
> +	 * seperately and drop the ns SRCU reference early.  This avoids a
> +	 * deadlock when deleting namespaces using the passthrough interface.
> +	 */
> +	if (cmd == NVME_IOCTL_ADMIN_CMD || is_sed_ioctl(cmd)) {
> +		struct nvme_ctrl *ctrl = ns->ctrl;
> +
> +		nvme_get_ctrl(ns->ctrl);
> +		nvme_put_ns_from_disk(head, srcu_idx);
> +
> +		if (cmd == NVME_IOCTL_ADMIN_CMD)
> +			ret = nvme_user_cmd(ctrl, NULL, argp);
> +		else
> +			ret = sed_ioctl(ctrl->opal_dev, cmd, argp);
> +
> +		nvme_put_ctrl(ctrl);
> +		return ret;
> +	}
> +
>  	switch (cmd) {
>  	case NVME_IOCTL_ID:
>  		force_successful_syscall_return();
>  		ret = ns->head->ns_id;
>  		break;
> -	case NVME_IOCTL_ADMIN_CMD:
> -		ret = nvme_user_cmd(ns->ctrl, NULL, argp);
> -		break;
>  	case NVME_IOCTL_IO_CMD:
>  		ret = nvme_user_cmd(ns->ctrl, ns, argp);
>  		break;
> @@ -1411,8 +1428,6 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
>  	default:
>  		if (ns->ndev)
>  			ret = nvme_nvm_ioctl(ns, cmd, arg);
> -		else if (is_sed_ioctl(cmd))
> -			ret = sed_ioctl(ns->ctrl->opal_dev, cmd, argp);
>  		else
>  			ret = -ENOTTY;
>  	}
