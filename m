From: sagi@grimberg.me (Sagi Grimberg)
Date: Sat, 30 Sep 2017 20:09:06 +0200
Subject: [PATCH 2/2] nvmet: Fix fatal_err_work deadlock
In-Reply-To: <20170928153553.13993-3-jsmart2021@gmail.com>
References: <20170928153553.13993-1-jsmart2021@gmail.com>
 <20170928153553.13993-3-jsmart2021@gmail.com>
Message-ID: <b5315d31-1d2c-b328-abd2-a734d4017372@grimberg.me>

> Below is  a stack trace for an issue that was reported.
> 
> What's happening is that the nvmet layer had it's controller kato
> timeout fire, which causes it to schedule its fatal error handler
> via the fatal_err_work element. The error handler is invoked, which
> calls the transport delete_ctrl() entry point, and as the transport
> tears down the controller, nvmet_sq_destroy ends up doing the final
> put on the ctlr causing it to enter its free routine. The ctlr free
> routine does a cancel_work_sync() on fatal_err_work element, which
> then does a flush_work and wait_for_completion. But, as the wait is
> in the context of the work element being flushed, its in a catch-22
> and the thread hangs.

fatal error handler was taking the assumption that that delete_ctrl
execution is asynchronous given that controller teardown is refcounted
by queues that are refcounted by inflight IO. This suggests that
controller actual free is async by nature, probably should have
documented it...

Is fc's delete_ctrl blocks until all inflight IO is drained? I would
suggest to defer this blocking routine out of the fatal_error path like
rdma and loop. Is that something that breaks your design?
