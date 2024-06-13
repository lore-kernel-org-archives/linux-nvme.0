Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231ACC27C4F
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jun 2024 15:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ye2SwKqjalo3BdZfinz8UwdNApxCG7QFzvAcsi4bn4M=; b=fCwfRpuUYFExI1V+ADWRlafEhM
	O8+t8FemEkS8ysq7ng1WSTNeEMgK0ukEvWHixoYJBwZRdgULJp62SQSn2fZW+XR2M8xHzp8IiJn3M
	X13HCDXYAhWP6WV7Ol6ERksTsoqNGmbVAf4+Jn+wiShdRz/ofUdYwIab5Ra/pF7QdjcnT9nH3t/Nq
	075Waot8bjXjIVlirWuuRkuPvThu/HJA3rbHx4nEc9rjImXKy5nZuTrXOtZDeHcg/ePpFWMucX3PA
	KkUHOReDIpBPvYOA1pkyua86EtwtYdsOL710OUscBmLKcxqYt2RkYFRX28n0uckiyGrKqJvHyJX9M
	j1/4aw1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHmAQ-0000000H7Sx-2Ry6;
	Thu, 13 Jun 2024 15:15:10 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHmAN-0000000H7S9-37sg
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jun 2024 15:15:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1279761B7A;
	Thu, 13 Jun 2024 15:15:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50FFC2BBFC;
	Thu, 13 Jun 2024 15:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718291706;
	bh=UGMX7r3y2vc+BLuaUSO5ILKzqK/XETMaB5uPu6PRr3g=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=EwAN4M93i2dFJki3F5pcLJc6uuL+sJS9K7MXJLvgZ2k6DzvdIpbtrxtMqZJ9DvrUB
	 881zQ3MCgC6R8fbZpS8JMN1ZjzU7q7PgadbcVz0OdO7YzZnRWrhfcNMsBTVBFYS0z+
	 2BjP51fIR79iZguOf2FGkz5qgal1fe3OHdqYxrPhX194rXpq3zbBp4wSCXKoUXWU1e
	 yX648Xg3a0oUQ6yzhPcCC6olYDGEwKufbPD2grtx3ELXpRWBe/IjVQZG7RDD/khSBK
	 K1h8dNbpzH6dAsLVk+c98VnceU2FWVHdDCPQPXZ2lAjppW8C1bkmsFzESVjgrvm00R
	 QOVpTfolzKmjg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5C7B0CE09E0; Thu, 13 Jun 2024 08:15:06 -0700 (PDT)
Date: Thu, 13 Jun 2024 08:15:06 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Nilay Shroff <nilay@linux.ibm.com>, l@kbusch-mbp.dhcp.thefacebook.com,
	Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	hch@lst.de, sagi@grimberg.me, davidgow@google.com,
	akpm@linux-foundation.org, venkat88@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] list: introduce a new cutting helper
Message-ID: <73b994eb-c689-48e0-b09c-a414041a0525@paulmck-laptop>
References: <20240612155135.3060667-1-kbusch@meta.com>
 <f0e4c51c-8227-4f5c-876f-38fbb4a0e1bf@linux.ibm.com>
 <ZmrscxG51gFRDVlM@kbusch-mbp>
 <c475f0d8-3bc9-4d65-8fce-586f4b75b4fc@linux.ibm.com>
 <ZmsD_HDLBQAqOOU3@kbusch-mbp.dhcp.thefacebook.com>
 <31eb40f9-d68d-4348-b1fd-3cf057939297@paulmck-laptop>
 <ZmsGfle1aZQauzRb@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmsGfle1aZQauzRb@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240613_081507_892308_F34F1C46 
X-CRM114-Status: GOOD (  25.87  )
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

On Thu, Jun 13, 2024 at 08:47:26AM -0600, Keith Busch wrote:
> On Thu, Jun 13, 2024 at 07:43:35AM -0700, Paul E. McKenney wrote:
> > On Thu, Jun 13, 2024 at 08:36:44AM -0600, Keith Busch wrote:
> > > On Thu, Jun 13, 2024 at 07:11:52PM +0530, Nilay Shroff wrote:
> > > > On 6/13/24 18:26, Keith Busch wrote:
> > > > > But that's not the problem for the rcu case. It's the last line that's
> > > > > the problem:
> > > > > 
> > > > >  	list->prev->next = list;
> > > > > 
> > > > > We can't change forward pointers for any element being detached from
> > > > > @head because a reader iterating the list may see that new pointer value
> > > > > and end up in the wrong list, breaking iteration. A synchronize rcu
> > > > > needs to happen before forward pointers can be mucked with, so it still
> > > > > needs to be done in two steps. Oh bother...
> > > > 
> > > > Agree and probably we may break it down using this API:
> > > > static inline void list_cut_rcu(struct list_head *list,
> > > >  		struct list_head *head, struct list_head *entry, 
> > > > 		void (*sync)(void))
> > > > {
> > > >  	list->next = entry;
> > > >  	list->prev = head->prev;
> > > > 	__list_del(entry->prev, head);
> > > > 	sync();
> > > >  	entry->prev = list;
> > > >  	list->prev->next = list;
> > > > }
> > > 
> > > Yes, that's the pattern, but I think we need an _srcu() variant: the
> > > "sync" callback needs to know the srcu_struct.
> > 
> > Just make a helper function like this:
> > 
> > 	static void my_synchronize_srcu(void)
> > 	{
> > 		synchronize_srcu(&my_srcu_struct);
> > 	}
> > 
> > Or am I missing something subtle here?
> 
> That would work if we had a global srcu, but the intended usage
> dynamically allocates one per device the driver is attached to, so a
> void callback doesn't know which one to sync.

Ah, good point!  I suppose that a further suggestion to just JIT the
needed function would not be well-received?  ;-)

I cannot resist suggesting placing a pointer to the srcu_struct in
the task structure.  /me runs...

Perhaps somewhat more constructively, my usual question:  Is it really
necessary to have per-driver SRCU here?  What would break if there was
a global srcu_struct that applied to all drivers?

						Thanx, Paul

