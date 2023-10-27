Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA9BC25B47
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Oct 2023 05:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CU/hrZCmyP7/rDRYrSuHFtS7uN9bEnPWtIo5RDKsd4Q=; b=3PTxspLdvsHBUC39D+FEe8P+BX
	QyTmc3GCr8Z9D2Tvk1mpAV864tcET7w0rFs9OnnvMJc0lip2j5mEaWlhuMLwWTP72ZrZKJ1yt7BYY
	ole+Y8QZg3g6QZ5/gKnRTjBFKHwH9nvZjt35mKzk8IU5ozIPtpy87MMyobYnhGVOWCdt9gQV97KSw
	VeiHroDrPBq1uvOY+cUQtshkzg5k7bxGsVBukW4L9oQ2wDApSfkiQ5MaUHoV9f2z0O2iwTuQny8RI
	BpoFFoSu2Ca8qTKmfwlhKgPIOZIx2TZJMSQYqjruTOQ5y4QBW68hj6VB6TR+2RY7pDOtnAxjTYMyb
	htHIXc4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qwFHh-00FcAq-18;
	Fri, 27 Oct 2023 05:21:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qwFHe-00FcAQ-0K
	for linux-nvme@lists.infradead.org;
	Fri, 27 Oct 2023 05:21:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8FEE568AFE; Fri, 27 Oct 2023 07:21:18 +0200 (CEST)
Date: Fri, 27 Oct 2023 07:21:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme: keyring: fix conditional compilation
Message-ID: <20231027052118.GB7885@lst.de>
References: <20231026130804.142586-1-hare@suse.de> <20231026130804.142586-3-hare@suse.de> <b138c4c5-9b49-4338-a79a-2f77a13381e8@app.fastmail.com> <d497429d-a1a2-4bf4-a958-3865294d9f2e@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d497429d-a1a2-4bf4-a958-3865294d9f2e@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231026_222122_320120_0FA446CA 
X-CRM114-Status: GOOD (  16.09  )
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

On Thu, Oct 26, 2023 at 04:20:12PM +0200, Hannes Reinecke wrote:
> Host Target Keyring
> n    n      n
> n    m      m
> n    y      y
> m    n      m
> m    m      m
> m    y      y
> y    n      y
> y    m      y
> y    y      y
>
> So we're correct in 75% of all cases :-)
> And before we trying to figure out some weird complex kconfig syntax
> to get all cases correct I prefer the easy solution.
> Plus it has the benefit that the keyring is avialable right from the
> start, so you can pre-provision keys even before nvme is loaded.

in the 75% of cases that don't really matter, as 99% of all setups
have nvme and nvmet built modular, and for that you now build code
into the kernel for no good reason at all.

FYI, what's I've done a lot in the past for such simple helper is
to not have a Kconfig symbol at all, but let the Makefile handle
it.

A

obj-$(CONFIG_MOD1)	+= mod1.o mod-common.o
obj-$(CONFIG_MOD2)	+= mod2.o mod-common.o

will actually do the right thing here without much complicated
boilerplate.


