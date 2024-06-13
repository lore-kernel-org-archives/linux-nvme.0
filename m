Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23921C27C6E
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jun 2024 14:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ls+U8jJtBjEy+ivrQul3Y3L8Jea1Vy1Uk6m6YMwTy7A=; b=06D2DTmLmA0KGG6ZlkTU94s1lL
	Li/ZpTIWR5uQSmWHBAduobvOPgHAHTnkplQVrGnkjikGoiSFA5C/23x5sJsbUiLEKBUKlrLLG7IiL
	YqGuKxUC839lE/uedV/yvfIkAawQOW8HQGG5bJlz1DJbDoKmvU7ooyRkIZTVaOisRtu/TBCDqIvjD
	Ok3Db4pkEsnPmF3UMhpdpA3faeDmqlezcuayUd/XosolVID6Pf3ZgEDIzQac3YSTUUzW30ZvNJL4F
	ejRJ6TQ2dH0ODxN2MAFWBoEuzW5WbIS0W2KxH90RC0UNW7tvwo/siJM33+EuvX38BwFJK4IqAWw8l
	MJqqpM9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHlfw-0000000H0J3-3sRQ;
	Thu, 13 Jun 2024 14:43:40 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHlft-0000000H0FH-0Lzk
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jun 2024 14:43:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 394C061B80;
	Thu, 13 Jun 2024 14:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE122C32786;
	Thu, 13 Jun 2024 14:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718289815;
	bh=ENTr3coAsQURUsjgzm57k8qmYmYqJPesZfILsIqW9hs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=k8px7EUmjvL9L3g1sw13b1cWKwG9k2bUEtNZ3rRAi96pkn27aWBb44BxZK4vA1GHZ
	 BYd//uvON2++hb/5T6rd0VVE7Pw6AR45lCrbinXcISP/w2GBN8i30xn92uBDIjUB/7
	 TxzBxp9eJUxB1UDbT8gZEA+JC+qQNXV8+Q/KIMuos3QW0phwzJRd5s7+BJiMl6xLAF
	 1m61ir9x7Hfmm8gs57p/iftOVqB/KS32IYPP7FuXP9DznI3eVvYPb5Kyp4h3K15yws
	 s/8w9p6g0nni+YtNvy9Y/6TZejvXV5YkUfnjKhHUfmAGmwMytbAK2l+LXz3VLO79mO
	 vyPxyQ91dynkg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7A371CE09E0; Thu, 13 Jun 2024 07:43:35 -0700 (PDT)
Date: Thu, 13 Jun 2024 07:43:35 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Nilay Shroff <nilay@linux.ibm.com>, l@kbusch-mbp.dhcp.thefacebook.com,
	Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	hch@lst.de, sagi@grimberg.me, davidgow@google.com,
	akpm@linux-foundation.org, venkat88@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] list: introduce a new cutting helper
Message-ID: <31eb40f9-d68d-4348-b1fd-3cf057939297@paulmck-laptop>
References: <20240612155135.3060667-1-kbusch@meta.com>
 <f0e4c51c-8227-4f5c-876f-38fbb4a0e1bf@linux.ibm.com>
 <ZmrscxG51gFRDVlM@kbusch-mbp>
 <c475f0d8-3bc9-4d65-8fce-586f4b75b4fc@linux.ibm.com>
 <ZmsD_HDLBQAqOOU3@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmsD_HDLBQAqOOU3@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240613_074337_205332_2B78F777 
X-CRM114-Status: GOOD (  19.56  )
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

On Thu, Jun 13, 2024 at 08:36:44AM -0600, Keith Busch wrote:
> On Thu, Jun 13, 2024 at 07:11:52PM +0530, Nilay Shroff wrote:
> > On 6/13/24 18:26, Keith Busch wrote:
> > > But that's not the problem for the rcu case. It's the last line that's
> > > the problem:
> > > 
> > >  	list->prev->next = list;
> > > 
> > > We can't change forward pointers for any element being detached from
> > > @head because a reader iterating the list may see that new pointer value
> > > and end up in the wrong list, breaking iteration. A synchronize rcu
> > > needs to happen before forward pointers can be mucked with, so it still
> > > needs to be done in two steps. Oh bother...
> > 
> > Agree and probably we may break it down using this API:
> > static inline void list_cut_rcu(struct list_head *list,
> >  		struct list_head *head, struct list_head *entry, 
> > 		void (*sync)(void))
> > {
> >  	list->next = entry;
> >  	list->prev = head->prev;
> > 	__list_del(entry->prev, head);
> > 	sync();
> >  	entry->prev = list;
> >  	list->prev->next = list;
> > }
> 
> Yes, that's the pattern, but I think we need an _srcu() variant: the
> "sync" callback needs to know the srcu_struct.

Just make a helper function like this:

	static void my_synchronize_srcu(void)
	{
		synchronize_srcu(&my_srcu_struct);
	}

Or am I missing something subtle here?

							Thanx, Paul

