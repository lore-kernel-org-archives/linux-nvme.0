From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu, 27 Jun 2019 05:23:11 +0900
Subject: [PATCH -next] nvme-pci: Make nvme_dev_pm_ops static
In-Reply-To: <20190626020902.38240-1-yuehaibing@huawei.com>
References: <20190626020902.38240-1-yuehaibing@huawei.com>
Message-ID: <20190626202311.GB4934@minwooim-desktop>

On 19-06-26 10:09:02, YueHaibing wrote:
> Fix sparse warning:
> 
> drivers/nvme/host/pci.c:2926:25: warning:
>  symbol 'nvme_dev_pm_ops' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci at huawei.com>
> Signed-off-by: YueHaibing <yuehaibing at huawei.com>
> ---
>  drivers/nvme/host/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 1893520..f500133 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2923,7 +2923,7 @@ static int nvme_simple_resume(struct device *dev)
>  	return 0;
>  }
>  
> -const struct dev_pm_ops nvme_dev_pm_ops = {
> +static const struct dev_pm_ops nvme_dev_pm_ops = {
>  	.suspend	= nvme_suspend,
>  	.resume		= nvme_resume,
>  	.freeze		= nvme_simple_suspend,

IMHO, it should be in static.

Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>
