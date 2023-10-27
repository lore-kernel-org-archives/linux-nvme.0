Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 068B4C25B47
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Oct 2023 08:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fDPWeP+8yHBXuBxAVnGepX3fr+9UeDeAMbtVIcVxmuY=; b=tt+JS0Vk7kG0BBzPoKLy1PKhzk
	NuxVgNwOeP5ZPx8vseUGe9gvD0WJHjEJ1EIgYOrdkVNA2jvwNtR1u1tFkLUu604Yp7Q+8wQiKbOuT
	+7eXoGUq6szbtfQKIOz2tZPlmMGfTOXhVdHWMeiu9m1VTi1kpRpbUQXXhijymIweannahWyPjayFR
	cZvy8I+1zbVYLhf5bZe5zzXDvFTdIeFngDHSb5ZQF6w4ACzD+d+RfBJ/CIg7CXbIb3UKxhcBdMRQT
	8eZWAz4DHmhkUyJbjJ7rlqLIP1Qg9vVI+hDrQjzofVVzB+0SkKeCAd1UMc9K5rC8xb0DmKESJPYw/
	iBSVlzMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qwIEX-00FwCj-2s;
	Fri, 27 Oct 2023 08:30:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qwIET-00FwCG-30
	for linux-nvme@lists.infradead.org;
	Fri, 27 Oct 2023 08:30:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 46BB868AFE; Fri, 27 Oct 2023 10:30:05 +0200 (CEST)
Date: Fri, 27 Oct 2023 10:30:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme: keyring: fix conditional compilation
Message-ID: <20231027083003.GA17042@lst.de>
References: <20231026130804.142586-1-hare@suse.de> <20231026130804.142586-3-hare@suse.de> <b138c4c5-9b49-4338-a79a-2f77a13381e8@app.fastmail.com> <d497429d-a1a2-4bf4-a958-3865294d9f2e@suse.de> <20231027052118.GB7885@lst.de> <78d1b4e3-4bce-4cbb-8ebe-8eb3f0fe9930@suse.de> <468cd6c9-c541-47ea-a2bc-f6cd09155351@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <468cd6c9-c541-47ea-a2bc-f6cd09155351@app.fastmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231027_013018_117262_69DB689A 
X-CRM114-Status: GOOD (  16.86  )
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

On Fri, Oct 27, 2023 at 10:12:11AM +0200, Arnd Bergmann wrote:
> > In principle. Unfortunately I have to initialize the keyring, and that
> > can be done only once.
> > I see if I can come up with a different solution.
> 
> If the keyring has to be initialized first, I think the safest
> way is to move it to a different initcall level, to avoid
> relying on link order for the everything-built-in case.

I don't really mind the link order, for these cases I usually add a
comment to the Makefile so that people don't accidentally change it.

