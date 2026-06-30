Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CAEC43458
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2026 14:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DN1fS+6HhpmqcIvuH01IrHEJ8bILaoQKHQJsiWqz1FU=; b=ZY83cof3V5B3aWvb233mZB/NJv
	4yFgrpM6IpnS9qJguyL4ph+qncTMxuLUJW8+mxj8Zbq0G9SZx/TeSelEXumwIlunHFR7Gar9Hv398
	bu5YP95wTXIXhXdBHxtogl47ZjX5fa3UqcX02jA7q5y4JeHtqTpK3SRBWzm8vnUAh8clhjfEts4hG
	lEzJ8qjo6Wp5gskfVjh7z5w0bFHmZBP1v5yiIqs9ZUyEhFvLX+y1Hty5g+6YqGlnDj2Wv3Dmo5283
	+ZsGMWNlU17uN/Fs+WOM7FxtyTE7vOTrByNGcSpyIVD+PuGuT0sgvnvzOkzj9k5UiLm+7Ofh4DM3g
	V43kSMng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weZOA-0000000HHEu-0xVy;
	Tue, 30 Jun 2026 14:24:38 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weZO7-0000000HHEa-3NYM
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jun 2026 14:24:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E63F6601DC;
	Tue, 30 Jun 2026 14:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3281F000E9;
	Tue, 30 Jun 2026 14:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782829474;
	bh=DN1fS+6HhpmqcIvuH01IrHEJ8bILaoQKHQJsiWqz1FU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=e7OOXEFEMG0CyU2tAXOBOOQDkNAT8sei+WCit/cN+4dpBgkzt+CIEPOLQWAq+ve+W
	 fyEyquP/FngudV2BCx5IPxo10Kv6VVn64sp6MuRWny3rx1erZWcXYLe5YFhaNakv9S
	 TqT9rut35NDj0cKU3bZIQIZAftI9hZrkk/iuG1hyxiGOSNj1gbz7OWvdVKX9q3dZH5
	 dCZkqkMVqjjkQClBkxPKi4nTknXOrjRnRxlCm5RAhFUvagpP8KLDlYbA6CnLjBvmNK
	 6ez1l2a5+GswVDQm9bWvbMXiIpsrPKZS6LkMcsd5eQiQfMIN47zFmpZLXGdQb5K3Uk
	 P+f/I7lftlHwg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6445FCE0F43; Tue, 30 Jun 2026 07:24:34 -0700 (PDT)
Date: Tue, 30 Jun 2026 07:24:34 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Marco Elver <elver@google.com>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	bvanassche@acm.org, gjoyce@linux.ibm.com
Subject: Re: [PATCHv2 05/17] nvme: add Clang context annotations for
 nvme_ns_head::current_path
Message-ID: <2654b8c1-4743-4f8b-ab8d-8b69bbf8c7e5@paulmck-laptop>
References: <20260626064050.GE10731@lst.de>
 <e1c60afc-423b-47ec-9c38-db1397d8838f@paulmck-laptop>
 <CANpmjNPPF3TYx6qPzLO-DbQE6qvL_g6r3jYnGCk3aqeiQnnL5g@mail.gmail.com>
 <41a4cb5a-077c-499f-b060-2a4263303350@paulmck-laptop>
 <CANpmjNPAYsiQ=eiZ=0g579j1uO+-23ZXAhRA7M3uM-B8NdHg1g@mail.gmail.com>
 <62bbec8e-6eb5-4024-acba-6be1e7f33080@paulmck-laptop>
 <2a3c6a56-a9a6-461e-80ca-c0f2b4203bff@linux.ibm.com>
 <CANpmjNNVw9rR5J-Bd3FL9Cxss3b+mN-XCGsg1c9HrTa70S0HEQ@mail.gmail.com>
 <38955e20-0bf3-4c8c-bfc6-352ca1a4d83c@paulmck-laptop>
 <fa1eb6cd-39e5-4e98-aff0-83733abb5cb4@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa1eb6cd-39e5-4e98-aff0-83733abb5cb4@linux.ibm.com>
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

On Tue, Jun 30, 2026 at 03:26:40PM +0530, Nilay Shroff wrote:
> > > > > 
> > > > > commit 32c1e63fee171f7ed8cc986ec64f576ee80bccab
> > > > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > > > Date:   Sun Jun 28 09:00:01 2026 -0700
> > > > > 
> > > > >       rcu: Mark __rcu_access_pointer() as context_unsafe()
> > > > > 
> > > > >       A simple comparison of a pointer returned by rcu_access_pointer() results
> > > > >       in a context-analysis warning for lockless inspection of the RCU-protected
> > > > >       (also known as __rcu-protected) pointer.  This can be suppressed by
> > > > >       placing context_unsafe() calls around calls rcu_access_pointer(),
> > > > >       but this is messy and distracting.  This commit therefore wraps the
> > > > >       underlying __rcu_access_pointer() macro with a call to context_unsafe(),
> > > > >       thereby informing the context-analysis code that rcu_access_pointer()
> > > > >       may safely be invoked outside of an RCU read-side critical section.
> > > > > 
> > > > >       Reported-by: Christoph Hellwig <hch@lst.de>
> > > > >       Suggested-by: Marco Elver <elver@google.com>
> > > > >       Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > 
> > > > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > > > index 5e95acc33989b6..e40dc2e20c5b1f 100644
> > > > > --- a/include/linux/rcupdate.h
> > > > > +++ b/include/linux/rcupdate.h
> > > > > @@ -490,12 +490,12 @@ context_unsafe(                                                         \
> > > > >     */
> > > > >    #define unrcu_pointer(p) __unrcu_pointer(p, __UNIQUE_ID(rcu))
> > > > > 
> > > > > -#define __rcu_access_pointer(p, local, space) \
> > > > > +#define __rcu_access_pointer(p, local, space) context_unsafe( \
> > > > >    ({ \
> > > > >        typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
> > > > >        rcu_check_sparse(p, space); \
> > > > >        ((typeof(*p) __force __kernel *)(local)); \
> > > > > -})
> > > > > +}) )
> > > > >    #define __rcu_dereference_check(p, local, c, space) \
> > > > >    ({ \
> > > > >        /* Dependency order vs. p above. */ \
> > > > 
> > > > I have tested the above patch with an __rcu_guarded pointer accessed
> > > > outside an RCU read-side critical section while Clang context analysis
> > > > is enabled. I can confirm that this change suppresses the context
> > > > analysis warning when the pointer is accessed via rcu_access_pointer().
> > > > 
> > > > With that, if you send out this change, please add:
> > > > 
> > > > Tested-by: Nilay Shroff <nilay@linux.ibm.com>
> > > 
> > > Thanks for double-checking.
> > > 
> > > Reviewed-by: Marco Elver <elver@google.com>
> > 
> > Thank you all!
> > 
> > By default, I will push this into the upcoming v7.3 merge window.  If you
> > need it earlier, we would have to make a case for this being a regression.
> > Which I could probably do, but first, is v7.3 too late for you?
> 
> I think anyways the current series would not land in the upcoming
> kernel v7.2. So if you could push this during v7.3 merge window then
> that should be good for us.

Very good, v7.3 it is!

							Thanx, Paul

