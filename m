From: swise@opengridcomputing.com (Steve Wise)
Date: Mon, 27 Aug 2018 13:24:54 -0500
Subject: Crash in nvmet_req_init() - null req->rsp pointer
In-Reply-To: <31a08853-e2a7-709a-9251-e6c64fda22dd@grimberg.me>
References: <1eb5a94a-07ed-1c2a-47fe-cc9a4bf32466@opengridcomputing.com>
 <d35d93e6-2e7b-a681-039b-75edaea7a9a2@opengridcomputing.com>
 <31a08853-e2a7-709a-9251-e6c64fda22dd@grimberg.me>
Message-ID: <a165480b-7fcd-d208-8ce0-a1d7cdab24e9@opengridcomputing.com>



On 8/20/2018 3:47 PM, Sagi Grimberg wrote:
> 
>> Resending in plain text...
>>
>> ----
>>
>> Hey guys,
>>
>> I'm debugging a nvmet_rdma crash on the linux-4.14.52 stable kernel
>> code.? Under heavy load, including 80 nvmf devices, after 13 hours of
>> running, I see an Oops [1] when the target is processing a new ingress
>> nvme command.? It crashes in nvmet_req_init() because req->rsp is NULL:
>>
>> ?? 493?? bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
>> ?? 494?????????????????? struct nvmet_sq *sq, struct nvmet_fabrics_ops
>> *ops)
>> ?? 495?? {
>> ?? 496?????????? u8 flags = req->cmd->common.flags;
>> ?? 497?????????? u16 status;
>> ?? 498
>> ?? 499?????????? req->cq = cq;
>> ?? 500?????????? req->sq = sq;
>> ?? 501?????????? req->ops = ops;
>> ?? 502?????????? req->sg = NULL;
>> ?? 503?????????? req->sg_cnt = 0;
>> ?? 504?????????? req->rsp->status = 0; <-- HERE
>>
>> The? nvme command opcode is nvme_cmd_write.? The nvmet_rdma_queue state
>> is NVMET_RDMA_Q_LIVE.? The nvmet_req looks valid [2].? IE not garbage.
>> But it seems very bad that req->rsp is NULL! :)
>>
>> Any thoughts?? I didn't see anything like this in recent nvmf fixes...
> 
> Is it possible that you ran out of rsps and got a corrupted rsp?
> 
> How about trying out this patch to add more information:
> -- 

Hey Sagi, it hits the empty rsp list path often with your debug patch.
I added code to BUG_ON() after 10 times and I have a crash dump I'm
looking at.

Isn't the rsp list supposed to be sized such that it will never be empty
when a new rsp is needed?  I wonder if there is a leak.

Steve.
