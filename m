From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 16 May 2018 15:18:47 +0300
Subject: [PATCH V2] nvme-rdma: fix double free in nvme_rdma_free_queue
In-Reply-To: <1525945328-1908-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1525945328-1908-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <c32eef8a-ae1e-ce7e-ee39-eee60192e517@mellanox.com>

Hi Jianchao,

On 5/10/2018 12:42 PM, Jianchao Wang wrote:
> BUG: KASAN: double-free or invalid-free in nvme_rdma_free_queue+0xf6/0x110 [nvme_rdma]
> Workqueue: nvme-reset-wq nvme_rdma_reset_ctrl_work [nvme_rdma]
> Call Trace:
>   dump_stack+0x91/0xeb
>   print_address_description+0x6b/0x290
>   kasan_report_invalid_free+0x55/0x80
>   __kasan_slab_free+0x176/0x190
>   kfree+0xeb/0x310
>   nvme_rdma_free_queue+0xf6/0x110 [nvme_rdma]
>   nvme_rdma_configure_admin_queue+0x1a3/0x4d0 [nvme_rdma]
>   nvme_rdma_reset_ctrl_work+0x4e/0xd0 [nvme_rdma]
>   process_one_work+0x3ca/0xaa0
>   worker_thread+0x4e2/0x6c0
>   kthread+0x18d/0x1e0
>   ret_from_fork+0x24/0x30
> 
> The double free is on ctrl->async_event_sqe.
> If any case fails before ctrl->async_event_sqe is allocated in
> nvme_rdma_configure_admin_queue, nvme_rdma_free_queue will be
> invoked. However, at the moment, the ctrl->async_event_sqe has
> not been allocated because it has been freed in
> nvme_rdma_reset_ctrl_work
>    -> nvme_rdma_shutdown_ctrl
>      ->nvme_rdma_destroy_admin_queue
>        -> nvme_rdma_free_queue
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
> ---
> 
> V2:
> handle it in nvme_rdma_free_queue and add some comment to explain it.

I don't know exactly what Christoph meant but IMO the best place to 
allocate it is in nvme_rdma_alloc_queue just before calling

"set_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags);"

then you will never get to double free since we clear the 
NVME_RDMA_Q_ALLOCATED bit in the beginning of nvme_rdma_free_queue.

> 
>   drivers/nvme/host/rdma.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 966e0dd..fa5cf87 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -561,9 +561,18 @@ static void nvme_rdma_free_queue(struct nvme_rdma_queue *queue)
>   		return;
>   
>   	if (nvme_rdma_queue_idx(queue) == 0) {
> -		nvme_rdma_free_qe(queue->device->dev,
> -			&queue->ctrl->async_event_sqe,
> -			sizeof(struct nvme_command), DMA_TO_DEVICE);
> +		/*
> +		 * async_event_sqe is not allocated in nvme_rdma_alloc_queue.
> +		 * so there are cases where NVME_RDMA_Q_ALLOCATED is set, but
> +		 * async_event_sqe is not allocated. To avoid double free, set
> +		 * async_event_sqe.data to NULL to indicate it has been freed.
> +		 */
> +		if (queue->ctrl->async_event_sqe.data) {
> +			nvme_rdma_free_qe(queue->device->dev,
> +				&queue->ctrl->async_event_sqe,
> +				sizeof(struct nvme_command), DMA_TO_DEVICE);
> +			queue->ctrl->async_event_sqe.data = NULL;
> +		}
>   	}
>   
>   	nvme_rdma_destroy_queue_ib(queue);
> 


-Max.
