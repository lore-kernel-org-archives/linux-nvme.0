Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE0E606A328
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 01:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GxA1Rdjo;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UZNWd8YS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=vzblkOvjx9ASJ3j79izeEunNnmRUxxFuazx+mrXhEWc=; b=GxA1RdjobvuQW+j4KRTS5eKOBT
	oRRwuVwluWoGEvC4UFZRK6Nn6th1MwgWYc6YNV69mJmBka4emmdJNrZhKJJLHd8tY2KoP4WRlTV3f
	BBzmPtRAYSwP2R/76pBET80OhELppYd2wcYuXswG6ZSn455FB7lrAethRAdWLK8Cpyoa+2WQlbPEo
	yDnBwsgq8WFAn8T5CNpn75Ln6AvN+xKZmeYTmv6osiGPlpDEEQC6KSQCJUj5W1EIa/K/oVpeYadDs
	Cd2pPkBRiUxP6IzyaYmoNbGeMMFyM1TSYyBAB61XqmRTWLJtL8+3jO08EAOcbdUEqk2CTfd7fyN3s
	+f5knpMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmYx-00000007Vbz-3wFy;
	Thu, 05 Nov 2026 01:46:47 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmYw-00000007Vbr-3B94
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 01:46:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 319C243D90;
	Thu,  5 Nov 2026 01:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1343D1F0093A;
	Thu,  5 Nov 2026 01:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793843206;
	bh=vzblkOvjx9ASJ3j79izeEunNnmRUxxFuazx+mrXhEWc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=UZNWd8YSARAred/fa/MLSDj/SgK/FWf3Qo5OvzIEmcAGruna0cpdFi4MsJQaonLA1
	 gJ+Xz3fETCxZey2Rj3CGUo1JMsCgOk58FT4WmRSFIq8aeuAtTCf/uJXTS2Ad8DsYyv
	 P0CZKFCE9MYj5g8yCvU+8D2/SMyHgdd2ho4T0W9yATREQ7pCTkmpggbB0bg2Atmgux
	 3il5Rreld193n+3PC0AUs87n2xsp4DSnrUX6WC4XtkNjFBNUG4MX1q9FjI7h5toPMs
	 xLoSLfhBLIHTCDXaRUlK69dcJlp1nH2Vv8UlMke16+iKtuVbccMrnaO/LpUYm1VWBA
	 ZB5c8P3650mjg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D0D63CE0B0B; Wed,  4 Nov 2026 17:46:45 -0800 (PST)
Date: Wed, 4 Nov 2026 17:46:45 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] srcu: Add list_splice_init_srcu()
Message-ID: <5b0e7c55-72b1-410a-982c-a62138b9e44c@paulmck-laptop>
References: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com>
 <20261104-bug-nvme-remove-ns-srcu-v2-1-feb64ecb96ca@gmail.com>
 <9f8c94ff-29e3-4ea5-b9ec-b04b2bc21b1c@paulmck-laptop>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f8c94ff-29e3-4ea5-b9ec-b04b2bc21b1c@paulmck-laptop>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: paulmck@kernel.org
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 09:14:13AM -0800, Paul E. McKenney wrote:
> On Wed, Nov 04, 2026 at 01:30:39AM -0500, Qiliang Yuan wrote:
> > list_splice_init_rcu() makes a list look empty to new readers, waits for
> > the current ones with the given sync function, and only then links the
> > entries into the new list. The sync function takes no argument, so it
> > can wait for RCU readers but not for the readers of an srcu_struct.
> > 
> > Passing synchronize_rcu() for a list read under SRCU still builds, but
> > leaves SRCU readers on the entries while the last one's next pointer is
> > moved onto the new list head. nvme_remove_namespaces() does this today.
> > 
> > Add list_splice_init_srcu(), which waits for the readers of the given
> > srcu_struct instead.
> > 
> > Cc: stable@vger.kernel.org
> > Suggested-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
> 
> I am not inalterably opposed to adding a list_splice_init_srcu(),
> especially if quite a few more users show up, but here is what I was
> expecting people to do:
> 
> 	static void synchronize_my_srcu(void)
> 	{
> 		synchronize_srcu(&my_srcu);
> 	}
> 
> 	...
> 
> 	list_splice_init_rcu(l, h, synchronize_my_srcu);
> 
> We need at least six uses of the above idiom to break even on the line
> of code required for introducing a list_splice_init_srcu().

Given Qiliang's response:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

							Thanx, Paul

> > ---
> >  include/linux/srcu.h | 36 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> > 
> > diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> > index 1a8a465a5650d..d4dcaeb83e2b6 100644
> > --- a/include/linux/srcu.h
> > +++ b/include/linux/srcu.h
> > @@ -18,6 +18,7 @@
> >  
> >  #include <linux/mutex.h>
> >  #include <linux/rcupdate.h>
> > +#include <linux/rculist.h>
> >  #include <linux/workqueue.h>
> >  #include <linux/rcu_segcblist.h>
> >  
> > @@ -118,6 +119,41 @@ void cleanup_srcu_struct(struct srcu_struct *ssp);
> >  void synchronize_srcu(struct srcu_struct *ssp);
> >  void synchronize_srcu_atomic(struct srcu_struct *ssp);
> >  
> > +/**
> > + * list_splice_init_srcu - splice an SRCU-protected list into an existing list
> > + * @list:	the SRCU-protected list to splice
> > + * @head:	the place in the existing list to splice the first list into
> > + * @ssp:	the srcu_struct that readers of @list use
> > + *
> > + * Like list_splice_init_rcu(), but wait for the SRCU readers of @list
> > + * instead of RCU ones, so that none of them can follow a next pointer
> > + * onto @head.
> > + *
> > + * Note that this function blocks, and that the caller must prevent any
> > + * other updates to @list.
> > + */
> > +static inline void list_splice_init_srcu(struct list_head *list,
> > +					 struct list_head *head,
> > +					 struct srcu_struct *ssp)
> > +{
> > +	struct list_head *first = list->next;
> > +	struct list_head *last = list->prev;
> > +	struct list_head *next = head->next;
> > +
> > +	if (list_empty(list))
> > +		return;
> > +
> > +	INIT_LIST_HEAD_RCU(list);
> > +	synchronize_srcu(ssp);
> > +	ASSERT_EXCLUSIVE_ACCESS(*first);
> > +	ASSERT_EXCLUSIVE_ACCESS(*last);
> > +
> > +	last->next = next;
> > +	rcu_assign_pointer(list_next_rcu(head), first);
> > +	first->prev = head;
> > +	next->prev = last;
> > +}
> > +
> >  #define SRCU_GET_STATE_COMPLETED 0x1
> >  
> >  /**
> > 
> > -- 
> > 2.43.0
> > 

