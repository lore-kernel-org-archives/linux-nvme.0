From: paulmck@linux.ibm.com (Paul E. McKenney)
Date: Wed, 13 Feb 2019 11:52:05 -0800
Subject: v5.0-rc2 and NVMeOF
In-Reply-To: <20190213193013.GG4240@linux.ibm.com>
References: <20190212174715.GP4240@linux.ibm.com>
 <20190212191522.GA27391@linux.ibm.com>
 <1550018699.19311.45.camel@acm.org>
 <20190213011023.GX4240@linux.ibm.com>
 <20190213151917.GA3311@linux.ibm.com>
 <20190213152413.GA4468@linux.ibm.com>
 <1550082964.19311.66.camel@acm.org>
 <20190213184839.GD4240@linux.ibm.com>
 <1550085136.19311.78.camel@acm.org>
 <20190213193013.GG4240@linux.ibm.com>
Message-ID: <20190213195205.GA13650@linux.ibm.com>

On Wed, Feb 13, 2019@11:30:13AM -0800, Paul E. McKenney wrote:
> On Wed, Feb 13, 2019@11:12:16AM -0800, Bart Van Assche wrote:
> > On Wed, 2019-02-13@10:48 -0800, Paul E. McKenney wrote:
> > > On Wed, Feb 13, 2019@10:36:04AM -0800, Bart Van Assche wrote:
> > > > On Wed, 2019-02-13@07:24 -0800, Paul E. McKenney wrote:
> > > > > On Wed, Feb 13, 2019@07:19:17AM -0800, Paul E. McKenney wrote:
> > > > > > After sleeping on this...
> > > > > > 
> > > > > > You are getting the KASAN warning at the same place each time?
> > > > > > 
> > > > > > This would force me to hypothesize that you are invoking
> > > > > > srcu_struct_cleanup_quiesced() from a workqueue spawned from
> > > > > > an SRCU callback.  Is that the case?
> > > > > 
> > > > > You could get the same effect by doing an synchronize_srcu() within
> > > > > a workqueue handler, come to think of it.
> > > > 
> > > > Hi Paul,
> > > > 
> > > > The KASAN warning indeed occurs at the same place each time.
> > > > 
> > > > Have you noticed that there are no call_srcu() calls at all in the NVMe
> > > > code? Since I'm not an RCU expert: what causes the SRCU code to invoke
> > > > srcu_invoke_callbacks() if call_srcu() is not used?
> > > 
> > > I think I figured this out and am documenting it.  The trick is that
> > > synchronize_srcu() internally does a call_srcu(), or close enough, anyway.
> > > 
> > > The reason you are using srcu_struct_cleanup_quiesced() is to avoid
> > > workqueue deadlocks?
> > 
> > Hi Paul,
> > 
> > This patch introduced the srcu_struct_cleanup_quiesced() call:
> 
> OK, then yes, workqueue deadlocks.  Ouch.
> 
> Did my analysis of the bug make sense?
> 
> 							Thanx, Paul
> 
> > commit 4317228ad9b86f094d70c951f9210a8a9b2816be
> > Author: Nitzan Carmi <nitzanc at mellanox.com>
> > Date:   Mon Apr 9 17:50:26 2018 +0300
> > 
> >     nvme: Avoid flush dependency in delete controller flow
> >      
> >     The nvme_delete_ctrl() function queues a work item on a MEM_RECLAIM
> >     queue (nvme_delete_wq), which eventually calls cleanup_srcu_struct(),
> >     which in turn flushes a delayed work from an !MEM_RECLAIM queue. This
> >     is unsafe as we might trigger deadlocks under severe memory pressure.

Except that RCU's workqueues have since been set up as WQ_MEM_RECLAIM.

So could you please try switching back to cleanup_srcu_struct()?

							Thanx, Paul

> >     Since we don't ever invoke call_srcu(), it is safe to use the shiny new
> >     _quiesced() version of srcu cleanup, thus avoiding that flush dependency.
> >     This commit makes that change.
> >      
> >     Signed-off-by: Nitzan Carmi <nitzanc at mellanox.com>
> >     Signed-off-by: Paul E. McKenney <paulmck at linux.vnet.ibm.com>
> >     Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
> >     Tested-by: Nicholas Piggin <npiggin at gmail.com>
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 9df4f71e58ca..c3cea8a29843 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -349,7 +349,7 @@ static void nvme_free_ns_head(struct kref *ref)
> >         nvme_mpath_remove_disk(head);
> >         ida_simple_remove(&head->subsys->ns_ida, head->instance);
> >         list_del_init(&head->entry);
> > -       cleanup_srcu_struct(&head->srcu);
> > +       cleanup_srcu_struct_quiesced(&head->srcu);
> >         kfree(head);
> >  }
> > 
> > Bart.
> > 
