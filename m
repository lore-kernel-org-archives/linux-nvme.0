From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Thu, 20 Oct 2016 08:35:55 -0700
Subject: [PATCH v3 0/11] Fix race conditions related to stopping block
 layer queues
In-Reply-To: <20161020145224.GA2771@localhost.localdomain>
References: <b39eb0e7-1007-eb63-8e7f-9a7f08508379@sandisk.com>
 <20161019222454.GA1215@localhost.localdomain>
 <25418d7a-7e66-3b99-7532-669f7ebd58a6@sandisk.com>
 <20161020145224.GA2771@localhost.localdomain>
Message-ID: <91d7aade-bca8-8772-f1e0-94980b18f872@sandisk.com>

On 10/20/2016 07:52 AM, Keith Busch wrote:
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ccd9cc5..078530c 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -201,7 +201,7 @@ static struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk)
>
>  void nvme_requeue_req(struct request *req)
>  {
> -	blk_mq_requeue_request(req, true);
> +	blk_mq_requeue_request(req, !blk_mq_queue_stopped(req->q));
>  }
>  EXPORT_SYMBOL_GPL(nvme_requeue_req);

Hello Keith,

What I had missed while I was preparing my patch series is that the NVMe 
driver, unlike the dm driver, can call blk_mq_requeue_request() on a 
stopped queue. So the above patch is needed to keep the current 
semantics of the NVMe code. I will merge this patch in my patch series.

Thanks,

Bart.
