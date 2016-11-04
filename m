From: swise@opengridcomputing.com (Steve Wise)
Date: Fri, 4 Nov 2016 09:25:59 -0500
Subject: [PATCH] nvmet: Don't queue fatal error work if csts.cfs is set
In-Reply-To: <a1140250-d4b2-bdba-ee21-9ea5e181151b@grimberg.me>
References: <1478207842-27774-1-git-send-email-sagi@grimberg.me>
 <20161104000111.GA14022@lst.de>
 <a1140250-d4b2-bdba-ee21-9ea5e181151b@grimberg.me>
Message-ID: <01de01d236a7$5ce9f300$16bdd900$@opengridcomputing.com>

> >>  {
> >> -	ctrl->csts |= NVME_CSTS_CFS;
> >> +	if (test_and_set_bit(NVME_CSTS_CFS, (unsigned long *)&ctrl->csts))
> >> +		return;
> >> +
> >
> > This can't work - test_and_set_bit takes a bit index and NVME_CSTS_CFS
> > is the actual value.  I think we'll need a lock to protect ->csts
> > instead.
> 
> Oops... it still prevents from fatal_err work from requeueing
> so at least I got 50% :)
> 
> I'll send a proper patch with a lock in place...
> 

I wonder if this is causing my most recent target crashes during kato
reconnect/recovery testing?
