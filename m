From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sat, 8 Jun 2019 19:40:35 +0000
Subject: [PATCH] nvme-pci: put error value when state change fails
References: <20190608183520.25926-1-minwoo.im.dev@gmail.com>
Message-ID: <BYAPR04MB5749D11F63CCEC12B091747786110@BYAPR04MB5749.namprd04.prod.outlook.com>

Looks good to me.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

On 06/08/2019 11:35 AM, Minwoo Im wrote:
> If state change to NVME_CTRL_CONNECTING fails, the dmesg is going to be
> like:
>    [  293.689160] nvme nvme0: failed to mark controller CONNECTING
>    [  293.689160] nvme nvme0: Removing after probe failure status: 0
>
> Even it prints the first line to indicate the situation, the second line
> is not proper because the status is 0 which means normally success of
> the previous operation.
>
> This patch makes it indicate the proper error value when it fails.
>    [   25.932367] nvme nvme0: failed to mark controller CONNECTING
>    [   25.932369] nvme nvme0: Removing after probe failure status: -16
>
> This situation is able to be easily reproduced by:
>    root at target:~# rmmod nvme && modprobe nvme && rmmod nvme
>
> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
> ---
>   drivers/nvme/host/pci.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 5c051a8470d4..fa0a1983d6a5 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2524,6 +2524,7 @@ static void nvme_reset_work(struct work_struct *work)
>   	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_CONNECTING)) {
>   		dev_warn(dev->ctrl.device,
>   			"failed to mark controller CONNECTING\n");
> +		result = -EBUSY;
>   		goto out;
>   	}
>
>
