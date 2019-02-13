From: paulmck@linux.ibm.com (Paul E. McKenney)
Date: Wed, 13 Feb 2019 10:48:39 -0800
Subject: v5.0-rc2 and NVMeOF
In-Reply-To: <1550082964.19311.66.camel@acm.org>
References: <1549924039.19311.26.camel@acm.org>
 <20190212012422.GX4240@linux.ibm.com>
 <1549990020.19311.40.camel@acm.org>
 <20190212174715.GP4240@linux.ibm.com>
 <20190212191522.GA27391@linux.ibm.com>
 <1550018699.19311.45.camel@acm.org>
 <20190213011023.GX4240@linux.ibm.com>
 <20190213151917.GA3311@linux.ibm.com>
 <20190213152413.GA4468@linux.ibm.com>
 <1550082964.19311.66.camel@acm.org>
Message-ID: <20190213184839.GD4240@linux.ibm.com>

On Wed, Feb 13, 2019@10:36:04AM -0800, Bart Van Assche wrote:
> On Wed, 2019-02-13@07:24 -0800, Paul E. McKenney wrote:
> > On Wed, Feb 13, 2019@07:19:17AM -0800, Paul E. McKenney wrote:
> > > After sleeping on this...
> > > 
> > > You are getting the KASAN warning at the same place each time?
> > >
> > > This would force me to hypothesize that you are invoking
> > > srcu_struct_cleanup_quiesced() from a workqueue spawned from
> > > an SRCU callback.  Is that the case?
> > 
> > You could get the same effect by doing an synchronize_srcu() within
> > a workqueue handler, come to think of it.
> 
> Hi Paul,
> 
> The KASAN warning indeed occurs at the same place each time.
> 
> Have you noticed that there are no call_srcu() calls at all in the NVMe
> code? Since I'm not an RCU expert: what causes the SRCU code to invoke
> srcu_invoke_callbacks() if call_srcu() is not used?

I think I figured this out and am documenting it.  The trick is that
synchronize_srcu() internally does a call_srcu(), or close enough, anyway.

The reason you are using srcu_struct_cleanup_quiesced() is to avoid
workqueue deadlocks?

							Thanx, Paul
