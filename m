From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 24 Jun 2018 19:07:13 +0300
Subject: [PATCH 4/7] nvme-rdma: unquiesce queues when deleting the
 controller
In-Reply-To: <d739f7bd-a3ee-4d5a-db88-325d7bfc33f1@mellanox.com>
References: <20180619123415.25077-1-sagi@grimberg.me>
 <20180619123415.25077-5-sagi@grimberg.me>
 <d739f7bd-a3ee-4d5a-db88-325d7bfc33f1@mellanox.com>
Message-ID: <bdcfe4d7-494c-7093-0316-5d965b1ece03@grimberg.me>


> On 6/19/2018 3:34 PM, Sagi Grimberg wrote:
>> If the controller is going away, we need to unquiesce the io
>> queues so that all pending request can fail gracefully before
>> moving forward with controller deletion.
>>
>> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
>> ---
>> ? drivers/nvme/host/rdma.c | 6 ++++--
>> ? 1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>> index 15e897ac2506..edf63cd106ff 100644
>> --- a/drivers/nvme/host/rdma.c
>> +++ b/drivers/nvme/host/rdma.c
>> @@ -1741,10 +1741,12 @@ static void nvme_rdma_shutdown_ctrl(struct 
>> nvme_rdma_ctrl *ctrl, bool shutdown)
>> ????????? nvme_rdma_destroy_io_queues(ctrl, shutdown);
>> ????? }
>> -??? if (shutdown)
>> +??? if (shutdown) {
>> +??????? nvme_start_queues(&ctrl->ctrl);
> 
> any reason we unquiesce IO queues after destroying them and unquiesce 
> Admin queue before the destruction ?

The barrier is stop+cancel. But I think that if we remove the
controller completely we'd need to do it before blk_cleanup_queue
as it may block on blk_freze_queue...

Let me try and have another look, and possible send a patch..
