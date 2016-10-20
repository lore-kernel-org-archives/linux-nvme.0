From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 20 Oct 2016 10:49:43 +0300
Subject: Disconnecting nvmet-rdma
In-Reply-To: <20161019130009.GA5876@lst.de>
References: <26c343fe-23a8-e482-0b28-0b4a8c2ac70e@sandisk.com>
 <20161019130009.GA5876@lst.de>
Message-ID: <fe8993ab-38c9-96a1-0c75-e018de246107@grimberg.me>


> how do you reproduce the timedwait condition?  My RDMA test setup is
> still being moved, so I can't reproduce it myself, but I'd like to know
> for the future.

+1 on that, never was able to step on this.

> The only reason why I could see a NULL queue here is if RDMA/CM
> also calls the timedwait exit handler for the listener CM ids,
> in which case your patch would be correct.  Can you check for that
> theory by printing the cm_id address in nvmet_rdma_add_port and in
> nvmet_rdma_cm_handler?

Where do you see indication for that in the code? TIMEWAIT doesn't make
sense for listener cm_ids. The CM enters timewait (starts a timer) when:
- sends a disconnect request
- sends a disconnect reply
- sends a connect reject
- received a connect reject

Non of those happen with the listener cm_id. Maybe I'm missing
something?

Note that the cm_id->qp is NULL which means that it was
never created (destroy doesn't nullify it).

 From looking at the code there are two flows that can trigger this:
- we failed nvmet_rdma_queue_connect() but didn't destroy
   the cm_id -> which triggered this event later (but I can't find
   indication of that in the code)

- Something in the CM spaghetti triggered this after we accepted
   but the client rejected us for some reason (although I think we should
   have seen UNREACHABLE event...

Or something else...

Bart, more information on what happened exactly (and how) would help
here.

> Also is there any chance you could try your reproducer with the iSER target
> as well?  It also seems to blindly derference the queue.

It probably will happen too...
