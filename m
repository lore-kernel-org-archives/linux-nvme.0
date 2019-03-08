From: bvanassche@acm.org (Bart Van Assche)
Date: Fri, 08 Mar 2019 10:08:47 -0800
Subject: [PATCH 2/5] blk-mq: Export iterating queue requests
In-Reply-To: <20190308174006.5032-2-keith.busch@intel.com>
References: <20190308174006.5032-1-keith.busch@intel.com>
 <20190308174006.5032-2-keith.busch@intel.com>
Message-ID: <1552068527.45180.25.camel@acm.org>

On Fri, 2019-03-08@10:40 -0700, Keith Busch wrote:
> A driver may need to iterate a particular queue's tagged request rather
> than the whole tagset.

Since iterating over requests triggers race conditions with request execution
please explain what use case(s) you have in mind and what your plan is to handle
such race conditions.

Thanks,

Bart.
