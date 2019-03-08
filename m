From: bvanassche@acm.org (Bart Van Assche)
Date: Fri, 08 Mar 2019 10:15:27 -0800
Subject: [PATCH 4/5] nvme: Fail dead namespace's entered requests
In-Reply-To: <20190308174006.5032-4-keith.busch@intel.com>
References: <20190308174006.5032-1-keith.busch@intel.com>
 <20190308174006.5032-4-keith.busch@intel.com>
Message-ID: <1552068927.45180.30.camel@acm.org>

On Fri, 2019-03-08@10:40 -0700, Keith Busch wrote:
> End the entered requests on a quieced queue directly rather than flush
> them through the low level driver's queue_rq().
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/nvme/host/core.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index cc5d9a83d5af..7095406bb293 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -94,6 +94,13 @@ static void nvme_put_subsystem(struct nvme_subsystem *subsys);
>  static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
>  					   unsigned nsid);
>  
> +static bool nvme_fail_request(struct blk_mq_hw_ctx *hctx, struct request *req,
> +			      void *data, bool reserved)
> +{
> +	blk_mq_end_request(req, BLK_STS_IOERR);
> +	return true;
> +}

Calling blk_mq_end_request() from outside the .queue_rq() or .complete()
callback functions is wrong. Did you perhaps want to call
blk_mq_complete_request()?

Bart.
