From: james.smart@broadcom.com (James Smart)
Date: Thu, 29 Jun 2017 08:11:18 -0700
Subject: [PATCH 4/7] nvme-fc: don't override opts->nr_io_queues
In-Reply-To: <1498734552-14845-5-git-send-email-sagi@grimberg.me>
References: <1498734552-14845-1-git-send-email-sagi@grimberg.me>
 <1498734552-14845-5-git-send-email-sagi@grimberg.me>
Message-ID: <dd00c3ec-cb89-8157-5fca-2fe16e6922c3@broadcom.com>

On 6/29/2017 4:09 AM, Sagi Grimberg wrote:
> Its what the user passed, so its probably a better
> idea to keep it intact. Also, limit the number of
> I/O queues to max online cpus as blk-mq doesnt know
> how to handle more anyhow.
>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/fc.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 2f990d979037..5ee821d9cb75 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2175,17 +2175,19 @@ static int
>   nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
>   {
>   	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
> +	unsigned int nr_io_queues;
>   	int ret;
>   
> -	ret = nvme_set_queue_count(&ctrl->ctrl, &opts->nr_io_queues);
> +	nr_io_queues = min(opts->nr_io_queues, num_online_cpus());

I had assumed the check vs online cpu count was done in fabrics.c - but 
as we're talking about a later reconnect, the cpu count may have 
changed, so this looks good.

however, the snippet obsoletes the "min_t(unsigned int, 
opts->nr_io_queues, lport->ops->max_hw_queues)" that was done in the 
next snippet.

> @@ -2702,7 +2707,6 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
>   	ctrl->ctrl.queue_count = min_t(unsigned int,
>   				opts->nr_io_queues,
>   				lport->ops->max_hw_queues);
> -	opts->nr_io_queues = ctrl->ctrl.queue_count;	/* so opts has valid value */
>   	ctrl->ctrl.queue_count++;	/* +1 for admin queue */
>   
>   	ctrl->ctrl.sqsize = opts->queue_size - 1;

The simple fix is to add the min statement right after the added min for 
online_cpu's - to both the create_io_queues and the reinit_io_queues.

The longer fix is to add some multiplexing code to go from blk-mq hw 
queue to fc hw queue.

-- james
