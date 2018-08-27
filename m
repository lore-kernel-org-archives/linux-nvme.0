From: swise@opengridcomputing.com (Steve Wise)
Date: Mon, 27 Aug 2018 15:29:48 -0500
Subject: Crash in nvmet_req_init() - null req->rsp pointer
In-Reply-To: <a165480b-7fcd-d208-8ce0-a1d7cdab24e9@opengridcomputing.com>
References: <1eb5a94a-07ed-1c2a-47fe-cc9a4bf32466@opengridcomputing.com>
 <d35d93e6-2e7b-a681-039b-75edaea7a9a2@opengridcomputing.com>
 <31a08853-e2a7-709a-9251-e6c64fda22dd@grimberg.me>
 <a165480b-7fcd-d208-8ce0-a1d7cdab24e9@opengridcomputing.com>
Message-ID: <0bcbcb2e-0b01-57ef-0b9c-9ac3e56322cb@opengridcomputing.com>



On 8/27/2018 1:24 PM, Steve Wise wrote:
> 
> 
> On 8/20/2018 3:47 PM, Sagi Grimberg wrote:
>>
>>> Resending in plain text...
>>>
>>> ----
>>>
>>> Hey guys,
>>>
>>> I'm debugging a nvmet_rdma crash on the linux-4.14.52 stable kernel
>>> code.? Under heavy load, including 80 nvmf devices, after 13 hours of
>>> running, I see an Oops [1] when the target is processing a new ingress
>>> nvme command.? It crashes in nvmet_req_init() because req->rsp is NULL:
>>>
>>> ?? 493?? bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
>>> ?? 494?????????????????? struct nvmet_sq *sq, struct nvmet_fabrics_ops
>>> *ops)
>>> ?? 495?? {
>>> ?? 496?????????? u8 flags = req->cmd->common.flags;
>>> ?? 497?????????? u16 status;
>>> ?? 498
>>> ?? 499?????????? req->cq = cq;
>>> ?? 500?????????? req->sq = sq;
>>> ?? 501?????????? req->ops = ops;
>>> ?? 502?????????? req->sg = NULL;
>>> ?? 503?????????? req->sg_cnt = 0;
>>> ?? 504?????????? req->rsp->status = 0; <-- HERE
>>>
>>> The? nvme command opcode is nvme_cmd_write.? The nvmet_rdma_queue state
>>> is NVMET_RDMA_Q_LIVE.? The nvmet_req looks valid [2].? IE not garbage.
>>> But it seems very bad that req->rsp is NULL! :)
>>>
>>> Any thoughts?? I didn't see anything like this in recent nvmf fixes...
>>
>> Is it possible that you ran out of rsps and got a corrupted rsp?
>>
>> How about trying out this patch to add more information:
>> -- 
> 
> Hey Sagi, it hits the empty rsp list path often with your debug patch.
> I added code to BUG_ON() after 10 times and I have a crash dump I'm
> looking at.
> 
> Isn't the rsp list supposed to be sized such that it will never be empty
> when a new rsp is needed?  I wonder if there is a leak.
> 
> Steve.
> 

I do see that during this heavy load, the rdma send queue "full"
condition gets hit often:

static bool nvmet_rdma_execute_command(struct nvmet_rdma_rsp *rsp)
{
        struct nvmet_rdma_queue *queue = rsp->queue;

        if (unlikely(atomic_sub_return(1 + rsp->n_rdma,
                        &queue->sq_wr_avail) < 0)) {
                pr_debug("IB send queue full (needed %d): queue %u
cntlid %u\n",
                                1 + rsp->n_rdma, queue->idx,
                                queue->nvme_sq.ctrl->cntlid);
                atomic_add(1 + rsp->n_rdma, &queue->sq_wr_avail);
                return false;
        }

...

So commands are getting added to the wr_wait list:

static void nvmet_rdma_handle_command(struct nvmet_rdma_queue *queue,
                struct nvmet_rdma_rsp *cmd)
{
...
        if (unlikely(!nvmet_rdma_execute_command(cmd))) {
                spin_lock(&queue->rsp_wr_wait_lock);
                list_add_tail(&cmd->wait_list, &queue->rsp_wr_wait_list);
                spin_unlock(&queue->rsp_wr_wait_lock);
        }
...


Perhaps there's some bug in the wr_wait_list processing of deferred
commands?  I don't see anything though.
