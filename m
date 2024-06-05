Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3FAC27C53
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 07:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8LUykD/62bGMRfd/a9I1PHICud17UdPvZyyzW9ay8wM=; b=kBhJjpGtIgXYVkpxntHxoHrt+j
	8o684NIYzgilW6WwO3Vflq7l0GyHQXpbetEyh5gQojYe2ulgyv9dlqStK00tXB1PQK235xxsLAr+L
	GgJ/f9SPtTXC9caL76SEA5Ehy6KIGMMFgbqf8VW0La66+0tueV9LDymdj7aQkD3tbshF9gc+/iB4w
	cFOd1bEleh8H7GIb4YC+2eqjBqEW5fLinL4M0H9ZKwHfPo1DDMySu8h2hajJ3BWpB3Sc4kyzrZJnF
	bn6AxrQi2DUf/G+2ny9SsOA7hkHB/Hg7iVwAFziP6KupXacisJTGHF+2kMyvrKH6hjiiFyYD6ARXY
	fy3d8UEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEl3m-000000050AR-16my;
	Wed, 05 Jun 2024 07:27:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEl3i-0000000509F-37xd
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jun 2024 07:27:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6002E68D0D; Wed,  5 Jun 2024 09:27:43 +0200 (CEST)
Date: Wed, 5 Jun 2024 09:27:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Ofir Gal <ofir.gal@volumez.com>,
	davem@davemloft.net, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	ceph-devel@vger.kernel.org, dhowells@redhat.com,
	edumazet@google.com, pabeni@redhat.com, kbusch@kernel.org,
	axboe@kernel.dk, sagi@grimberg.me, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com,
	idryomov@gmail.com, xiubli@redhat.com
Subject: Re: [PATCH v2 0/4] bugfix: Introduce sendpages_ok() to check
 sendpage_ok() on contiguous pages
Message-ID: <20240605072742.GA16306@lst.de>
References: <20240530142417.146696-1-ofir.gal@volumez.com> <20240531073214.GA19108@lst.de> <20240601153610.30a92740@kernel.org> <20240604043041.GA28886@lst.de> <20240604074224.44668dab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604074224.44668dab@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_002747_077042_41EDC736 
X-CRM114-Status: GOOD (  11.96  )
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

On Tue, Jun 04, 2024 at 07:42:24AM -0700, Jakub Kicinski wrote:
> I'd guess the thinking was that if we push back the callers would
> switch the relevant allocations to be page-backed. But we can add
> a comment above the helper that says "you'd be better off using
> page frags and calling sendmsg(MSG_SPLICE_PAGES) directly".

That's just not how network block devices or file systems work, they
don't control the allocations and need to take what gets fed to them.

