From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 24 Jun 2018 19:19:16 +0300
Subject: [Suspected-Phishing]Re: [PATCH 2/7] nvme-rdma: fix possible free
 non-allocated async event buffer
In-Reply-To: <af45efbc-f037-241b-9fc2-e96e0ff157a8@grimberg.me>
References: <20180619123415.25077-1-sagi@grimberg.me>
 <20180619123415.25077-3-sagi@grimberg.me> <20180620083159.GB3284@lst.de>
 <479f91be-2a8c-ae01-fee1-71fa2e18372f@mellanox.com>
 <91bc7b1a-6fb1-e1e0-3437-dc8e46cc6d58@mellanox.com>
 <af45efbc-f037-241b-9fc2-e96e0ff157a8@grimberg.me>
Message-ID: <0ab74663-52a6-09a9-685f-35053a3f58dc@mellanox.com>



On 6/24/2018 7:00 PM, Sagi Grimberg wrote:
> 
>> this fix still doesn't fix the issue that V1 from Israel did.
> 
> This fixes the issue that was reported (nvme_rdma_free_queue frees
> unallocated async_event_sqe).
> 
>> we still can call nvme_rdma_destroy_admin_queue few times (as I 
>> mentioned nvme_rdma_free_queue is safe by NVME_RDMA_Q_ALLOCATED bit 
>> but nvme_rdma_destroy_admin_queue isn't).
> 
> ugh... yes this is not enough to avoid the double free if
> reset/reconnect calls nvme_delete_ctrl.
> 
>> I added this check but I think this is not enough since things can run 
>> concurrently (I still need to make some testing and review):
> 
> The destroy routines are serialized by the work flush/cancel so it
> should be fine.

Yup, I agree.

> 
>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>> index 5194568..e99ff80 100644
>> --- a/drivers/nvme/host/rdma.c
>> +++ b/drivers/nvme/host/rdma.c
>> @@ -168,8 +168,11 @@ static inline size_t 
>> nvme_rdma_inline_data_size(struct nvme_rdma_queue *queue)
>> ??static void nvme_rdma_free_qe(struct ib_device *ibdev, struct 
>> nvme_rdma_qe *qe,
>> ???????????????? size_t capsule_size, enum dma_data_direction dir)
>> ??{
>> -?????? ib_dma_unmap_single(ibdev, qe->dma, capsule_size, dir);
>> -?????? kfree(qe->data);
>> +?????? if (qe->data) {
>> +?????????????? ib_dma_unmap_single(ibdev, qe->dma, capsule_size, dir);
>> +?????????????? kfree(qe->data);
>> +?????????????? qe->data = NULL;
>> +?????? }
>> ??}
> 
> I'd prefer to keep this check to the async event buffer:
> -- 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 9f5fc7b7fd7f..69c9b7bc0d5b 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -732,8 +732,11 @@ static void nvme_rdma_destroy_admin_queue(struct 
> nvme_rdma_ctrl *ctrl,
>  ??????????????? blk_cleanup_queue(ctrl->ctrl.admin_q);
>  ??????????????? nvme_rdma_free_tagset(&ctrl->ctrl, 
> ctrl->ctrl.admin_tagset);
>  ??????? }
> -?????? nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
> -?????????????? sizeof(struct nvme_command), DMA_TO_DEVICE);
> +?????? if (ctrl->async_event_sqe.data) {
> +?????????????? nvme_rdma_free_qe(ctrl->device->dev, 
> &ctrl->async_event_sqe,
> +?????????????????????? sizeof(struct nvme_command), DMA_TO_DEVICE);
> +?????????????????????? ctrl->async_event_sqe.data = NULL;
> +?????? }
>  ??????? nvme_rdma_free_queue(&ctrl->queues[0]);
>  ?}
> -- 
> 
> Does this make the issue go away Max?

Yes, The issue is with async_event_sqe.
You can add
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
Tested-by: Max Gurtovoy <maxg at mellanox.com>

to the fix.

-Max.
