From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 26 Jun 2018 15:29:07 +0300
Subject: [PATCH 1/1] nvmet-rdma: Add error flow for post_recv failures
In-Reply-To: <850aa212-81f1-135a-2684-d1e3c3afd0c0@mellanox.com>
References: <1523885152-20800-1-git-send-email-maxg@mellanox.com>
 <97ab7146-0b1b-5a3d-2eac-7a186b625cd5@grimberg.me>
 <850aa212-81f1-135a-2684-d1e3c3afd0c0@mellanox.com>
Message-ID: <353f3e28-377e-c7ed-9b0d-e936120ff2a2@grimberg.me>


>>> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
>>> index 52e0c5d..f0c07d0 100644
>>> --- a/drivers/nvme/target/rdma.c
>>> +++ b/drivers/nvme/target/rdma.c
>>> @@ -487,7 +487,11 @@ static void nvmet_rdma_queue_response(struct 
>>> nvmet_req *req)
>>> ????? else
>>> ????????? first_wr = &rsp->send_wr;
>>> -??? nvmet_rdma_post_recv(rsp->queue->dev, rsp->cmd);
>>> +??? if (unlikely(nvmet_rdma_post_recv(rsp->queue->dev, rsp->cmd))) {
>>> +??????? pr_err("post_recv cmd failed\n");
>>> +??????? nvmet_rdma_release_rsp(rsp);
>>> +??????? return;
>>> +??? }
>>
>> Why release the response and not send the completion? if we fail 
>> post_send we will do this (as we should).
> 
> I guess that if a post_recv operation will fail, also the post_send will 
> fail so I don't see a reason to continue in this case.

Where is that stated that any ib_post_recv/ib_post_srq failure means
that a subsequent ib_post_send will fail as well?
