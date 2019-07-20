From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sat, 20 Jul 2019 21:22:13 +0000
Subject: [PATCH 3/4] nvme: don't pass cap to nvme_disable_ctrl
References: <20190719194546.24229-1-sagi@grimberg.me>
 <20190719194546.24229-4-sagi@grimberg.me>
Message-ID: <BYAPR04MB574973AD83411B2CD72414BB86CA0@BYAPR04MB5749.namprd04.prod.outlook.com>

Looks good to me.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

On 07/19/2019 12:46 PM, Sagi Grimberg wrote:
> All seem to call it with ctrl->cap so no need to pass it
> at all.
>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/core.c | 4 ++--
>   drivers/nvme/host/nvme.h | 2 +-
>   drivers/nvme/host/pci.c  | 4 ++--
>   drivers/nvme/host/rdma.c | 2 +-
>   drivers/nvme/host/tcp.c  | 2 +-
>   5 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index da4182aa16b0..60e924b0b510 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1949,7 +1949,7 @@ static int nvme_wait_ready(struct nvme_ctrl *ctrl, u64 cap, bool enabled)
>    * bits', but doing so may cause the device to complete commands to the
>    * admin queue ... and we don't know what memory that might be pointing at!
>    */
> -int nvme_disable_ctrl(struct nvme_ctrl *ctrl, u64 cap)
> +int nvme_disable_ctrl(struct nvme_ctrl *ctrl)
>   {
>   	int ret;
>
> @@ -1963,7 +1963,7 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl, u64 cap)
>   	if (ctrl->quirks & NVME_QUIRK_DELAY_BEFORE_CHK_RDY)
>   		msleep(NVME_QUIRK_DELAY_AMOUNT);
>
> -	return nvme_wait_ready(ctrl, cap, false);
> +	return nvme_wait_ready(ctrl, ctrl->cap, false);
>   }
>   EXPORT_SYMBOL_GPL(nvme_disable_ctrl);
>
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 716a876119c8..a7f8fccb1f35 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -426,7 +426,7 @@ void nvme_complete_rq(struct request *req);
>   bool nvme_cancel_request(struct request *req, void *data, bool reserved);
>   bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>   		enum nvme_ctrl_state new_state);
> -int nvme_disable_ctrl(struct nvme_ctrl *ctrl, u64 cap);
> +int nvme_disable_ctrl(struct nvme_ctrl *ctrl);
>   int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap);
>   int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl);
>   int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 0f38c1d96d19..f2e74043dc6b 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1403,7 +1403,7 @@ static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
>   	if (shutdown)
>   		nvme_shutdown_ctrl(&dev->ctrl);
>   	else
> -		nvme_disable_ctrl(&dev->ctrl, dev->ctrl.cap);
> +		nvme_disable_ctrl(&dev->ctrl);
>
>   	nvme_poll_irqdisable(nvmeq, -1);
>   }
> @@ -1679,7 +1679,7 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
>   	    (readl(dev->bar + NVME_REG_CSTS) & NVME_CSTS_NSSRO))
>   		writel(NVME_CSTS_NSSRO, dev->bar + NVME_REG_CSTS);
>
> -	result = nvme_disable_ctrl(&dev->ctrl, dev->ctrl.cap);
> +	result = nvme_disable_ctrl(&dev->ctrl);
>   	if (result < 0)
>   		return result;
>
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 8e9f0fd5b01f..8e2094fb5e7e 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1860,7 +1860,7 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
>   	if (shutdown)
>   		nvme_shutdown_ctrl(&ctrl->ctrl);
>   	else
> -		nvme_disable_ctrl(&ctrl->ctrl, ctrl->ctrl.cap);
> +		nvme_disable_ctrl(&ctrl->ctrl);
>   	nvme_rdma_teardown_admin_queue(ctrl, shutdown);
>   }
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index fba80dc61ce1..4a32d5350fc5 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1896,7 +1896,7 @@ static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
>   	if (shutdown)
>   		nvme_shutdown_ctrl(ctrl);
>   	else
> -		nvme_disable_ctrl(ctrl, ctrl->cap);
> +		nvme_disable_ctrl(ctrl);
>   	nvme_tcp_teardown_admin_queue(ctrl, shutdown);
>   }
>
>
