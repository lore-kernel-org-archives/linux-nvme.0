From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 16 Aug 2016 16:17:58 -0500
Subject: nvmf/rdma host crash during heavy load and keep alive recovery
In-Reply-To: <6ef9b0d1-ce84-4598-74db-7adeed313bb6@grimberg.me>
References: <018301d1e9e1$da3b2e40$8eb18ac0$@opengridcomputing.com>
 <20160801110658.GF16141@lst.de>
 <008801d1ec00$a0bcfbf0$e236f3d0$@opengridcomputing.com>
 <015801d1ec3d$0ca07ea0$25e17be0$@opengridcomputing.com>
 <010f01d1f31e$50c8cb40$f25a61c0$@opengridcomputing.com>
 <013701d1f320$57b185d0$07149170$@opengridcomputing.com>
 <018401d1f32b$792cfdb0$6b86f910$@opengridcomputing.com>
 <01a301d1f339$55ba8e70$012fab50$@opengridcomputing.com>
 <2fb1129c-424d-8b2d-7101-b9471e897dc8@grimberg.me>
 <004701d1f3d8$760660b0$62132210$@opengridcomputing.com>
 <008101d1f3de$557d2850$007778f0$@opengridcomputing.com>
 <00fe01d1f3e8$8992b330$9cb81990$@opengridcomputing.com>
 <01c301d1f702$d28c7270$77a55750$@opengridcomputing.com>
 <6ef9b0d1-ce84-4598-74db-7adeed313bb6@grimberg.me>
Message-ID: <045601d1f803$a9d73a20$fd85ae60$@opengridcomputing.com>

> > Hey Sagi,
> >
> > Do you have any ideas on this crash? I could really use some help.
> 
> Not yet :(
> 
> > Is it
> > possible that recovery/reconnect/restart of a different controller is
somehow
> > restarting the requests for a controller still in recovery?
> 
> I don't think this is the case.
> Can you try and find out if the request is from the admin tagset or from
> the io tagset?

I wasn't sure how to tell easily which tagset the request was in, so instead I
changed nvme_rdma_admin_mq_ops.queue_rq to its own distinct function,
nvme_rdma_queue_admin_rq() which was a clone of nvme_rdma_queue_rq().  Thus when
it crashed, I could tell by the stack trace.  Anyway, the stack trace indicates
it was from the io tagset.

> 
> We rely on the fact that no I/O will be issued after we call
> nvme_stop_queues(). can you trace that we indeed call nvme_stop_queues
> when we start error recovery and do nvme_start_queues only when we
> successfully reconnect and not anywhere in between?
> 

I see from debugging that the nvme_ns->queue address of the queue being used
that causes the crash was stopped via nvme_stop_queues().  It was never started
via nvme_start_queues().

> If that is the case, I think we need to have a closer look at
> nvme_stop_queues...
> 

request_queue->queue_flags does have QUEUE_FLAG_STOPPED set:

#define QUEUE_FLAG_STOPPED      2       /* queue is stopped */

crash> request_queue.queue_flags -x 0xffff880397a13d28
  queue_flags = 0x1f07a04
crash> request_queue.mq_ops 0xffff880397a13d28
  mq_ops = 0xffffffffa084b140 <nvme_rdma_mq_ops>

So it appears the queue is stopped, yet a request is being processed for that
queue.  Perhaps there is a race where QUEUE_FLAG_STOPPED is set after a request
is scheduled?
