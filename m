From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Tue, 23 Jan 2018 10:15:28 +0800
Subject: [PATCH 2/5] nvme: Ending failed unstarted requests
In-Reply-To: <20180122215630.13697-2-keith.busch@intel.com>
References: <20180122215630.13697-1-keith.busch@intel.com>
 <20180122215630.13697-2-keith.busch@intel.com>
Message-ID: <7969da07-a8f5-2653-614e-f930f1d32f16@oracle.com>

Hi Keith


On 01/23/2018 05:56 AM, Keith Busch wrote:
> This patch provides new nvme driver APIs for directly ending unstarted
> requests when they need to be failed. Previously, drivers needed to
> temporarily quiesce request queues while setting up the IO path to take on
> the responsibilty of error handling, then restart those queues. Handling
> these errors should be done directly in the error handling path, freeing
> up the IO path to not concern itself with such failure cases.

Yes, we indeed need to ensure the entered requests to be drained after nvme_dev_disable
returns for shutdown case.

> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/nvme/host/core.c | 44 +++++++++++++++++++++++++++++++++++---------
>  drivers/nvme/host/nvme.h |  4 ++++
>  drivers/nvme/host/pci.c  |  4 ++--
>  drivers/nvme/host/rdma.c |  8 +++-----
>  4 files changed, 44 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index b9cf2bce2132..ae4349a4f3a8 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -246,6 +246,17 @@ static void nvme_cancel_request(struct request *req, void *data, bool reserved)
>  
>  }
>  
> +static void nvme_end_unstarted_request(struct request *req, void *data,
> +				       bool reserved)
> +{
> +	if (blk_mq_request_started(req))
> +		return;
> +
> +	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
> +				"Ending I/O %d", req->tag);
> +	blk_mq_end_request(req, BLK_STS_IOERR);
> +}
> +

This unstarted requests have not been dequeued from the blk-mq queue.
We cannot end them directly.

Thanks
Jianchao
