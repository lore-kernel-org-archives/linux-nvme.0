From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 19 Jun 2018 15:49:25 +0300
Subject: [PATCH resend 2/2] nvme: start keep alive timer when enabling the
 controller
In-Reply-To: <20180619123850.25659-2-sagi@grimberg.me>
References: <20180619123850.25659-1-sagi@grimberg.me>
 <20180619123850.25659-2-sagi@grimberg.me>
Message-ID: <99c7c07f-efca-e1e2-d163-043701b0d001@mellanox.com>



On 6/19/2018 3:38 PM, Sagi Grimberg wrote:
> From: Max Gurtuvoy <maxg at mellanox.com>
> 
> We start the keep alive timer after all the I/O queues were
> created, this might be too late as the controller might have
> start its keep alive timer when it was enabled. Hence, start
> it right after controller enable was completed.
> 
> We stop the keep alive in nvme_stop_ctrl as its before the
> disable/shutdown and its independent of the transport connectivity.
> 
> Suggested-by: Max Gurtuvoy <maxg at mellanox.com>
> Suggested-by: James Smart <james.smart at broadcom.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/core.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3ba4232d114e..8673b7816e9a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1761,7 +1761,14 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap)
>   	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
>   	if (ret)
>   		return ret;
> -	return nvme_wait_ready(ctrl, cap, true);
> +
> +	ret = nvme_wait_ready(ctrl, cap, true);
> +	if (ret)
> +		return ret;
> +
> +	nvme_start_keep_alive(ctrl);
> +
> +	return 0;
>   }
>   EXPORT_SYMBOL_GPL(nvme_enable_ctrl);

We have an issue here with stopping the keep-alive in error flows. This 
issue was solved in my V1 suggestion. There I've tried to make it 
symetrical.
Can we re-think about start/stop keep-alive during configure/destroy 
admin queue ? or look for other solution ?
