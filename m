From: swise@opengridcomputing.com (Steve Wise)
Date: Sat, 25 Aug 2018 07:18:43 -0500
Subject: [PATCH v2] block: fix rdma queue mapping
In-Reply-To: <e82f994b-76ec-2a04-b575-acb4439e4d5b@grimberg.me>
References: <20180820205420.25908-1-sagi@grimberg.me>
 <20180821020434.GA24247@ming.t460p>
 <e82f994b-76ec-2a04-b575-acb4439e4d5b@grimberg.me>
Message-ID: <005801d43c6d$c4afbba0$4e0f32e0$@opengridcomputing.com>

> > I guess this way still can't fix the request allocation crash issue
> > triggered by using blk_mq_alloc_request_hctx(), in which one hw queue
> may
> > not be mapped from any online CPU.
> 
> Not really. I guess we will need to simply skip queues that are
> mapped to an offline cpu.
> 
> > Maybe this patch isn't for this issue, but it is closely related.
> 
> Yes, another patch is still needed.
> 
> Steve, do you still have that patch? I don't seem to
> find it anywhere.

I have no such patch.  I don't remember this issue.

Steve.
