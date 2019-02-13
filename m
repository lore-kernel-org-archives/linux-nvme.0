From: bvanassche@acm.org (Bart Van Assche)
Date: Wed, 13 Feb 2019 13:00:12 -0800
Subject: v5.0-rc2 and NVMeOF
In-Reply-To: <20190213195205.GA13650@linux.ibm.com>
References: <20190212174715.GP4240@linux.ibm.com>
 <20190212191522.GA27391@linux.ibm.com> <1550018699.19311.45.camel@acm.org>
 <20190213011023.GX4240@linux.ibm.com> <20190213151917.GA3311@linux.ibm.com>
 <20190213152413.GA4468@linux.ibm.com> <1550082964.19311.66.camel@acm.org>
 <20190213184839.GD4240@linux.ibm.com> <1550085136.19311.78.camel@acm.org>
 <20190213193013.GG4240@linux.ibm.com>
 <20190213195205.GA13650@linux.ibm.com>
Message-ID: <1550091612.31902.48.camel@acm.org>

On Wed, 2019-02-13@11:52 -0800, Paul E. McKenney wrote:
> On Wed, Feb 13, 2019@11:30:13AM -0800, Paul E. McKenney wrote:
> > On Wed, Feb 13, 2019@11:12:16AM -0800, Bart Van Assche wrote:
> > > commit 4317228ad9b86f094d70c951f9210a8a9b2816be
> > > Author: Nitzan Carmi <nitzanc at mellanox.com>
> > > Date:   Mon Apr 9 17:50:26 2018 +0300
> > > 
> > >     nvme: Avoid flush dependency in delete controller flow
> > >      
> > >     The nvme_delete_ctrl() function queues a work item on a MEM_RECLAIM
> > >     queue (nvme_delete_wq), which eventually calls cleanup_srcu_struct(),
> > >     which in turn flushes a delayed work from an !MEM_RECLAIM queue. This
> > >     is unsafe as we might trigger deadlocks under severe memory pressure.
> 
> Except that RCU's workqueues have since been set up as WQ_MEM_RECLAIM.
> 
> So could you please try switching back to cleanup_srcu_struct()?

(just back from lunch)

Hi Paul,

That change is sufficient to get rid of the KASAN use-after-free complaint.
Do you want to submit a patch or do you expect me to do that? If I have to
prepare a patch I think it will take a significant effort to come up with a
good patch description.

Bart.
