From: swise@opengridcomputing.com (Steve Wise)
Date: Fri, 31 Aug 2018 08:01:08 -0500
Subject: Crash in nvmet_req_init() - null req->rsp pointer
In-Reply-To: <0ce90ceb-ebe7-4162-ce07-4ddd27207ecd@grimberg.me>
References: <1eb5a94a-07ed-1c2a-47fe-cc9a4bf32466@opengridcomputing.com>
 <d35d93e6-2e7b-a681-039b-75edaea7a9a2@opengridcomputing.com>
 <31a08853-e2a7-709a-9251-e6c64fda22dd@grimberg.me>
 <a165480b-7fcd-d208-8ce0-a1d7cdab24e9@opengridcomputing.com>
 <0bcbcb2e-0b01-57ef-0b9c-9ac3e56322cb@opengridcomputing.com>
 <0ce90ceb-ebe7-4162-ce07-4ddd27207ecd@grimberg.me>
Message-ID: <02b101d4412a$afc71a00$0f554e00$@opengridcomputing.com>

> 
> 
> >> Hey Sagi, it hits the empty rsp list path often with your debug patch.
> >> I added code to BUG_ON() after 10 times and I have a crash dump I'm
> >> looking at.
> >>
> >> Isn't the rsp list supposed to be sized such that it will never be empty
> >> when a new rsp is needed?  I wonder if there is a leak.
> 
> Doesn't look from my scan..
> 
> > I do see that during this heavy load, the rdma send queue "full"
> > condition gets hit often:
> >
> > static bool nvmet_rdma_execute_command(struct nvmet_rdma_rsp *rsp)
> > {
> >          struct nvmet_rdma_queue *queue = rsp->queue;
> >
> >          if (unlikely(atomic_sub_return(1 + rsp->n_rdma,
> >                          &queue->sq_wr_avail) < 0)) {
> >                  pr_debug("IB send queue full (needed %d): queue %u
> > cntlid %u\n",
> >                                  1 + rsp->n_rdma, queue->idx,
> >                                  queue->nvme_sq.ctrl->cntlid);
> >                  atomic_add(1 + rsp->n_rdma, &queue->sq_wr_avail);
> >                  return false;
> >          }
> >
> > ...
> >
> > So commands are getting added to the wr_wait list:
> >
> > static void nvmet_rdma_handle_command(struct nvmet_rdma_queue
> *queue,
> >                  struct nvmet_rdma_rsp *cmd)
> > {
> > ...
> >          if (unlikely(!nvmet_rdma_execute_command(cmd))) {
> >                  spin_lock(&queue->rsp_wr_wait_lock);
> >                  list_add_tail(&cmd->wait_list, &queue->rsp_wr_wait_list);
> >                  spin_unlock(&queue->rsp_wr_wait_lock);
> >          }
> > ...
> >
> >
> > Perhaps there's some bug in the wr_wait_list processing of deferred
> > commands?  I don't see anything though.
> 
> I assume this could happen if under heavy load the device send
> completions are slower than the rate incoming commands arrival
> (perhaps device and/or sw).
> 
> Because we post recv before sending the response back, there is
> a window where host can send us a new command before the send
> completion
> arrived, this is why we allocate more.
> 
> However, I think that nothing prevents that under heavy load the gap
> is growing until we exhaust 2x rsps.
> 
> So perhaps this is something we actually need to account for it...

Thanks for the explanation.  Yes, I believe we do.  Will you post the formal patch?  If it is the same as the one I already confirmed, you can add my test-by tag.

Thanks,

Steve.
