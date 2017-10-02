From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 3 Oct 2017 01:45:10 +0300
Subject: [PATCH 2/2] nvmet: Fix fatal_err_work deadlock
In-Reply-To: <991eab4b-d27c-2a17-ee14-0d9b11d9d2b1@broadcom.com>
References: <20170928153553.13993-1-jsmart2021@gmail.com>
 <20170928153553.13993-3-jsmart2021@gmail.com>
 <b5315d31-1d2c-b328-abd2-a734d4017372@grimberg.me>
 <991eab4b-d27c-2a17-ee14-0d9b11d9d2b1@broadcom.com>
Message-ID: <60908969-8934-e7c7-28b1-bc98fa62745a@grimberg.me>


>> fatal error handler was taking the assumption that that delete_ctrl
>> execution is asynchronous given that controller teardown is refcounted
>> by queues that are refcounted by inflight IO. This suggests that
>> controller actual free is async by nature, probably should have
>> documented it...
>>
>> Is fc's delete_ctrl blocks until all inflight IO is drained? I would
>> suggest to defer this blocking routine out of the fatal_error path like
>> rdma and loop. Is that something that breaks your design?
> 
> No - it really doesn't block waiting (like the host side) although it 
> may appear that way. Real difference is it processes the teardown in its 
> entirety and its possible, especially on light/idle load, the ref 
> counting could cause things to occur in the delete_ctrl context. Whereas 
> rdma and loop definitely convert over to another workq context for 
> teardown. Yes, I can do that too.? Yes, if there are requirements like 
> this for a transport - please add comments/documentation.? Although, as 
> you can see by this proposed patch, an implementation can be made in the 
> core that places no requirement on a transport.

I assume that we can change that to give some flexibility to the
transport implementation, so:

Acked-by: Sagi Grimberg <sagi at grimberg.me>
