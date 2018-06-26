From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 26 Jun 2018 15:10:36 +0300
Subject: [PATCH 1/1] nvmet-rdma: Add error flow for post_recv failures
In-Reply-To: <97ab7146-0b1b-5a3d-2eac-7a186b625cd5@grimberg.me>
References: <1523885152-20800-1-git-send-email-maxg@mellanox.com>
 <97ab7146-0b1b-5a3d-2eac-7a186b625cd5@grimberg.me>
Message-ID: <850aa212-81f1-135a-2684-d1e3c3afd0c0@mellanox.com>



On 6/26/2018 1:56 PM, Sagi Grimberg wrote:
> 
>> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
>> ---
>> ? drivers/nvme/target/rdma.c | 25 +++++++++++++++++++++----
>> ? 1 file changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
>> index 52e0c5d..f0c07d0 100644
>> --- a/drivers/nvme/target/rdma.c
>> +++ b/drivers/nvme/target/rdma.c
>> @@ -487,7 +487,11 @@ static void nvmet_rdma_queue_response(struct 
>> nvmet_req *req)
>> ????? else
>> ????????? first_wr = &rsp->send_wr;
>> -??? nvmet_rdma_post_recv(rsp->queue->dev, rsp->cmd);
>> +??? if (unlikely(nvmet_rdma_post_recv(rsp->queue->dev, rsp->cmd))) {
>> +??????? pr_err("post_recv cmd failed\n");
>> +??????? nvmet_rdma_release_rsp(rsp);
>> +??????? return;
>> +??? }
> 
> Why release the response and not send the completion? if we fail 
> post_send we will do this (as we should).

I guess that if a post_recv operation will fail, also the post_send will 
fail so I don't see a reason to continue in this case.
> 
>> ????? ib_dma_sync_single_for_device(rsp->queue->dev->device,
>> ????????? rsp->send_sge.addr, rsp->send_sge.length,
>> @@ -765,11 +769,18 @@ static int nvmet_rdma_init_srq(struct 
>> nvmet_rdma_device *ndev)
>> ????? ndev->srq = srq;
>> ????? ndev->srq_size = srq_size;
>> -??? for (i = 0; i < srq_size; i++)
>> -??????? nvmet_rdma_post_recv(ndev, &ndev->srq_cmds[i]);
>> +??? for (i = 0; i < srq_size; i++) {
>> +??????? ret = nvmet_rdma_post_recv(ndev, &ndev->srq_cmds[i]);
>> +??????? if (ret) {
>> +??????????? pr_err("initial post_recv failed on SRQ 0x%p\n", srq);
> 
> Maybe move all the error logging into nvmet_rdma_post_recv instead of
> the call sites?

I guess we can do this.
