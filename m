From: kenneth.heitke@intel.com (Heitke, Kenneth)
Date: Wed, 10 Apr 2019 10:52:27 -0600
Subject: [PATCH RFC 5/6] nvme-fc: use flag NVME_ADMIN_QID for admin queue
In-Reply-To: <20190410080035.82529-6-yuyufen@huawei.com>
References: <20190410080035.82529-1-yuyufen@huawei.com>
 <20190410080035.82529-6-yuyufen@huawei.com>
Message-ID: <b6a6ff2b-7d3b-7d35-ccb8-dbc7f9b3e39b@intel.com>



On 4/10/2019 2:00 AM, Yufen Yu wrote:
> Signed-off-by: Yufen Yu <yuyufen at huawei.com>
> ---
>   drivers/nvme/host/fc.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index f3b9d91ba0df..25388e61098d 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -1767,7 +1767,7 @@ nvme_fc_init_aen_ops(struct nvme_fc_ctrl *ctrl)
>   
>   		cmdiu = &aen_op->cmd_iu;
>   		sqe = &cmdiu->sqe;
> -		ret = __nvme_fc_init_request(ctrl, &ctrl->queues[0],
> +		ret = __nvme_fc_init_request(ctrl, &ctrl->queues[NVME_ADMIN_QID],

This line is now over 80 characters so you'll need to reformat it

>   				aen_op, (struct request *)NULL,
>   				(NVME_AQ_BLK_MQ_DEPTH + i));
>   		if (ret) {
> @@ -2601,12 +2601,12 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>   	 * Create the admin queue
>   	 */
>   
> -	ret = __nvme_fc_create_hw_queue(ctrl, &ctrl->queues[0], 0,
> +	ret = __nvme_fc_create_hw_queue(ctrl, &ctrl->queues[NVME_ADMIN_QID], 0,
>   				NVME_AQ_DEPTH);
>   	if (ret)
>   		goto out_free_queue;
>   
> -	ret = nvme_fc_connect_admin_queue(ctrl, &ctrl->queues[0],
> +	ret = nvme_fc_connect_admin_queue(ctrl, &ctrl->queues[NVME_ADMIN_QID],
>   				NVME_AQ_DEPTH, (NVME_AQ_DEPTH / 4));
>   	if (ret)
>   		goto out_delete_hw_queue;
> @@ -2617,7 +2617,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>   	if (ret)
>   		goto out_disconnect_admin_queue;
>   
> -	set_bit(NVME_FC_Q_LIVE, &ctrl->queues[0].flags);
> +	set_bit(NVME_FC_Q_LIVE, &ctrl->queues[NVME_ADMIN_QID].flags);
>   
>   	/*
>   	 * Check controller capabilities
> @@ -2707,9 +2707,9 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>   	/* send a Disconnect(association) LS to fc-nvme target */
>   	nvme_fc_xmt_disconnect_assoc(ctrl);
>   out_delete_hw_queue:
> -	__nvme_fc_delete_hw_queue(ctrl, &ctrl->queues[0], 0);
> +	__nvme_fc_delete_hw_queue(ctrl, &ctrl->queues[NVME_ADMIN_QID], 0);
>   out_free_queue:
> -	nvme_fc_free_queue(&ctrl->queues[0]);
> +	nvme_fc_free_queue(&ctrl->queues[NVME_ADMIN_QID]);
>   	ctrl->assoc_active = false;
>   	nvme_fc_ctlr_inactive_on_rport(ctrl);
>   
> @@ -2800,8 +2800,8 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
>   		nvme_fc_free_io_queues(ctrl);
>   	}
>   
> -	__nvme_fc_delete_hw_queue(ctrl, &ctrl->queues[0], 0);
> -	nvme_fc_free_queue(&ctrl->queues[0]);
> +	__nvme_fc_delete_hw_queue(ctrl, &ctrl->queues[NVME_ADMIN_QID], 0);
> +	nvme_fc_free_queue(&ctrl->queues[NVME_ADMIN_QID]);
>   
>   	/* re-enable the admin_q so anything new can fast fail */
>   	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
> 
