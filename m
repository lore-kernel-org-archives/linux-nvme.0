Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65396C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2026 15:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BCvLMieP2pytnq+4rVw8hEBl8873sVwzabVjRVg/b1g=; b=SDNcDA36E44EqQL626U4cwn3mx
	hBIw17BzLhRDdfrgEcSMl94CO8OW6edIouTgQPT+Sihq1VBiMrQy/hxLjitFJAIZZbk18iRykggzE
	F5awhiysCqYDon0Ac3Env3xrFw+N++LX9rQ/U9tmsEKr4Yl2jH0HYzLfwJdGthKOS5NIir0nb73cz
	29opIj7qpmpzUOrhTMEcxod+UTyD2kHPOWwEkLEeGOCyfKGDamF0j5C1uWF78/kGck/9qMZEuwu7D
	V2Hd8WWNBWMCELzmNOhCBYi10QEQG+v8U3QyCUAyhHil1bkMMzHESBMcAb33CaFJ0w+ozMAX3JBjo
	6OR854jA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weDzk-0000000F5Je-1DN1;
	Mon, 29 Jun 2026 15:34:00 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weDzi-0000000F5JT-2lDH
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jun 2026 15:33:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D885760008;
	Mon, 29 Jun 2026 15:33:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0721F000E9;
	Mon, 29 Jun 2026 15:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782747237;
	bh=BCvLMieP2pytnq+4rVw8hEBl8873sVwzabVjRVg/b1g=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=GbUAZgTnZa7olaMU4aPk6oiu8TdKfaRMRntV6SfIU567iFpM1MbfRYBJK0KhwSWqc
	 51dWJ+hNvdr+1od7rklRk6D52K4oZ7WfmxfoctfX9Z8zZEzGJyNnvw43UOzChK3jEW
	 lFTk/cZim2QH3ldwWPkncKmxEDKQO6Y8OS9LKRT5vHV5XS5WS8lFIrPoOsbA7u/wOw
	 c4q9Voxy7gewQ01Pg0O03XaJcZqsQgD8hokH2s1+Dmeidrx1gNk6IzuUCGYeNO0MkP
	 3Y5cueKXxf+2xUMgoArfp27VH5c1C5bmSvSKG40VzVp72XEqS3a4XHubQHK2JHJ21V
	 XO6+dKDQ/nCsQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5ACB3CE04B8; Mon, 29 Jun 2026 08:33:57 -0700 (PDT)
Date: Mon, 29 Jun 2026 08:33:57 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	bvanassche@acm.org, gjoyce@linux.ibm.com
Subject: Re: [PATCHv2 05/17] nvme: add Clang context annotations for
 nvme_ns_head::current_path
Message-ID: <38955e20-0bf3-4c8c-bfc6-352ca1a4d83c@paulmck-laptop>
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
 <20260614131541.2017845-6-nilay@linux.ibm.com>
 <20260626064050.GE10731@lst.de>
 <e1c60afc-423b-47ec-9c38-db1397d8838f@paulmck-laptop>
 <CANpmjNPPF3TYx6qPzLO-DbQE6qvL_g6r3jYnGCk3aqeiQnnL5g@mail.gmail.com>
 <41a4cb5a-077c-499f-b060-2a4263303350@paulmck-laptop>
 <CANpmjNPAYsiQ=eiZ=0g579j1uO+-23ZXAhRA7M3uM-B8NdHg1g@mail.gmail.com>
 <62bbec8e-6eb5-4024-acba-6be1e7f33080@paulmck-laptop>
 <2a3c6a56-a9a6-461e-80ca-c0f2b4203bff@linux.ibm.com>
 <CANpmjNNVw9rR5J-Bd3FL9Cxss3b+mN-XCGsg1c9HrTa70S0HEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNVw9rR5J-Bd3FL9Cxss3b+mN-XCGsg1c9HrTa70S0HEQ@mail.gmail.com>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: paulmck@kernel.org
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jun 29, 2026 at 10:48:43AM +0200, Marco Elver wrote:
> On Mon, 29 Jun 2026 at 07:20, Nilay Shroff <nilay@linux.ibm.com> wrote:
> >
> > On 6/28/26 9:37 PM, Paul E. McKenney wrote:
> > > On Sun, Jun 28, 2026 at 08:00:00AM +0200, Marco Elver wrote:
> > >> On Sat, 27 Jun 2026 at 19:14, Paul E. McKenney <paulmck@kernel.org> wrote:
> > >>>
> > >>> On Sat, Jun 27, 2026 at 05:38:44PM +0200, Marco Elver wrote:
> > >>>> On Fri, 26 Jun 2026 at 20:36, Paul E. McKenney <paulmck@kernel.org> wrote:
> > >>>>> On Fri, Jun 26, 2026 at 08:40:50AM +0200, Christoph Hellwig wrote:
> > >>>>>> On Sun, Jun 14, 2026 at 06:45:20PM +0530, Nilay Shroff wrote:
> > >>>>>>> +++ b/drivers/nvme/host/multipath.c
> > >>>>>>> @@ -231,8 +231,16 @@ bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
> > >>>>>>>      bool changed = false;
> > >>>>>>>      int node;
> > >>>>>>>
> > >>>>>>> +   /*
> > >>>>>>> +    * This helper is used by namespace failover/teardown and I/O policy
> > >>>>>>> +    * update paths. We only compare the head->current_path[] pointer value
> > >>>>>>> +    * and do not dereference the referenced namespace, so suppress the
> > >>>>>>> +    * context analysis warning for this lockless inspection of the
> > >>>>>>> +    * __rcu_guarded pointer.
> > >>>>>>> +    */
> > >>>>>>>      for_each_node(node) {
> > >>>>>>> -           if (ns == rcu_access_pointer(head->current_path[node])) {
> > >>>>>>> +           if (context_unsafe(ns ==
> > >>>>>>> +                           rcu_access_pointer(head->current_path[node]))) {
> > >>>>>>
> > >>>>>> I think we need a helper for this, as for a simple pointer value
> > >>>>>> comparison without a dereference we don't really need either
> > >>>>>> rcu_access_pointer nor locking.
> > >>>>>>
> > >>>>>> Maybe somthing like a
> > >>>>>>
> > >>>>>>        rcu_compare_pointer(rcu_pointer, nonrcu_pointer)
> > >>>>>>
> > >>>>>> ?
> > >>>>>
> > >>>>> We could provide something like this:
> > >>>>>
> > >>>>> #define rcu_compare_pointer(rcu_pointer, nonrcu_pointer) \
> > >>>>>          context_unsafe(rcu_access_pointer(rcu_pointer) == (nonrcu_pointer))
> > >>>>>
> > >>>>> Or maybe rcu_pointer_equals()?
> > >>>>>
> > >>>>> Marco, thoughts?
> > >>>>
> > >>>> I see 2 options:
> > >>>>
> > >>>> 1. rcu_compare_pointer / rcu_pointer_equals as proposed. It's more
> > >>>> explicit but does add some friction during Context Analysis
> > >>>> enablement. But this only makes sense if there are cases where
> > >>>> rcu_access_pointer() should be used under the RCU reader lock, which
> > >>>> led me to the next suggestion...
> > >>>>
> > >>>> 2. Redefine rcu_access_pointer() to just not require the RCU read-side
> > >>>> lock to be held as:
> > >>>>
> > >>>>> #define rcu_access_pointer(p) context_unsafe(__rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu))
> > >>>>
> > >>>> [ Or alternatively wrap __rcu_access_pointer() in context_unsafe()
> > >>>>    (similar to rcu_assign_pointer and friends). ]
> > >>>>
> > >>>> I think rcu_access_pointer() is in the same category as the other RCU
> > >>>> pointer helpers, although currently only the pointer update helpers
> > >>>> imply context_unsafe(); I think it might have been an oversight
> > >>>> initially, and we should change rcu_access_pointer() to match. There
> > >>>> should be no reason why an rcu_access_pointer() should be protected by
> > >>>> the RCU read-side critical section, since it's not meant for
> > >>>> dereferencing the pointer (that'd be a bug; its documentation also
> > >>>> says "Return the value of the specified RCU-protected pointer, but
> > >>>> omit the lockdep checks for being in an RCU read-side critical section
> > >>>> [...]").
> > >>>>
> > >>>> If you agree there should be no cases where an rcu_access_pointer()
> > >>>> should be guarded by an RCU read-side critical section, then I think
> > >>>> this is the simplest and correct design, and avoids expanding the RCU
> > >>>> API.
> > >>>
> > >>> I don't know of any uses of rcu_access_pointer() within an RCU read-side
> > >>> critical section, but code in a function that might be called both within
> > >>> and outside of a critical section might well use rcu_access_pointer().
> > >>> In other words, it should be OK to use rcu_access_pointer() within an
> > >>> RCU read-side critical section as well as outside of one.
> > >>
> > >> Thanks, yes, that's what I wanted to confirm; i.e. it's ok to use
> > >> rcu_access_pointer() within and outside an RCU read-side critical
> > >> section.
> > >>
> > >> In which case, my proposal (2) to make rcu_access_pointer() not warn
> > >> on accessing __rcu_guarded pointers outside an RCU read-side critical
> > >> section should be the simpler and more generic change (vs. adding a
> > >> new rcu_pointer_equals() helper).
> > >
> > > As shown below?
> > >
> > > My guess is that this change makes it unnecessary to have a separate
> > > RCU-protected-pointer comparison macro, but please let me know if I am
> > > missing something.
> > >
> > >                                                       Thanx, Paul
> > >
> > > ------------------------------------------------------------------------
> > >
> > > commit 32c1e63fee171f7ed8cc986ec64f576ee80bccab
> > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > Date:   Sun Jun 28 09:00:01 2026 -0700
> > >
> > >      rcu: Mark __rcu_access_pointer() as context_unsafe()
> > >
> > >      A simple comparison of a pointer returned by rcu_access_pointer() results
> > >      in a context-analysis warning for lockless inspection of the RCU-protected
> > >      (also known as __rcu-protected) pointer.  This can be suppressed by
> > >      placing context_unsafe() calls around calls rcu_access_pointer(),
> > >      but this is messy and distracting.  This commit therefore wraps the
> > >      underlying __rcu_access_pointer() macro with a call to context_unsafe(),
> > >      thereby informing the context-analysis code that rcu_access_pointer()
> > >      may safely be invoked outside of an RCU read-side critical section.
> > >
> > >      Reported-by: Christoph Hellwig <hch@lst.de>
> > >      Suggested-by: Marco Elver <elver@google.com>
> > >      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > >
> > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > index 5e95acc33989b6..e40dc2e20c5b1f 100644
> > > --- a/include/linux/rcupdate.h
> > > +++ b/include/linux/rcupdate.h
> > > @@ -490,12 +490,12 @@ context_unsafe(                                                         \
> > >    */
> > >   #define unrcu_pointer(p) __unrcu_pointer(p, __UNIQUE_ID(rcu))
> > >
> > > -#define __rcu_access_pointer(p, local, space) \
> > > +#define __rcu_access_pointer(p, local, space) context_unsafe( \
> > >   ({ \
> > >       typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
> > >       rcu_check_sparse(p, space); \
> > >       ((typeof(*p) __force __kernel *)(local)); \
> > > -})
> > > +}) )
> > >   #define __rcu_dereference_check(p, local, c, space) \
> > >   ({ \
> > >       /* Dependency order vs. p above. */ \
> >
> > I have tested the above patch with an __rcu_guarded pointer accessed
> > outside an RCU read-side critical section while Clang context analysis
> > is enabled. I can confirm that this change suppresses the context
> > analysis warning when the pointer is accessed via rcu_access_pointer().
> >
> > With that, if you send out this change, please add:
> >
> > Tested-by: Nilay Shroff <nilay@linux.ibm.com>
> 
> Thanks for double-checking.
> 
> Reviewed-by: Marco Elver <elver@google.com>

Thank you all!

By default, I will push this into the upcoming v7.3 merge window.  If you
need it earlier, we would have to make a case for this being a regression.
Which I could probably do, but first, is v7.3 too late for you?

							Thanx, Paul

