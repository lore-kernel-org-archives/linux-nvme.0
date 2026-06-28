Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA772C43458
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Jun 2026 16:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fl6LmaQ7mCERBv+RR+kR+AVwN/pewOVd7cVWDKRU79c=; b=u7n4jx933ckpUzyQDHe+s3GbOa
	aBDA9EQIS3BdP75hoE/3YafyL1JkZlpHxy2D4w2+j4nX5X0FOJqkfn8hPNzePtouQbNgQWePOEYfi
	GZV5EvgjtasMuReMuPwTlpaBCGle3SuflkxFF5YHnfyWvbplJpn+eheltP0WJFQjE0Rh2n93IpUIV
	LVfO0tqdMqljLZZW8xHgDJwG0p9Fsr7q9NcD20TcYXEB4OxnXVX0xcQKxGuQkiyiEoSQZGs7Y0wPu
	hHCNFG1EczNjek+BcRGdRr00vjz8FgVebxXiP/iaeSORCBi/UR/1nsT3v7nMdUO+JT8EiuXlQmCZj
	R64vLOEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wds31-0000000DBsN-1RWX;
	Sun, 28 Jun 2026 16:07:55 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wds30-0000000DBsG-0lFx
	for linux-nvme@lists.infradead.org;
	Sun, 28 Jun 2026 16:07:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3149543D0C;
	Sun, 28 Jun 2026 16:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BFB1F000E9;
	Sun, 28 Jun 2026 16:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782662872;
	bh=Fl6LmaQ7mCERBv+RR+kR+AVwN/pewOVd7cVWDKRU79c=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=KM/tLHRH1XF325qayO+L5DtMLJIr1cuQ9YLZquPtDLzvedLQxLaNTE7btH483xeHx
	 6VBL3kcXtb8UBAsqQntk14zfiCb5PmeSXPB3IzEe8VDBAAdKDcrcs0hdfqoh/pxitr
	 ovz2pghmqNiB7CDn3etZSPHQfxGOyVGBSuK6J+r0Yru0FJHCVEHAJwqXrqFz8Fkq+2
	 dcP1yOLQL6PFkYg9d0Zbq9/Zl8gH6vuXsofrNR0qW1hDjPiWvz40wMRYdidEOZ23v4
	 c4o+9rjLmuw4XxxhxpMrhZUoCJfSwMysQUgm7MvszO5FZhClCxUCUk+Uw1OoIrKubE
	 CcGUEn1ROmUvQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A4E1ACE08B8; Sun, 28 Jun 2026 09:07:51 -0700 (PDT)
Date: Sun, 28 Jun 2026 09:07:51 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	bvanassche@acm.org, gjoyce@linux.ibm.com
Subject: Re: [PATCHv2 05/17] nvme: add Clang context annotations for
 nvme_ns_head::current_path
Message-ID: <62bbec8e-6eb5-4024-acba-6be1e7f33080@paulmck-laptop>
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
 <20260614131541.2017845-6-nilay@linux.ibm.com>
 <20260626064050.GE10731@lst.de>
 <e1c60afc-423b-47ec-9c38-db1397d8838f@paulmck-laptop>
 <CANpmjNPPF3TYx6qPzLO-DbQE6qvL_g6r3jYnGCk3aqeiQnnL5g@mail.gmail.com>
 <41a4cb5a-077c-499f-b060-2a4263303350@paulmck-laptop>
 <CANpmjNPAYsiQ=eiZ=0g579j1uO+-23ZXAhRA7M3uM-B8NdHg1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPAYsiQ=eiZ=0g579j1uO+-23ZXAhRA7M3uM-B8NdHg1g@mail.gmail.com>
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

On Sun, Jun 28, 2026 at 08:00:00AM +0200, Marco Elver wrote:
> On Sat, 27 Jun 2026 at 19:14, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Sat, Jun 27, 2026 at 05:38:44PM +0200, Marco Elver wrote:
> > > On Fri, 26 Jun 2026 at 20:36, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > On Fri, Jun 26, 2026 at 08:40:50AM +0200, Christoph Hellwig wrote:
> > > > > On Sun, Jun 14, 2026 at 06:45:20PM +0530, Nilay Shroff wrote:
> > > > > > +++ b/drivers/nvme/host/multipath.c
> > > > > > @@ -231,8 +231,16 @@ bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
> > > > > >     bool changed = false;
> > > > > >     int node;
> > > > > >
> > > > > > +   /*
> > > > > > +    * This helper is used by namespace failover/teardown and I/O policy
> > > > > > +    * update paths. We only compare the head->current_path[] pointer value
> > > > > > +    * and do not dereference the referenced namespace, so suppress the
> > > > > > +    * context analysis warning for this lockless inspection of the
> > > > > > +    * __rcu_guarded pointer.
> > > > > > +    */
> > > > > >     for_each_node(node) {
> > > > > > -           if (ns == rcu_access_pointer(head->current_path[node])) {
> > > > > > +           if (context_unsafe(ns ==
> > > > > > +                           rcu_access_pointer(head->current_path[node]))) {
> > > > >
> > > > > I think we need a helper for this, as for a simple pointer value
> > > > > comparison without a dereference we don't really need either
> > > > > rcu_access_pointer nor locking.
> > > > >
> > > > > Maybe somthing like a
> > > > >
> > > > >       rcu_compare_pointer(rcu_pointer, nonrcu_pointer)
> > > > >
> > > > > ?
> > > >
> > > > We could provide something like this:
> > > >
> > > > #define rcu_compare_pointer(rcu_pointer, nonrcu_pointer) \
> > > >         context_unsafe(rcu_access_pointer(rcu_pointer) == (nonrcu_pointer))
> > > >
> > > > Or maybe rcu_pointer_equals()?
> > > >
> > > > Marco, thoughts?
> > >
> > > I see 2 options:
> > >
> > > 1. rcu_compare_pointer / rcu_pointer_equals as proposed. It's more
> > > explicit but does add some friction during Context Analysis
> > > enablement. But this only makes sense if there are cases where
> > > rcu_access_pointer() should be used under the RCU reader lock, which
> > > led me to the next suggestion...
> > >
> > > 2. Redefine rcu_access_pointer() to just not require the RCU read-side
> > > lock to be held as:
> > >
> > > > #define rcu_access_pointer(p) context_unsafe(__rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu))
> > >
> > > [ Or alternatively wrap __rcu_access_pointer() in context_unsafe()
> > >   (similar to rcu_assign_pointer and friends). ]
> > >
> > > I think rcu_access_pointer() is in the same category as the other RCU
> > > pointer helpers, although currently only the pointer update helpers
> > > imply context_unsafe(); I think it might have been an oversight
> > > initially, and we should change rcu_access_pointer() to match. There
> > > should be no reason why an rcu_access_pointer() should be protected by
> > > the RCU read-side critical section, since it's not meant for
> > > dereferencing the pointer (that'd be a bug; its documentation also
> > > says "Return the value of the specified RCU-protected pointer, but
> > > omit the lockdep checks for being in an RCU read-side critical section
> > > [...]").
> > >
> > > If you agree there should be no cases where an rcu_access_pointer()
> > > should be guarded by an RCU read-side critical section, then I think
> > > this is the simplest and correct design, and avoids expanding the RCU
> > > API.
> >
> > I don't know of any uses of rcu_access_pointer() within an RCU read-side
> > critical section, but code in a function that might be called both within
> > and outside of a critical section might well use rcu_access_pointer().
> > In other words, it should be OK to use rcu_access_pointer() within an
> > RCU read-side critical section as well as outside of one.
> 
> Thanks, yes, that's what I wanted to confirm; i.e. it's ok to use
> rcu_access_pointer() within and outside an RCU read-side critical
> section.
> 
> In which case, my proposal (2) to make rcu_access_pointer() not warn
> on accessing __rcu_guarded pointers outside an RCU read-side critical
> section should be the simpler and more generic change (vs. adding a
> new rcu_pointer_equals() helper).

As shown below?

My guess is that this change makes it unnecessary to have a separate
RCU-protected-pointer comparison macro, but please let me know if I am
missing something.

							Thanx, Paul

------------------------------------------------------------------------

commit 32c1e63fee171f7ed8cc986ec64f576ee80bccab
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Sun Jun 28 09:00:01 2026 -0700

    rcu: Mark __rcu_access_pointer() as context_unsafe()
    
    A simple comparison of a pointer returned by rcu_access_pointer() results
    in a context-analysis warning for lockless inspection of the RCU-protected
    (also known as __rcu-protected) pointer.  This can be suppressed by
    placing context_unsafe() calls around calls rcu_access_pointer(),
    but this is messy and distracting.  This commit therefore wraps the
    underlying __rcu_access_pointer() macro with a call to context_unsafe(),
    thereby informing the context-analysis code that rcu_access_pointer()
    may safely be invoked outside of an RCU read-side critical section.
    
    Reported-by: Christoph Hellwig <hch@lst.de>
    Suggested-by: Marco Elver <elver@google.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 5e95acc33989b6..e40dc2e20c5b1f 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -490,12 +490,12 @@ context_unsafe(								\
  */
 #define unrcu_pointer(p) __unrcu_pointer(p, __UNIQUE_ID(rcu))
 
-#define __rcu_access_pointer(p, local, space) \
+#define __rcu_access_pointer(p, local, space) context_unsafe( \
 ({ \
 	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
 	rcu_check_sparse(p, space); \
 	((typeof(*p) __force __kernel *)(local)); \
-})
+}) )
 #define __rcu_dereference_check(p, local, c, space) \
 ({ \
 	/* Dependency order vs. p above. */ \

