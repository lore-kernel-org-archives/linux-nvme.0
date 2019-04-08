From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 8 Apr 2019 19:26:18 +0300
Subject: [PATCH 1/2] nvmet-rdma: remove p2p_client initialization from
 fast-path
In-Reply-To: <6fc5a921-6440-5375-7e21-a000ae98b07d@deltatee.com>
References: <1554737999-26459-1-git-send-email-maxg@mellanox.com>
 <6fc5a921-6440-5375-7e21-a000ae98b07d@deltatee.com>
Message-ID: <d2227a0e-e2a2-e6a1-8f83-c2470bd96371@mellanox.com>


On 4/8/2019 7:04 PM, Logan Gunthorpe wrote:
>
> On 2019-04-08 9:39 a.m., Max Gurtovoy wrote:
>> Initialize it during command allocation.
>
> It would be nice to hear some justification for this change in the
> commit message, but the change itself appears to be fine to me:

well, it's written in the subject and it's pretty small change so there 
is not much to say about it.

Just set this ptr once instead of every IO.

>
> Reviewed-by: Logan Gunthorpe <logang at deltatee.com>
>
>> Cc: Logan Gunthorpe <logang at deltatee.com>
>> Cc: Stephen Bates <sbates at raithlin.com>
>> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
>> ---
>>   drivers/nvme/target/rdma.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
>> index ef893ad..b727521 100644
>> --- a/drivers/nvme/target/rdma.c
>> +++ b/drivers/nvme/target/rdma.c
>> @@ -373,6 +373,7 @@ static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
>>   	if (ib_dma_mapping_error(ndev->device, r->send_sge.addr))
>>   		goto out_free_rsp;
>>   
>> +	r->req.p2p_client = &ndev->device->dev;
>>   	r->send_sge.length = sizeof(*r->req.rsp);
>>   	r->send_sge.lkey = ndev->pd->local_dma_lkey;
>>   
>> @@ -763,8 +764,6 @@ static void nvmet_rdma_handle_command(struct nvmet_rdma_queue *queue,
>>   		cmd->send_sge.addr, cmd->send_sge.length,
>>   		DMA_TO_DEVICE);
>>   
>> -	cmd->req.p2p_client = &queue->dev->device->dev;
>> -
>>   	if (!nvmet_req_init(&cmd->req, &queue->nvme_cq,
>>   			&queue->nvme_sq, &nvmet_rdma_ops))
>>   		return;
>>
