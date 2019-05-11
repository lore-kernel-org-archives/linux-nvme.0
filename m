From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sat, 11 May 2019 21:50:12 +0000
Subject: [PATCH 2/2] nvme-fabrics: Remove unused argument
References: <20190511134255.6790-1-minwoo.im.dev@gmail.com>
 <20190511134255.6790-3-minwoo.im.dev@gmail.com>
Message-ID: <SN6PR04MB4527A361940ECE60AFE846E5860D0@SN6PR04MB4527.namprd04.prod.outlook.com>

Variable "count" use removed by  any commit ?

Or it is been like that since the introduction of this function ?

On 5/11/19 6:43 AM, Minwoo Im wrote:
> The variable 'count' is not currently used by nvmf_create_ctrl(), so
> remove it.
>
> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
> ---
>  drivers/nvme/host/fabrics.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 592d1e61ef7e..5838f7cd53ac 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -978,7 +978,7 @@ EXPORT_SYMBOL_GPL(nvmf_free_options);
>  				 NVMF_OPT_DISABLE_SQFLOW)
>  
>  static struct nvme_ctrl *
> -nvmf_create_ctrl(struct device *dev, const char *buf, size_t count)
> +nvmf_create_ctrl(struct device *dev, const char *buf)
>  {
>  	struct nvmf_ctrl_options *opts;
>  	struct nvmf_transport_ops *ops;
> @@ -1073,7 +1073,7 @@ static ssize_t nvmf_dev_write(struct file *file, const char __user *ubuf,
>  		goto out_unlock;
>  	}
>  
> -	ctrl = nvmf_create_ctrl(nvmf_device, buf, count);
> +	ctrl = nvmf_create_ctrl(nvmf_device, buf);
>  	if (IS_ERR(ctrl)) {
>  		ret = PTR_ERR(ctrl);
>  		goto out_unlock;
