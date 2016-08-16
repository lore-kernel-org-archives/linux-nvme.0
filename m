From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 16 Aug 2016 16:17:41 +0300
Subject: [PATCH] nvmet-rdma: Fix use after free
In-Reply-To: <1471353085-6743-1-git-send-email-vincent.stehle@intel.com>
References: <1470230393-23671-1-git-send-email-sagi@grimberg.me>
 <1471353085-6743-1-git-send-email-vincent.stehle@intel.com>
Message-ID: <75d23c63-8ea7-7d76-2b1e-a641e1907e15@grimberg.me>

> Avoid dereferencing the queue pointer in nvmet_rdma_release_queue_work()
> after it has been freed by nvmet_rdma_free_queue().
>
> Fixes: d8f7750a08968b10 ("nvmet-rdma: Correctly handle RDMA device hot removal")
> Signed-off-by: Vincent Stehl? <vincent.stehle at intel.com>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> Cc: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/target/rdma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index b4d6485..5de8d0a 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -978,10 +978,11 @@ static void nvmet_rdma_release_queue_work(struct work_struct *w)
>  		container_of(w, struct nvmet_rdma_queue, release_work);
>  	struct rdma_cm_id *cm_id = queue->cm_id;
>  	struct nvmet_rdma_device *dev = queue->dev;
> +	enum nvmet_rdma_queue_state state = queue->state;
>
>  	nvmet_rdma_free_queue(queue);
>
> -	if (queue->state != NVMET_RDMA_IN_DEVICE_REMOVAL)
> +	if (state != NVMET_RDMA_IN_DEVICE_REMOVAL)
>  		rdma_destroy_id(cm_id);
>
>  	kref_put(&dev->ref, nvmet_rdma_free_dev);
>

Queued for the next round of rc fixes.

Thanks Vincent!
