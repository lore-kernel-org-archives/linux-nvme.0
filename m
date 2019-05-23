From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 23 May 2019 10:21:46 +0300
Subject: [PATCH] nvme-rdma: Fix a NULL deref when lesser io queues are
 allocated.
In-Reply-To: <2936d0e0de627fce13f78fca2ef93960aab0d929.1558534119.git.nirranjan@chelsio.com>
References: <2936d0e0de627fce13f78fca2ef93960aab0d929.1558534119.git.nirranjan@chelsio.com>
Message-ID: <bf05c7f8-7a97-5e67-3476-b92c698a23a9@mellanox.com>


On 5/23/2019 7:51 AM, Nirranjan Kirubaharan wrote:
> Return error -ENOMEM when nvmf target allocates lesser
> io queues than the number of io queues requested by nvmf
> initiator.

why can't we live with lesser queues ?

I can demand 64K queues and the target might return 4 and it's fine for 
functionality.

where is the NULL that you see ?


>
> Signed-off-by: Nirranjan Kirubaharan <nirranjan at chelsio.com>
> Reviewed-by: Potnuri Bharat Teja <bharat at chelsio.com>
> ---
>   drivers/nvme/host/rdma.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index f383146e7d0f..187007d136cc 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -641,7 +641,7 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
>   {
>   	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
>   	struct ib_device *ibdev = ctrl->device->dev;
> -	unsigned int nr_io_queues;
> +	unsigned int nr_io_queues, nr_req_queues;
>   	int i, ret;
>   
>   	nr_io_queues = min(opts->nr_io_queues, num_online_cpus());
> @@ -670,9 +670,16 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
>   		nr_io_queues += ctrl->io_queues[HCTX_TYPE_POLL];
>   	}
>   
> +	nr_req_queues = nr_io_queues;
>   	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
>   	if (ret)
>   		return ret;
> +	if (nr_io_queues < nr_req_queues) {
> +		dev_err(ctrl->ctrl.device,
> +			"alloc queues %u < req no of queues %u",
> +			nr_io_queues, nr_req_queues);
> +		return -ENOMEM;
> +	}
>   
>   	ctrl->ctrl.queue_count = nr_io_queues + 1;
>   	if (ctrl->ctrl.queue_count < 2)
