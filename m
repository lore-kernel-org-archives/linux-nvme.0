From: james.smart@broadcom.com (James Smart)
Date: Tue, 25 Jun 2019 09:37:47 -0700
Subject: [PATCH v2] nvme-fc: clean up error messages
In-Reply-To: <20190624221240.25268-1-emilne@redhat.com>
References: <20190624221240.25268-1-emilne@redhat.com>
Message-ID: <14240398-683c-1d1c-f6e8-8fa8692270c2@broadcom.com>



On 6/24/2019 3:12 PM, Ewan D. Milne wrote:
> Some of the error messages are inconsistent, and one of them is wrong
> (i.e. "queue_size 128 > ctrl maxcmd 32, reducing to queue_size").
> Make them more clear and distinguishable for log analysis.
>
> Signed-off-by: Ewan D. Milne <emilne at redhat.com>
> ---
>   drivers/nvme/host/fc.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 9b497d785ed7..ab162c57ddc2 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -1259,7 +1259,7 @@ nvme_fc_connect_admin_queue(struct nvme_fc_ctrl *ctrl,
>   	if (fcret) {
>   		ret = -EBADF;
>   		dev_err(ctrl->dev,
> -			"q %d connect failed: %s\n",
> +			"queue %d connect admin queue failed: %s\n",
>   			queue->qnum, validation_errors[fcret]);
>   	} else {
>   		ctrl->association_id =

Since we're changing them...

how about "queue %d Create Association LS failed: %s"

> @@ -1358,7 +1358,7 @@ nvme_fc_connect_queue(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
>   	if (fcret) {
>   		ret = -EBADF;
>   		dev_err(ctrl->dev,
> -			"q %d connect failed: %s\n",
> +			"queue %d connect queue failed: %s\n",

how about "queue %d Create Connection LS failed: %s"

>   			queue->qnum, validation_errors[fcret]);
>   	} else {
>   		queue->connection_id =
> @@ -1371,7 +1371,7 @@ nvme_fc_connect_queue(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
>   out_no_memory:
>   	if (ret)
>   		dev_err(ctrl->dev,
> -			"queue %d connect command failed (%d).\n",
> +			"queue %d connect queue failed (%d).\n",
>   			queue->qnum, ret);
>   	return ret;
>   }
> @@ -2678,16 +2678,18 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>   		/* warn if maxcmd is lower than queue_size */
>   		dev_warn(ctrl->ctrl.device,
>   			"queue_size %zu > ctrl maxcmd %u, reducing "
> -			"to queue_size\n",
> -			opts->queue_size, ctrl->ctrl.maxcmd);
> +			"queue_size to %u\n",
> +			opts->queue_size, ctrl->ctrl.maxcmd, ctrl->ctrl.maxcmd);
>   		opts->queue_size = ctrl->ctrl.maxcmd;
>   	}
>   
>   	if (opts->queue_size > ctrl->ctrl.sqsize + 1) {
>   		/* warn if sqsize is lower than queue_size */
>   		dev_warn(ctrl->ctrl.device,
> -			"queue_size %zu > ctrl sqsize %u, clamping down\n",
> -			opts->queue_size, ctrl->ctrl.sqsize + 1);
> +			"queue_size %zu > ctrl sqsize %u, reducing "
> +			"queue_size to %u\n",
> +			opts->queue_size, ctrl->ctrl.sqsize + 1,
> +			ctrl->ctrl.sqsize + 1);
>   		opts->queue_size = ctrl->ctrl.sqsize + 1;
>   	}
>   

Given these last two came from a template in the rdma transport - you 
may want to consider using the same wording in all the transports.

-- james
