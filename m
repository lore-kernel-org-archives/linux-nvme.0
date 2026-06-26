Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B81BC43458
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 18:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uORHkl8NUV5fi96qCfKZFnoCayWmwU9pFoSiY0Pe6b4=; b=3T2fDt1p3fvbb5J9K1o4Fuy0Ld
	Te5LsPyMmvhe1gqKpmj9nsvzmjOSnOiBmgn2RWM35/hwXqyagu8p7EUf2Vn3nkEcDNaAf3ePSAOLP
	vzoZ5/mo+8N473yBaPt71VZEW8IehFDJIyZZ5d5HCvNaJd9xSNHmn4akD0CyERSqQn/oUN3eB1N8L
	aUAa8hMKUjUoHteXUl9xNWutF0RJdj/MeM6Mzg7FN/erFAOSjAFK+pyMl7j6movRfSfBW4bBH7PBf
	81sM9wVmD54CJLeqhkmu//gBgdhtww+5SmQTByMyw8lbYHRsv+hCyL7vi+2UyEW8Coqd2sKLNLAEF
	d6qgASoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdBPo-0000000BlFg-06K6;
	Fri, 26 Jun 2026 18:36:36 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdBPi-0000000BlFZ-1YsM
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 18:36:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 74F8E601EB;
	Fri, 26 Jun 2026 18:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A101F000E9;
	Fri, 26 Jun 2026 18:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782498989;
	bh=uORHkl8NUV5fi96qCfKZFnoCayWmwU9pFoSiY0Pe6b4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=iUyGrQ5GyHcrug2qiwFxXlEWpRxVYFxYXoVGJxBaybYtXM4fq6lGjrH4gzKzvfOOX
	 riyW5k2LFlQFruzASvDGj/KCx+sZO5mcbIPElRkF9OsxN7KqvmRdbWxWA5S2HKZsCf
	 xM1p5JhNADxM5LAzL6xrnpEtePlHIVrYEncmpxj2023jMJdfvvQmArFEV9XsBIgL3V
	 dqpon5I0ZWDMEXFpHz3pwO/lDqh17pHAXmKwhu+4iofaWHDhaQ6wyKNBMyqMe5GoA9
	 eA5MUY7pKSHM5nHVVAfgxfRW0LBjgjldj7ZuxoeBfk1MXec+y8ah1SgTEReE+7jj09
	 R7fYgX3TwCOmg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E233CCE0A6F; Fri, 26 Jun 2026 11:36:28 -0700 (PDT)
Date: Fri, 26 Jun 2026 11:36:28 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, kbusch@kernel.org, sagi@grimberg.me,
	axboe@fb.com, bvanassche@acm.org, elver@google.com,
	gjoyce@linux.ibm.com
Subject: Re: [PATCHv2 05/17] nvme: add Clang context annotations for
 nvme_ns_head::current_path
Message-ID: <e1c60afc-423b-47ec-9c38-db1397d8838f@paulmck-laptop>
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
 <20260614131541.2017845-6-nilay@linux.ibm.com>
 <20260626064050.GE10731@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626064050.GE10731@lst.de>
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

On Fri, Jun 26, 2026 at 08:40:50AM +0200, Christoph Hellwig wrote:
> On Sun, Jun 14, 2026 at 06:45:20PM +0530, Nilay Shroff wrote:
> > +++ b/drivers/nvme/host/multipath.c
> > @@ -231,8 +231,16 @@ bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
> >  	bool changed = false;
> >  	int node;
> >  
> > +	/*
> > +	 * This helper is used by namespace failover/teardown and I/O policy
> > +	 * update paths. We only compare the head->current_path[] pointer value
> > +	 * and do not dereference the referenced namespace, so suppress the
> > +	 * context analysis warning for this lockless inspection of the
> > +	 * __rcu_guarded pointer.
> > +	 */
> >  	for_each_node(node) {
> > -		if (ns == rcu_access_pointer(head->current_path[node])) {
> > +		if (context_unsafe(ns ==
> > +				rcu_access_pointer(head->current_path[node]))) {
> 
> I think we need a helper for this, as for a simple pointer value
> comparison without a dereference we don't really need either
> rcu_access_pointer nor locking.
> 
> Maybe somthing like a
> 
> 	rcu_compare_pointer(rcu_pointer, nonrcu_pointer)
> 
> ?

We could provide something like this:

#define rcu_compare_pointer(rcu_pointer, nonrcu_pointer) \
	context_unsafe(rcu_access_pointer(rcu_pointer) == (nonrcu_pointer))

Or maybe rcu_pointer_equals()?

Marco, thoughts?

							Thanx, Paul

