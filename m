From: bvanassche@acm.org (Bart Van Assche)
Date: Fri, 08 Mar 2019 13:25:16 -0800
Subject: [PATCH 1/5] blk-mq: Export reading mq request state
In-Reply-To: <20190308211431.GA5438@localhost.localdomain>
References: <20190308174006.5032-1-keith.busch@intel.com>
 <1552068443.45180.24.camel@acm.org>
 <20190308181551.GB5214@localhost.localdomain>
 <1552070537.45180.38.camel@acm.org>
 <20190308191954.GC5232@localhost.localdomain>
 <1552078030.45180.88.camel@acm.org>
 <20190308211431.GA5438@localhost.localdomain>
Message-ID: <1552080316.138960.11.camel@acm.org>

On Fri, 2019-03-08@14:14 -0700, Keith Busch wrote:
> On Fri, Mar 08, 2019@12:47:10PM -0800, Bart Van Assche wrote:
> > If no such mechanism has been defined in the NVMe spec: have you considered
> > to cancel all outstanding requests instead of calling blk_mq_end_request() for
> > all outstanding requests?
> 
> Isn't this cancelling requests? Is there an existing block interface
> that accomplishes this?

Hi Keith,

Sorry if I was unclear. With "canceling outstanding requests" I was referring to
the NVMe abort command. I think aborting outstanding requests has the advantage
that no new explicit call to blk_mq_end_request() call has to be added.

Bart.
