Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA08BC36002
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Apr 2025 08:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xw8SspXYGS/wndTP2TkCQz7bG5o/gqPFuW2DGjtO8FU=; b=Is7Ox9njm9d9/buNvJKjj2qNVE
	a2fhEHE/tL/V2ZcV/ZApGr7TqaTOGwfEWrcmw6T8FX/ueNwie2rwBTZ2TsLIKMsBMZamSP0CADKIu
	47jl5ZsdEwc6myjyO/qzUk5Q3BBb3+gYLikJhmrnSY1fG4j5FSFPBK9AoWCaUadFsDR7IBUZVARHs
	0CZdqdKLqCdxd3zBLMyIaXnTCkLewZ0bAuHfF3not4NhNAtV7pcqUCb1G3habTYgxD0wydf2tK07j
	Do2DAdLQyr+DwblcoQH71nmRiBmRtWJl26iOI1kgcwc8jAbC3P0vFlkQnW3iEdRMVJppU3BUyNVYt
	ubL3gE0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2R3N-00000006cpP-0NH2;
	Wed, 09 Apr 2025 08:45:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2R3K-00000006coG-1p0l
	for linux-nvme@lists.infradead.org;
	Wed, 09 Apr 2025 08:44:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7E47168AA6; Wed,  9 Apr 2025 10:44:46 +0200 (CEST)
Date: Wed, 9 Apr 2025 10:44:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Peijie Shao <shaopeijie@cestc.cn>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: Fix use-after-free of netns by kernel TCP
 socket.
Message-ID: <20250409084446.GA2771@lst.de>
References: <20250408224105.2344-1-kuniyu@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408224105.2344-1-kuniyu@amazon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_014458_753601_DA4545C9 
X-CRM114-Status: GOOD (  12.34  )
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

Thanks, applied to nvme-6.15.

> To fix such problems, let's hold netns ref by sk_net_refcnt_upgrade().
> 
> We had the same issue in CIFS, SMC, etc, and applied the same
> solution, see commit ef7134c7fc48 ("smb: client: Fix use-after-free
> of network namespace.") and commit 9744d2bf1976 ("smc: Fix
> use-after-free in tcp_write_timer_handler().").

I wish the netns APIs would be a little more robus to prevent these
bugs from creeping in everywhere..


