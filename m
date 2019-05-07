From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue, 7 May 2019 17:41:51 +0000
Subject: [PATCH] nvme-pci: mark expected switch fall-through
References: <20190507142300.GA25717@embeddedor>
Message-ID: <SN6PR04MB4527B0A6917F74B5C241FD0F86310@SN6PR04MB4527.namprd04.prod.outlook.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

On 5/7/19 7:23 AM, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
>
> This patch fixes the following warning:
>
> drivers/nvme/host/pci.c: In function ?nvme_timeout?:
> drivers/nvme/host/pci.c:1298:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    shutdown = true;
>    ~~~~~~~~~^~~~~~
> drivers/nvme/host/pci.c:1299:2: note: here
>   case NVME_CTRL_CONNECTING:
>   ^~~~
>
> Warning level 3 was used: -Wimplicit-fallthrough=3
>
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo at embeddedor.com>
> ---
>  drivers/nvme/host/pci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 3e4fb891a95a..a12f992868c9 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1296,6 +1296,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>  	switch (dev->ctrl.state) {
>  	case NVME_CTRL_DELETING:
>  		shutdown = true;
> +		/* fall through */
>  	case NVME_CTRL_CONNECTING:
>  	case NVME_CTRL_RESETTING:
>  		dev_warn_ratelimited(dev->ctrl.device,
