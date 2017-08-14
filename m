From: sean.hefty@intel.com (Hefty, Sean)
Date: Mon, 14 Aug 2017 17:01:54 +0000
Subject: Flush warning
In-Reply-To: <3d9cca62-4612-53dc-776c-3aeb2df58365@dev.mellanox.co.il>
References: <016301d30c86$e7034ae0$b509e0a0$@opengridcomputing.com>
 <9bc142de-b8ba-acb6-5ea1-2ccdbb578655@grimberg.me>
 <003401d30f91$c7e2a3f0$57a7ebd0$@opengridcomputing.com>
 <00ff01d3112b$94142350$bc3c69f0$@opengridcomputing.com>
 <20170809162749.GA4069@obsidianresearch.com>
 <011601d3112d$fa305b70$ee911250$@opengridcomputing.com>
 <20170813064651.GR24282@mtr-leonro.local>
 <90ada4f5-d6a1-2b93-5164-c593955c20cf@grimberg.me>
 <20170813103359.GW24282@mtr-leonro.local>
 <3d9cca62-4612-53dc-776c-3aeb2df58365@dev.mellanox.co.il>
Message-ID: <1828884A29C6694DAF28B7E6B8A82373AB17595A@ORSMSX109.amr.corp.intel.com>

> >>> The workqueue which frees the memory and doesn't allocate memory
> >>> during execution is supposed to be marked as WQ_MEM_RECLAIM. This
> >>> flag will cause to priority increase for such workqueue during low
> memory conditions.
> >>
> >> Which to my understanding means that CM workqueue should not use it
> >> as on each CM connect, by definition the ULP allocates memory (qp,
> cq etc).
> >
> > From my understanding too.
> > That workqueue was introduced in 2005, in a977049dacde ("[PATCH] IB:
> > Add the kernel CM implementation"), it is not clear if it was
> > intentionally.
> >
> > Hal,
> > do you remember the rationale there?
> 
> Sean is best to respond to this.

I believe the work queue was to avoid potential deadlocks that could arise from using the MAD work queue.  The original submission did not mark the work queue with WQ_MEM_RECLAIM.  I do not know when that change was added.

- Sean
