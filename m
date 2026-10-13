Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A2ECC6B0E
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 14:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=CyySMxnhWDxY7VZwlxuiQkqP4f
	hPri3vsN9R1Tdsw1E11/5l0wOyCrynMsjsC6I3nFCzM0hPlQByvV+Fynhz10uSf8Px9cG0JOt80mf
	CiKVl6Af7CSMUgMY33qfee34M4ingpxs6D7Sig98VfUjtSzlNKylZutEC9H0yHbapuD0tBJtAfaO7
	XP7jOPn+FmeC528NRQnoU3+K38rR4NfttaQoszxpDjhKmGNwkl7owWaY62SE2/XKTHsQgAmGf/N0L
	QcTwCmLMjlgYfSHC2W8at5JHyxbTAMh0VOBh8Zwub22SORXlZCgROwJ1UUiHlAXsWHksUSHh/KGfD
	/0WeQfuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdbD-0000000D7k4-2ZhQ;
	Tue, 13 Oct 2026 14:35:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdb8-0000000D7iU-2Vll
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 14:35:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5D882227A88; Tue, 13 Oct 2026 16:35:19 +0200 (CEST)
Date: Tue, 13 Oct 2026 16:35:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme-rdma: don't complete a request after a bogus
 remote invalidation
Message-ID: <20261013143519.GA15717@lst.de>
References: <20260928153811.1466359-1-yhlee@isslab.korea.ac.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928153811.1466359-1-yhlee@isslab.korea.ac.kr>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_073524_944504_90F50E82 
X-CRM114-Status: UNSURE (   8.96  )
X-CRM114-Notice: Please train this message.
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


