From: james.smart@broadcom.com (James Smart)
Date: Sat, 30 Sep 2017 12:33:26 -0700
Subject: [PATCH 2/2] nvmet: Fix fatal_err_work deadlock
In-Reply-To: <b5315d31-1d2c-b328-abd2-a734d4017372@grimberg.me>
References: <20170928153553.13993-1-jsmart2021@gmail.com>
 <20170928153553.13993-3-jsmart2021@gmail.com>
 <b5315d31-1d2c-b328-abd2-a734d4017372@grimberg.me>
Message-ID: <991eab4b-d27c-2a17-ee14-0d9b11d9d2b1@broadcom.com>

On 9/30/2017 11:09 AM, Sagi Grimberg wrote:
>> Below is? a stack trace for an issue that was reported.
>>
>> What's happening is that the nvmet layer had it's controller kato
>> timeout fire, which causes it to schedule its fatal error handler
>> via the fatal_err_work element. The error handler is invoked, which
>> calls the transport delete_ctrl() entry point, and as the transport
>> tears down the controller, nvmet_sq_destroy ends up doing the final
>> put on the ctlr causing it to enter its free routine. The ctlr free
>> routine does a cancel_work_sync() on fatal_err_work element, which
>> then does a flush_work and wait_for_completion. But, as the wait is
>> in the context of the work element being flushed, its in a catch-22
>> and the thread hangs.
>
> fatal error handler was taking the assumption that that delete_ctrl
> execution is asynchronous given that controller teardown is refcounted
> by queues that are refcounted by inflight IO. This suggests that
> controller actual free is async by nature, probably should have
> documented it...
>
> Is fc's delete_ctrl blocks until all inflight IO is drained? I would
> suggest to defer this blocking routine out of the fatal_error path like
> rdma and loop. Is that something that breaks your design?

No - it really doesn't block waiting (like the host side) although it 
may appear that way. Real difference is it processes the teardown in its 
entirety and its possible, especially on light/idle load, the ref 
counting could cause things to occur in the delete_ctrl context. Whereas 
rdma and loop definitely convert over to another workq context for 
teardown. Yes, I can do that too.? Yes, if there are requirements like 
this for a transport - please add comments/documentation.? Although, as 
you can see by this proposed patch, an implementation can be made in the 
core that places no requirement on a transport.

-- james
