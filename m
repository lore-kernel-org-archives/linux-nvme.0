Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD53C27C4F
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jun 2024 14:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wc+jXIVQJElTMxNHiUbAqz4/Ftbxlk2tFxkJaaD93i4=; b=bRYTSpMy1XbZZt9xK8SR6+6OhL
	uUO7V/j6RDneOif/KJIEJWU+G2aIli3qcMyKyYaTtegwZOGBnN2Q7HmuzOLDVPX5Q6Kd3fxiNZn6r
	/cX8zRzRloG7p84vUyZRqbZVrHkukekso8Ls66f8nXqZM5bms8qFi9ESM/V3Qgip/ZPz+TIjE5tPQ
	TTawF7KV4aggSMAw7rkEHxDO8UBsDd+1Fbz9p4WJaWuQk1dH9j7SZ+3KvfnTglLEMwZnjSx0u63nU
	NmVXChcCK29KpomSkdcyF8m6loSTx+iZ7iTDIk2uegp01hC5dxwJ3R65sQ+Wt54jLu2cJ11N1yXuC
	g++vUSmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHljl-0000000H1So-4956;
	Thu, 13 Jun 2024 14:47:37 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHljj-0000000H1Pc-0DdW
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jun 2024 14:47:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 02E66CE2630;
	Thu, 13 Jun 2024 14:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B95C32786;
	Thu, 13 Jun 2024 14:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718290049;
	bh=kjzDGOG2YXMGDf6L85vqKWOLSBd/y+drS146eunQElM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hwg5ghc1ZNz7jjOf9igMuFsFU/zOhkMsDbUhpJuEz1nr7Kc/Za+nMY6fXggf3SUpM
	 aw4j3b1+5GyFLkQbWkbTwfU4JCH1+A1gzgCGjBix+eoShbE1qQ9cKf3DXgGVLEMEWT
	 q2VMZhj08lzDgA9MhyvRLAJezfO+L4uIt36v8Vb4XKEHKdGMJ1sHUuw/LDN0OL90nF
	 6UHNs/m9UjwnmOTm6RDX6OV5Gt8slm8BaGAQA3wqhADtRX6EQpY+FWHBfZUEKEEz3E
	 VD/k6HAMaurA3jcAjhGup1iAsq4POeoJIX/nnOC73+DtUIgiCHUdzf3LTY7oUCUgMx
	 nBZU+XpGCVEGw==
Date: Thu, 13 Jun 2024 08:47:26 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Nilay Shroff <nilay@linux.ibm.com>, l@kbusch-mbp.dhcp.thefacebook.com,
	Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	hch@lst.de, sagi@grimberg.me, davidgow@google.com,
	akpm@linux-foundation.org, venkat88@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] list: introduce a new cutting helper
Message-ID: <ZmsGfle1aZQauzRb@kbusch-mbp.dhcp.thefacebook.com>
References: <20240612155135.3060667-1-kbusch@meta.com>
 <f0e4c51c-8227-4f5c-876f-38fbb4a0e1bf@linux.ibm.com>
 <ZmrscxG51gFRDVlM@kbusch-mbp>
 <c475f0d8-3bc9-4d65-8fce-586f4b75b4fc@linux.ibm.com>
 <ZmsD_HDLBQAqOOU3@kbusch-mbp.dhcp.thefacebook.com>
 <31eb40f9-d68d-4348-b1fd-3cf057939297@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31eb40f9-d68d-4348-b1fd-3cf057939297@paulmck-laptop>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240613_074735_624886_764793A9 
X-CRM114-Status: GOOD (  20.99  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jun 13, 2024 at 07:43:35AM -0700, Paul E. McKenney wrote:
> On Thu, Jun 13, 2024 at 08:36:44AM -0600, Keith Busch wrote:
> > On Thu, Jun 13, 2024 at 07:11:52PM +0530, Nilay Shroff wrote:
> > > On 6/13/24 18:26, Keith Busch wrote:
> > > > But that's not the problem for the rcu case. It's the last line that's
> > > > the problem:
> > > > 
> > > >  	list->prev->next = list;
> > > > 
> > > > We can't change forward pointers for any element being detached from
> > > > @head because a reader iterating the list may see that new pointer value
> > > > and end up in the wrong list, breaking iteration. A synchronize rcu
> > > > needs to happen before forward pointers can be mucked with, so it still
> > > > needs to be done in two steps. Oh bother...
> > > 
> > > Agree and probably we may break it down using this API:
> > > static inline void list_cut_rcu(struct list_head *list,
> > >  		struct list_head *head, struct list_head *entry, 
> > > 		void (*sync)(void))
> > > {
> > >  	list->next = entry;
> > >  	list->prev = head->prev;
> > > 	__list_del(entry->prev, head);
> > > 	sync();
> > >  	entry->prev = list;
> > >  	list->prev->next = list;
> > > }
> > 
> > Yes, that's the pattern, but I think we need an _srcu() variant: the
> > "sync" callback needs to know the srcu_struct.
> 
> Just make a helper function like this:
> 
> 	static void my_synchronize_srcu(void)
> 	{
> 		synchronize_srcu(&my_srcu_struct);
> 	}
> 
> Or am I missing something subtle here?

That would work if we had a global srcu, but the intended usage
dynamically allocates one per device the driver is attached to, so a
void callback doesn't know which one to sync.

