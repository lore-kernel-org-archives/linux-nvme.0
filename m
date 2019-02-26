From: paulmck@linux.ibm.com (Paul E. McKenney)
Date: Tue, 26 Feb 2019 11:20:43 -0800
Subject: v5.0-rc2 and NVMeOF
In-Reply-To: <1551206403.31902.179.camel@acm.org>
References: <20190213193013.GG4240@linux.ibm.com>
 <20190213195205.GA13650@linux.ibm.com>
 <1550091612.31902.48.camel@acm.org>
 <20190213220923.GK4240@linux.ibm.com>
 <1550103713.31902.57.camel@acm.org>
 <20190214010210.GM4240@linux.ibm.com>
 <20190226173520.GA21832@linux.ibm.com>
 <1551203224.31902.173.camel@acm.org>
 <20190226181211.GU4072@linux.ibm.com>
 <1551206403.31902.179.camel@acm.org>
Message-ID: <20190226192043.GW4072@linux.ibm.com>

On Tue, Feb 26, 2019@10:40:03AM -0800, Bart Van Assche wrote:
> On Tue, 2019-02-26@10:12 -0800, Paul E. McKenney wrote:
> > But if you want me to try to push this into v5.1, I need you to very
> > explicitly tell me that you want me to do this.  Sorry to be picky, but
> > my normal process cut off contributions to v5.0 more than a month ago,
> > and my usual position is that a backport to -stable covers almost all
> > use cases and reduces risk to those using mainline.  Yes, RCU patches
> > do start off under a considerable cloud of suspicion.  Which is one of
> > the reasons that RCU works at all.  ;-)
> > 
> > So again, if you need me to try to push this into v5.1, I do need an
> > explicit request from you.
> 
> Hi Paul,
> 
> If this patch will only be sent to Linus during the v5.2 merge window, will
> a "Cc: stable # v..." tag be added to this patch that causes this patch to
> be applied to kernel versions before v5.2 on which it is safe to apply this
> patch?

I would prefer that, especially if you let me know which versions that
are important to you.  ;-)

							Thanx, Paul
