From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Mon, 21 May 2018 23:29:21 +0000
Subject: [RFC PATCH 0/3] blk-mq: Timeout rework
In-Reply-To: <20180521231131.6685-1-keith.busch@intel.com>
References: <20180521231131.6685-1-keith.busch@intel.com>
Message-ID: <9ca27e059fbd12a976e1e2f1ee1aa5c8ca579ad0.camel@wdc.com>

On Mon, 2018-05-21@17:11 -0600, Keith Busch wrote:
> The current blk-mq code potentially locks requests out of completion by
> the thousands, making drivers jump through hoops to handle them. This
> patch set allows drivers to complete their requests whenever they're
> completed without requiring drivers know anything about the timeout code
> with minimal syncronization.
> 
> Other proposals under current consideration still have moments that
> prevent a driver from progressing a request to the completed state.
> 
> The timeout is ultimatley made safe by reference counting the request
> when timeout handling claims the request. By holding the reference count,
> we don't need to do any tricks to prevent a driver from completing the
> request out from under the timeout handler, allowing the actual state
> to be changed inline with the true state, and drivers don't need to be
> aware any of this is happening.
> 
> In order to make the overhead as minimal as possible, the request's
> reference is taken only when it appears that actual timeout handling
> needs to be done.

Hello Keith,

Can you explain why the NVMe driver needs reference counting of requests but
no other block driver needs this? Additionally, why is it that for all block
drivers except NVMe the current block layer API is sufficient
(blk_get_request()/blk_execute_rq()/blk_mq_start_request()/
blk_mq_complete_request()/blk_mq_end_request())?

Thanks,

Bart.
