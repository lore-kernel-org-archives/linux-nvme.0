From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 9 Nov 2017 13:09:10 +0200
Subject: [PATCH 1/1] nvme-rdma: Fix memory leak during queue allocation
In-Reply-To: <2d6e460f-2310-bb06-3d1c-f2ecdc4b2dc7@grimberg.me>
References: <1510146032-25434-1-git-send-email-maxg@mellanox.com>
 <2d6e460f-2310-bb06-3d1c-f2ecdc4b2dc7@grimberg.me>
Message-ID: <cb2271d1-5af1-7b23-fac0-9d0139454cee@mellanox.com>



On 11/9/2017 1:02 PM, Sagi Grimberg wrote:
> 
>> In case nvme_rdma_wait_for_cm timeout expires before we get
>> an established or rejected event (rdma_connect succeeded) from
>> rdma_cm, we end up with leaking the ib resources for dedicated
>> queue.
>> This scenario can easily reproduced using traffic test during port
>> toggling.
>>
>> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
>> ---
>> ? drivers/nvme/host/rdma.c | 5 ++++-
>> ? 1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>> index 0ebb539..fcb278a 100644
>> --- a/drivers/nvme/host/rdma.c
>> +++ b/drivers/nvme/host/rdma.c
>> @@ -545,13 +545,16 @@ static int nvme_rdma_alloc_queue(struct 
>> nvme_rdma_ctrl *ctrl,
>> ????? if (ret) {
>> ????????? dev_info(ctrl->ctrl.device,
>> ????????????? "rdma_resolve_addr wait failed (%d).\n", ret);
> 
> Are you rebased? this message have changed I think.

I'm working on the main master. Should I work on top of nvme-4.15 ? from 
what I saw few days ago, it's wasn't rebased on top of 4.14-rc8

> 
>> -??????? goto out_destroy_cm_id;
>> +??????? goto out_destroy_queue_ib;
>> ????? }
>> ????? clear_bit(NVME_RDMA_Q_DELETING, &queue->flags);
>> ????? return 0;
>> +out_destroy_queue_ib:
>> +??? if (ret == -ETIMEDOUT)
>> +??????? nvme_rdma_destroy_queue_ib(queue);
> 
> This does not look safe to me. What protects that nvme_rdma_cm_handler
> will not destroy the ib queue as well? I think we need to destroy the
> cm_id first (guarantee that we will never handle other cma events)
> and only then destroy the ib queue if needed.

You mean we need to destroy cm_id always before destroying ib queue ?
