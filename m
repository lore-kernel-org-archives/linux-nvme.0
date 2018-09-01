From: swise@opengridcomputing.com (Steve Wise)
Date: Sat, 1 Sep 2018 07:40:39 -0500
Subject: [PATCH] nvmet-rdma: fix possible bogus dereference under heavy
 load
In-Reply-To: <20180901074414.GA32538@lst.de>
References: <20180901011447.32287-1-sagi@grimberg.me>
 <20180901074414.GA32538@lst.de>
Message-ID: <003801d441f0$fdc37a70$f94a6f50$@opengridcomputing.com>



> -----Original Message-----
> From: Christoph Hellwig <hch at lst.de>
> Sent: Saturday, September 1, 2018 2:44 AM
> To: Sagi Grimberg <sagi at grimberg.me>
> Cc: linux-nvme at lists.infradead.org; Steve Wise
> <swise at opengridcomputing.com>; Christoph Hellwig <hch at lst.de>
> Subject: Re: [PATCH] nvmet-rdma: fix possible bogus dereference under
> heavy load
> 
> On Fri, Aug 31, 2018@06:14:47PM -0700, Sagi Grimberg wrote:
> > Currently we always repost the recv buffer before we send a response
> > capsule back to the host. Since ordering is not guaranteed for send
> > and recv completions, it is posible that we will receive a new request
> > from the host before we got a send completion for the response capsule.
> >
> > Today, we pre-allocate 2x rsps the length of the queue, but in reality,
under
> > heavy load there is nothing that is really preventing the gap to expand
> > until we exhaust all our rsps.
> 
> This is a little scary and means we have the same issue in all other
> protocol drivers.  It also means that there probably is no point in
> allocating twice the queue length as it will be wasted most of the
> time, but still not enough.

I'm not sure the other protocols have this issue.  Where is the similar
issue in ib_isert?

If we made the rsp struct part of the nvmet_rdma_cmd, then we could remove
this issue and the list management involved with the nvmet_rdma_rsp struct.
Then we're ensured that when we get a nvme command from the host via a
recv_done completion, we have a rsp. 

Steve
