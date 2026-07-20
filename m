Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1FFC44515
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2026 14:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Q8G7XCzmSMa4eQsGGnUYfsZlII
	YH7CfENS+UbojSrBuBHIrCZGO8k9b9gNjbIXVe2fKBvFW8y/XFiEeBxjYCUqApl6mKDBeEHl386Ay
	7WRpUyWl2QRn2p9QRaiA5K2y7bV3KssSrZIciqXYgYGjde/y6DZS62nWtucd3VF82sGiv8Jwm8ISq
	ErtYowzNP6UyBre+G69KQ8AeAUESYvqoaMDwlq9XDNSc7yrWVF427JbLARyX2LAB1hAAjbVjuOVc3
	gDV9gSkpbjcHh8NhypdXbmwhzHx+IQ2J/5CMNzommvVCNuMqOxN0Yh8Hwxth5aEMdA63SwLwkMY7B
	kzUjAB5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlpMW-000000072Oe-1wgI;
	Mon, 20 Jul 2026 14:52:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlpMT-000000072OC-46r5
	for linux-nvme@lists.infradead.org;
	Mon, 20 Jul 2026 14:52:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C4B7468C4E; Mon, 20 Jul 2026 16:52:49 +0200 (CEST)
Date: Mon, 20 Jul 2026 16:52:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] nvme-pci: disable controller on admin queue IRQ setup
 failure
Message-ID: <20260720145249.GA17728@lst.de>
References: <20260715074459.50760-1-mhun512@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715074459.50760-1-mhun512@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_075254_186785_2D7401BF 
X-CRM114-Status: UNSURE (   9.93  )
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


