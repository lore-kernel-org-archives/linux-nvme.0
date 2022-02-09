Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85F5C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Feb 2022 08:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=palPPAJzZ7gMiogxgqBufuAfFMfVWYID9QitZndl36s=; b=v5ojEGqqk69ZJ13rxXYHFd5WwI
	hsN3AJqoSO/Z12FP2zQlsBUKbJw5UelImb3AFvqIf51WUDMHGHcADe3LS3au17j2DS3RGPNz52yCR
	oNOwrigCQsEOnX6JYPOhwdelr2wjkeO6eGoYI46hLHb/06sLK9zPAK6dsOxoFOfPI2JKdq9tqMM/s
	0p2KtOEAUJJEGu63M1iw/Dx9qi/2zRB4bfm0oujq10nynPFoUheAAhQUMHlUZ7RaiNZHaImQeMjGs
	UA8ngisjIQher9JwIjA7lqEdrUQIz7RYrvRtdGr+wRElKhcX9+H0sL55usqsUEWOn94AztckTNEqa
	FXcJDdUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHi15-00Ga7K-60; Wed, 09 Feb 2022 08:07:55 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHi11-00Ga6E-OX
 for linux-nvme@lists.infradead.org; Wed, 09 Feb 2022 08:07:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D9A6F68AFE; Wed,  9 Feb 2022 09:07:47 +0100 (CET)
Date: Wed, 9 Feb 2022 09:07:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-multipath: add an 'ana_groups_only' module option
Message-ID: <20220209080747.GA9851@lst.de>
References: <20220207100005.34404-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207100005.34404-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220209_000751_981406_48B8CAD4 
X-CRM114-Status: GOOD (  17.56  )
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

On Mon, Feb 07, 2022 at 11:00:05AM +0100, Hannes Reinecke wrote:
> On large installations the ANA log buffer can be exceedingly large;
> we've come across a controller with 49 ANA Group Descriptors and
> 65536 namespaces, resulting in an ANA buffer with an order-7 allocation.
> And this is just to validate that the namespace ID is _really_listed
> in the log page.
> So to avoid an overly large memory allocation we can leverage the
> 'RGO' bit when retrieving the ANA log page, and check whether the
> ANA group ID from the namespace is found in the ANA descriptors.
> That cuts down the memory allocation, and provides the same result.
> But to be on the safe side I've added a module option 'ana_groups_only'
> to switch between modes.

How is this supposed to work?  We'll fail to see what namespaces
the change applies to.

So in doubt fix the controller config to be less broken (and say hello
to NetApp and explain them they do not need more namespace for more
performance), and if that fails switch to a vmalloc allocation for
the buffer.

