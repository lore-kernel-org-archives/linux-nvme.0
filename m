From: keith.busch@intel.com (Keith Busch)
Date: Fri, 8 Mar 2019 11:13:54 -0700
Subject: [PATCH 2/5] blk-mq: Export iterating queue requests
In-Reply-To: <1552068527.45180.25.camel@acm.org>
References: <20190308174006.5032-1-keith.busch@intel.com>
 <20190308174006.5032-2-keith.busch@intel.com>
 <1552068527.45180.25.camel@acm.org>
Message-ID: <20190308181353.GA5214@localhost.localdomain>

On Fri, Mar 08, 2019@10:08:47AM -0800, Bart Van Assche wrote:
> On Fri, 2019-03-08@10:40 -0700, Keith Busch wrote:
> > A driver may need to iterate a particular queue's tagged request rather
> > than the whole tagset.
> 
> Since iterating over requests triggers race conditions with request execution
> please explain what use case(s) you have in mind and what your plan is to handle
> such race conditions.

That race isn't new. You should only iterate when your queues are quieced
to ensure the request sent to a callback is stable.
