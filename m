From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 25 Oct 2018 12:43:19 -0700
Subject: [PATCH 1/2] nvmet-rdma: Avoid that
 nvmet_rdma_release_queue_work() triggers a lockdep complaint
In-Reply-To: <20181025151940.388-2-bvanassche@acm.org>
References: <20181025151940.388-1-bvanassche@acm.org>
 <20181025151940.388-2-bvanassche@acm.org>
Message-ID: <a1313cb7-126c-156d-7fff-1d1e061115d5@grimberg.me>


> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index bd265aceb90c..b3ee64fd66c5 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -1268,7 +1268,7 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
>   
>   	if (queue->host_qid == 0) {
>   		/* Let inflight controller teardown complete */
> -		flush_workqueue(nvmet_rdma_delete_wq);
> +		flush_work(&queue->release_work);

That is the opposite of what is attempted to be achieved here. The queue
connect is trying to wait for other queue deletion to complete.
