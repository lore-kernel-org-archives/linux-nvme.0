From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 16 May 2019 22:33:35 +0000
Subject: [PATCH 2/4] nvme: remove the ifdef around nvme_nvm_ioctl
References: <20190516185036.17394-1-hch@lst.de>
 <20190516185036.17394-2-hch@lst.de>
Message-ID: <DM6PR04MB4521A2EDC680B06D311E1C61860A0@DM6PR04MB4521.namprd04.prod.outlook.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

On 5/16/19 11:51 AM, Christoph Hellwig wrote:
> We already have a proper stub if lightnvm is not enabled, so don't bother
> with the ifdef.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/host/core.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index eb1c2c349014..7f72d57efc27 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1395,10 +1395,8 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned cmd, unsigned long arg)
>  	case NVME_IOCTL_SUBMIT_IO:
>  		return nvme_submit_io(ns, (void __user *)arg);
>  	default:
> -#ifdef CONFIG_NVM
>  		if (ns->ndev)
>  			return nvme_nvm_ioctl(ns, cmd, arg);
> -#endif
>  		if (is_sed_ioctl(cmd))
>  			return sed_ioctl(ns->ctrl->opal_dev, cmd,
>  					 (void __user *) arg);
