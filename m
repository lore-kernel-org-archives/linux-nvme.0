From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 12 Dec 2018 12:10:45 -0600
Subject: [PATCH RFC 0/4] restore polling to nvme-rdma
In-Reply-To: <bd50927c-c72b-01f6-bad7-080076610cde@grimberg.me>
References: <20181211233652.9705-1-sagi@grimberg.me>
 <02a201d49239$0b00f3f0$2102dbd0$@opengridcomputing.com>
 <bd50927c-c72b-01f6-bad7-080076610cde@grimberg.me>
Message-ID: <033101d49246$00d1c320$02754960$@opengridcomputing.com>

> > Hey Sagi,
> 
> Hi Steve,
> 
> > Is there no way to handle this in the core?  Maybe have the polling context
> > transition to DIRECT when the queue becomes empty and before re-arming
> the
> > CQ?
> 
> That is what I suggested, but that would mean that we we need to drain
> the cq before making the switch, which means we need to allocate a
> dedicated qp for that cq, and even that doesn't guarantee that the
> ULP is not posting other wrs on its own qp(s)...
> 
> So making this safe for infight I/O would be a challenge... If we end
> up agreeing that we are ok with this functionality, I'd much rather not
> deal with it and simply document "use with care".
> 
> > So ib_change_cq_ctx() would be called to indicate the change should
> > happen when it is safe to do so.
> 
> You lost me here... ib_change_cq_ctx would get called by who and when?

I didn't look in detail at your changes, but ib_change_cq_ctx() is called by the application, right?  I was just asking what if the semantics of the call were "change the context when it is safe to do so" vs "do it immediately and hope there are no outstanding WRs".   But I don't think this semantic change simplifies the problem.  
