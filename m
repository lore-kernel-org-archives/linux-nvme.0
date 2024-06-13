Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F3BC27C75
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jun 2024 12:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vns6xjKXrGcJKXefj/xvXweSczLGWUv5Jl8TQiaTV0U=; b=JPzH3w5mVBZ5om5p2+b36g6CTR
	o6q603W0kQpRQ7drBp6NXtJCEudgbT47ML7D6sqOF2Qu4yJi2L/NQsTyTeo9R/VZDr+tsN1+z4+AN
	7DvNxEjfC/IR+CwurNuy0uIY0w9kfwLITKeKF7eDfDUuT9k4TRiX37DmOzfnH09GgrPoj5UBrM6hT
	QsCTxr9x03ZmuEpjv+uWOZCaWeXz9qXIkSKUIfKL8otwP9kS7L6xIKJumzgUc1eL8LL0AlDU5sOJL
	TyqBLSHYjcE/gBUo4g+eEIOHk8T4JASLEzKpeYaHg39T+ThZBpXKgJAkInbt8/O6/zthfQewh+VJm
	dKDW51ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHk0E-0000000Gaj8-0Y2r;
	Thu, 13 Jun 2024 12:56:30 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHk0B-0000000Gah9-0Jir
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jun 2024 12:56:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 428B361883;
	Thu, 13 Jun 2024 12:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A45C2BBFC;
	Thu, 13 Jun 2024 12:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718283382;
	bh=bsPL3KQAP7mYRKsmkdNID7B/zfeUGn2fmiXDfN/6S7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nQR+v4m7I9qXfqIZYmNf1l+zzpKYSFwfe105O2wE+UmX6I3Vljl8g6q1yaIjTa09Q
	 lHyY4re5v2wpkOQG6WWRVtMp/+g/7Frk4vwd5nFbgnzdnJZt39ILbiBwOyrN8XDIda
	 FPA4G8/3RTGOB8msLFSwiz5nAtnyKQqsQ8Blr/jrY+BIbtZKBNw/THboHlUc0yTWbs
	 sPvIgDFqmrKpDNkdbByQVHobIdVlz75IJ0FNpA8N8dOkTxenlEC3WjAayWMN2aTcFN
	 8Hm0w925eJ9g/SMIwsctjlSeFt0d1145cW4mey1+qqyqNgBGxYudQ1SzTMOAelx90c
	 rOqSpg33Llnjg==
Date: Thu, 13 Jun 2024 06:56:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	hch@lst.de, sagi@grimberg.me, paulmck@kernel.org,
	davidgow@google.com, akpm@linux-foundation.org,
	venkat88@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] list: introduce a new cutting helper
Message-ID: <ZmrscxG51gFRDVlM@kbusch-mbp>
References: <20240612155135.3060667-1-kbusch@meta.com>
 <f0e4c51c-8227-4f5c-876f-38fbb4a0e1bf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0e4c51c-8227-4f5c-876f-38fbb4a0e1bf@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240613_055627_219073_F6895045 
X-CRM114-Status: GOOD (  17.31  )
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

On Thu, Jun 13, 2024 at 10:26:11AM +0530, Nilay Shroff wrote:
> On 6/12/24 21:21, Keith Busch wrote:
> > +static inline void list_cut(struct list_head *list,
> > +		struct list_head *head, struct list_head *entry)
> > +{
> > +	list->next = entry;
> > +	list->prev = head->prev;
> > +	head->prev = entry->prev;
> > +	entry->prev->next = head;
> > +	entry->prev = list;
> > +	list->prev->next = list;
> > +}
> I am wondering whether we really need the _rcu version of list_cut here?
> I think that @head could point to an _rcu protected list and that's true 
> for this patch. So there might be concurrent readers accessing @head using
> _rcu list-traversal primitives, such as list_for_each_entry_rcu().
> 
> An _rcu version of list_cut():
> 
> static inline void list_cut_rcu(struct list_head *list,
> 		struct list_head *head, struct list_head *entry)
> {
> 	list->next = entry;
> 	list->prev = head->prev;
> 	head->prev = entry->prev;
> 	rcu_assign_pointer(list_next_rcu(entry->prev), head);
> 	entry->prev = list;
> 	list->prev->next = list;
> }

I was initially thinking similiar, but this is really just doing a
"list_del", and the rcu version calls the same generic __list_del()
helper. To make this more clear, we could change

	head->prev = entry->prev;
	entry->prev->next = head;

To just this:

	__list_del(entry->prev, head);

And that also gets the "WRITE_ONCE" usage right.

But that's not the problem for the rcu case. It's the last line that's
the problem:

 	list->prev->next = list;

We can't change forward pointers for any element being detached from
@head because a reader iterating the list may see that new pointer value
and end up in the wrong list, breaking iteration. A synchronize rcu
needs to happen before forward pointers can be mucked with, so it still
needs to be done in two steps. Oh bother...

