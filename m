From: keith.busch@intel.com (Keith Busch)
Date: Fri, 8 Mar 2019 14:14:32 -0700
Subject: [PATCH 1/5] blk-mq: Export reading mq request state
In-Reply-To: <1552078030.45180.88.camel@acm.org>
References: <20190308174006.5032-1-keith.busch@intel.com>
 <1552068443.45180.24.camel@acm.org>
 <20190308181551.GB5214@localhost.localdomain>
 <1552070537.45180.38.camel@acm.org>
 <20190308191954.GC5232@localhost.localdomain>
 <1552078030.45180.88.camel@acm.org>
Message-ID: <20190308211431.GA5438@localhost.localdomain>

On Fri, Mar 08, 2019@12:47:10PM -0800, Bart Van Assche wrote:
> Thanks for the clarification. Are you aware of any mechanism in the NVMe spec
> that causes all outstanding requests to fail? With RDMA this is easy - all
> one has to do is to change the queue pair state into IB_QPS_ERR. See also
> ib_drain_qp() in the RDMA core.

Well, we can't always rely on hardware to provide completions. The
driver must be able to make forward progress if the device decides to
stop responding, or maybe it was disconnected, asserts, or experiences
an unsafe shutdown/powerloss.

> If no such mechanism has been defined in the NVMe spec: have you considered
> to cancel all outstanding requests instead of calling blk_mq_end_request() for
> all outstanding requests?

Isn't this cancelling requests? Is there an existing block interface
that accomplishes this?
