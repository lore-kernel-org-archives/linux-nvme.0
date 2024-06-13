Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3EAC27C4F
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jun 2024 14:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bTYotPHvHWVXw+fYClqVZTE0/nCfD9CSGXNMPSPSoa8=; b=bxMZ8PguPAsXOxwa2BCb3LjjPz
	gr691Mt5WMxZWzbUk89crjmEkTXyzJ3BGFWyH7tuabzneTbWfA6YzZkibpFvdNDPw6FAqTDR2Lkhd
	0L/v4de8Kb5qb0RnTecgy7CofgkiRzPAf/WS+f9LNvZ0m81z1bm3enJpx7s0lREOobOCaIzctKAiT
	oQvRifqeeXoD9MoZk8kp0ToGRQvTz+mZRzXRZlYXnXbm9RhDcg2MPXnV6tTAjnS6QKSo0LOCy9Viz
	QQT2DMFv4gSKz7AXv+vW0BUu20l3FnerrH72rPpvyhzkGD6mGNBDEuriX3b2McOYhYbJxz4U3t0Ry
	2BuQLR2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHlZL-0000000Gy7p-3c6w;
	Thu, 13 Jun 2024 14:36:51 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHlZI-0000000Gy6s-2RDg
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jun 2024 14:36:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 87C95614DB;
	Thu, 13 Jun 2024 14:36:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FE7C32786;
	Thu, 13 Jun 2024 14:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718289407;
	bh=rQcVPloL/Qc1hVR24fDLFbTfgfjeOTVGfBNjrvJqCKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tHXYhS3FyCg5LtOYUzUGQo269no97821yMFOzr5aoyMK5ag4u+Bo1AEMSPa5nmZmQ
	 /z9H8kgfXctKvahUS760ZjpZ+IwyGTma5OACP9bxYqIi9DbejHs4vIU8UHtZRe1QoI
	 tpu+04e+hBOuPqDX2xnqkKgw34Pr/+16i3R2d9FLly8qJrJkT/Ky7L/cI48MVLNc4h
	 lTx/6GIN+5/7GZmI37lEUxT/4DRtBtLXz8zbsGgabSZxEWU7610Ge69hGto9raY6uS
	 a9ajo23fKqksXsoifnMLYh8TAu0Peoc6pj7e5/JG6cEWJ8ODsVOl2NcRiLzwMyx43q
	 hz1MLElRsZvHw==
Date: Thu, 13 Jun 2024 08:36:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>, l@kbusch-mbp.dhcp.thefacebook.com
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	hch@lst.de, sagi@grimberg.me, paulmck@kernel.org,
	davidgow@google.com, akpm@linux-foundation.org,
	venkat88@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] list: introduce a new cutting helper
Message-ID: <ZmsD_HDLBQAqOOU3@kbusch-mbp.dhcp.thefacebook.com>
References: <20240612155135.3060667-1-kbusch@meta.com>
 <f0e4c51c-8227-4f5c-876f-38fbb4a0e1bf@linux.ibm.com>
 <ZmrscxG51gFRDVlM@kbusch-mbp>
 <c475f0d8-3bc9-4d65-8fce-586f4b75b4fc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c475f0d8-3bc9-4d65-8fce-586f4b75b4fc@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240613_073648_706534_235481AB 
X-CRM114-Status: GOOD (  14.86  )
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

On Thu, Jun 13, 2024 at 07:11:52PM +0530, Nilay Shroff wrote:
> On 6/13/24 18:26, Keith Busch wrote:
> > But that's not the problem for the rcu case. It's the last line that's
> > the problem:
> > 
> >  	list->prev->next = list;
> > 
> > We can't change forward pointers for any element being detached from
> > @head because a reader iterating the list may see that new pointer value
> > and end up in the wrong list, breaking iteration. A synchronize rcu
> > needs to happen before forward pointers can be mucked with, so it still
> > needs to be done in two steps. Oh bother...
> 
> Agree and probably we may break it down using this API:
> static inline void list_cut_rcu(struct list_head *list,
>  		struct list_head *head, struct list_head *entry, 
> 		void (*sync)(void))
> {
>  	list->next = entry;
>  	list->prev = head->prev;
> 	__list_del(entry->prev, head);
> 	sync();
>  	entry->prev = list;
>  	list->prev->next = list;
> }

Yes, that's the pattern, but I think we need an _srcu() variant: the
"sync" callback needs to know the srcu_struct.

