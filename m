Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562CEC43334
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jun 2022 14:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U1pdcGo3GyG/7HmkfoCuJZjNBTG1r81WK1/lidx8KbM=; b=bZGL+FoK8Vv7WEofPh3P9CZLwh
	bxj7WFvzGmIuYKw+Oc8ABiiXvGZC4o0gaIXvTRCgBVVRItC+km+VmIGywlAFxh56ujpPZ3z2AGy9+
	LlPoOlcdt5dIyxwI9Mk9hBkx7rzK32QifDMKokjzgW6wsiw17w7Bi+bn9G5659C93xqVBLYJ/X0+a
	hSaKOxRMANUK3VdatYOYhU9UxEq3fjwoar4QFrcoH4yRyE3waco+H74DaaKakMPoUnthBbJIzRzIg
	pd+230IP9FL68MFfLaCXu7Vct8TOpOibgC07P1lVYEGCh+OMyN8GegSz07c7n+zKEQVewWQwGSZCb
	7uiAksbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyaRQ-0088vj-8C; Tue, 07 Jun 2022 14:44:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyaRM-0088uS-KS
	for linux-nvme@lists.infradead.org; Tue, 07 Jun 2022 14:44:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1AB7767373; Tue,  7 Jun 2022 16:44:10 +0200 (CEST)
Date: Tue, 7 Jun 2022 16:44:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@fb.com>,
	linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: Re: [PATCH] nvme: add bug report info for global duplicate id
Message-ID: <20220607144409.GA10262@lst.de>
References: <20220606164047.2549647-1-kbusch@fb.com> <20220607101526.GA23753@lst.de> <Yp9fUSEmf3hAoRfp@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yp9fUSEmf3hAoRfp@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220607_074416_853380_1F4AE366 
X-CRM114-Status: GOOD (  14.74  )
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

On Tue, Jun 07, 2022 at 08:23:13AM -0600, Keith Busch wrote:
> > So I like the idea here, but this won't give us the PCI device id
> > that we usually need for quirks.
> 
> Yeah, we don't have the DID from core. Should I add a driver specific op to
> print device info? Just a quick rough idea here:

Yes, something like this looks reasonable to me.


