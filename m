Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304E9606A326
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 01:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UmmnQnUe;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C9DkfzPH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=48fhyPC/y+c8FJusEcnheL0b5UlugtkX/uQTSOjVLxQ=; b=UmmnQnUepQAsvrmKcTRZlusQZw
	IZZ31BE4kyqfAMDzrCG9urh5m8KynlZaufy0LLs/A4j5YaQWu9BbuFVx4lMmwkPbvtwU2usLg0qsx
	0EWA4j49GNXFUHgVVOIGWY+GPbcYXNmh9Of1ih0H7oVQx28R0jtg6nss0XCob7EJHMrW9wY3kEQrO
	wU5PH9VGzEPMm2xF0TOzbj/gLdLcYK5+VbVj41UDAzuk6wZDBLSUYrNUKUungzlB8VY5nZm+rvd9D
	RR7/lhRRyDYkOoSR/IfF+mgzJGh4bbtqqGMl4xvatNI9rnfIWlr8+e5GKZlBdWaUSdBVr4I15MOOG
	AVM+EviA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmWR-00000007VFH-2aBa;
	Thu, 05 Nov 2026 01:44:11 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmWP-00000007VF0-2IkK
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 01:44:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D6D73410CF;
	Thu,  5 Nov 2026 01:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F611F000C1;
	Thu,  5 Nov 2026 01:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793843048;
	bh=48fhyPC/y+c8FJusEcnheL0b5UlugtkX/uQTSOjVLxQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=C9DkfzPH4+QOF8iSJRtvwJRnu2ZulxzE7FHXcSvx5hJaM1MdmIo68jJZPqhk9Haed
	 7WmgrbLbgJpt2i6seTWX/S5VqKqP5ZR7F7VqOtMO81rc5IMtFyjHqiNSc+HS6Q71G7
	 V4og7KGDsjpL/w84CTSjUSu/ETzvqvwq35qQDuulFIRYlmjHF2zdfiNxy8GsOsvjBT
	 U/5V2tyeBA8XnRt5VNKRHDtDwd/3/pdk4lXjpto7dszSSrryjrts5jgGvUaVLjiP09
	 dvHpQ6M+6ZwYdvrEy0LFYMrRkGXztCRujcIqazgcfliiyz53cajISwtQytzQSWv2wn
	 PEv3osPWfWYSw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7EC56CE0B0B; Wed,  4 Nov 2026 17:44:08 -0800 (PST)
Date: Wed, 4 Nov 2026 17:44:08 -0800
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
Message-ID: <dfae041c-e597-45b0-a0ba-197ee7820e86@paulmck-laptop>
References: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com>
 <20261104-bug-nvme-remove-ns-srcu-v2-1-feb64ecb96ca@gmail.com>
 <9f8c94ff-29e3-4ea5-b9ec-b04b2bc21b1c@paulmck-laptop>
 <20261105012242.623962-1-odys.yuan@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105012242.623962-1-odys.yuan@gmail.com>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 08:22:42PM -0500, Qiliang Yuan wrote:
> On Wed, Nov 04, 2026 at 09:14:12AM -0800, Paul E. McKenney wrote:
> > I am not inalterably opposed to adding a list_splice_init_srcu(),
> > especially if quite a few more users show up, but here is what I was
> > expecting people to do:
> >
> > 	static void synchronize_my_srcu(void)
> > 	{
> > 		synchronize_srcu(&my_srcu);
> > 	}
> >
> > 	...
> >
> > 	list_splice_init_rcu(l, h, synchronize_my_srcu);
> >
> > We need at least six uses of the above idiom to break even on the line
> > of code required for introducing a list_splice_init_srcu().
> 
> That works for a global srcu_struct, but nvme has one per controller,
> next to the list it protects:
> 
> 	struct nvme_ctrl {
> 		...
> 		struct list_head namespaces;
> 		struct mutex namespaces_lock;
> 		struct srcu_struct srcu;
> 		...
> 	};
> 
> nvme_init_ctrl() calls init_srcu_struct(&ctrl->srcu) for every
> controller, and readers walk the list under that controller's srcu,
> e.g. nvme_wait_freeze():
> 
> 	srcu_idx = srcu_read_lock(&ctrl->srcu);
> 	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
> 				 srcu_read_lock_held(&ctrl->srcu))
> 		blk_mq_freeze_queue_wait(ns->queue);
> 	srcu_read_unlock(&ctrl->srcu, srcu_idx);
> 
> nvme_remove_namespaces() thus has to wait on the srcu of the controller
> being deleted, which a sync function that takes no argument can't get
> at.
> 
> So the choice here is between list_splice_init_srcu(), as Christoph
> suggested on v1, and open-coding the splice in nvme_remove_namespaces()
> as v1 did. Which would you prefer?

Sigh!  I hereby withdraw all objections to list_splice_init_srcu(),
and thank you for bearing with me.

(Yes, you could squirrel away a pointer to the srcu_struct structure
in the task_struct structure or some such, but that cure is worse than
the disease.)

							Thanx, Paul

