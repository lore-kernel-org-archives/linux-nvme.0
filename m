From: bvanassche@acm.org (Bart Van Assche)
Date: Fri, 08 Mar 2019 12:47:10 -0800
Subject: [PATCH 1/5] blk-mq: Export reading mq request state
In-Reply-To: <20190308191954.GC5232@localhost.localdomain>
References: <20190308174006.5032-1-keith.busch@intel.com>
 <1552068443.45180.24.camel@acm.org>
 <20190308181551.GB5214@localhost.localdomain>
 <1552070537.45180.38.camel@acm.org>
 <20190308191954.GC5232@localhost.localdomain>
Message-ID: <1552078030.45180.88.camel@acm.org>

On Fri, 2019-03-08@12:19 -0700, Keith Busch wrote:
> On Fri, Mar 08, 2019@10:42:17AM -0800, Bart Van Assche wrote:
> > I think that the NVMe spec provides a more elegant mechanism,
> > namely deleting the I/O submission queues. According to what I read in the
> > 1.3c spec deleting an I/O submission queue forces an NVMe controller to post a 
> > completion for every outstanding request. See also section 5.6 in the NVMe
> > 1.3c spec.
> 
> That's actually not what it says. The controller may or may not post a
> completion entry with a delete SQ command. The first behavior is defined
> in the spec as "explicit" and the second as "implicit". For implicit,
> we have to iterate inflight tags.

Hi Keith,

Thanks for the clarification. Are you aware of any mechanism in the NVMe spec
that causes all outstanding requests to fail? With RDMA this is easy - all
one has to do is to change the queue pair state into IB_QPS_ERR. See also
ib_drain_qp() in the RDMA core.

If no such mechanism has been defined in the NVMe spec: have you considered
to cancel all outstanding requests instead of calling blk_mq_end_request() for
all outstanding requests?

Thanks,

Bart.
