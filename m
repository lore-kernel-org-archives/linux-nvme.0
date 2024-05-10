Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA735C25B10
	for <linux-nvme@archiver.kernel.org>; Fri, 10 May 2024 23:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1bK5po7ozuM/Kuo0oGkyZOlLv+PYx/iiGbhInJnVwdA=; b=1fkOQ4lh4epnLY8c0hH08JcXAs
	4BIRoJ2VBjfgS4cJjPn2YBNyEPfpNI6Z9nCFINvvDv6nP0YFZhe5mB8wWmslp27UZAvlQzh/R5mVA
	2yfYwKywwDrCo0L7IXkxICmdPoqez/JnfMCvF0NTaxRZZO2aAIwRKsBecREqT2zWD6ye9srjJ379n
	FaMyXkMRi9hgG0k+Lq4fNvA5q/OpG0ByF9pqYEZ0MyyxdjETnt04kRrwZQgVBzM7n3agWK59BV0rr
	dVguBuZhw/VI7Md63Uvl/cSIrkNIe4NC+9Ti5TxOIw1jUTUEDj16zqJowgc6EpuldTXUCN+Iin+Z0
	wO7MEKcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5Zlm-00000006nsd-2GeM;
	Fri, 10 May 2024 23:35:18 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5Zll-00000006nsP-07z7
	for linux-nvme@bombadil.infradead.org;
	Fri, 10 May 2024 23:35:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1bK5po7ozuM/Kuo0oGkyZOlLv+PYx/iiGbhInJnVwdA=; b=beYW8OFK/Evctd/o1bZL3U9Nm8
	eTSCiYPQqxLCU1h/G8tCvycJePPmvBYGglYEDiNevh5sKgLKieS129opY6Ck8TF9CDSCDMSEJPel0
	bVAtiaFcE0Xv2YksM9VKIEZ2NEPLFTYzF94iXWMJQOKY2zW9hYG7SNXbCkeWRRB9aDSYRfnFtRfPF
	M2ZnlEJ6OJBvh+7QK1n9JfCQWg8J4hGeU5ggnA5OhHq5+MyjCOKlg7BSYeae+ZkuOKD0UWj+RbVxR
	T4M784Cs74UPa92oqIn+T3p08orz2S1xDEmWqBsl8LdLhF6SX+AyFp8RA49VdyVPktQ/UB/eA/VR6
	o+JWQMMg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5Zlf-00000004Asp-3pUw;
	Fri, 10 May 2024 23:35:12 +0000
Date: Sat, 11 May 2024 00:35:11 +0100
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	bpf@vger.kernel.org
Cc: lsf-pc@lists.linux-foundation.org
Subject: Re: [LSF/MM/BPF TOPIC] Running BOF
Message-ID: <Zj6vL2FgUh3tbmBu@casper.infradead.org>
References: <ZiAATJkOF-FulDyS@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiAATJkOF-FulDyS@casper.infradead.org>
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

On Wed, Apr 17, 2024 at 06:01:00PM +0100, Matthew Wilcox wrote:
> As in previous years, I'll be heading out for a run each morning and I'd
> be delighted to have company.  Assuming our normal start time (breakfast
> at 8am, sessions at 9am), I'll aim for a 6:30am start so we can go
> for an hour, have half an hour to shower etc, then get to breakfast.
> We'll meet just outside the Hilton main lobby on Temple Street.

Our start time has been pushed back by half an hour this year (breakfast
at 8:30, sessions at 9:30), so let's start the run half an hour later.
And the street name needs a little disambiguation; there are North,
South, East and West Temple Streets ;-)

So, we will meet at West Temple Street & Pierpont Ave at 7am.  I have
a certain amount of route scouting done, and we can negotiate where we
go each day.  I'll be wearing a red t-shirt and black shorts.

> I don't know Salt Lake City at all.  I'll be arriving a few days in
> advance, so I'll scout various routes then.  It seems inevitable that
> we'll head up Ensign Peak one day (6 mile round trip from the Hilton
> with 348m of elevation) and probably do something involving City Creek /
> Bonneville Boulevard another day.  If anyone does know the various trails,
> I'd be delighted to listen to your advice.

Ensign Peak was muddy when I went up on Wednesday and not very fun.
It's also more of a hike than a run.  Now, it had been raining/snowing
on Tuesday, so it may have dried out by the time we want to go up.

