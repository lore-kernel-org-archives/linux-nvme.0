Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66746EA813F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Feb 2026 15:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ySLyPv0GtrsUVBeSuJol4ROdIj4Hm4IeSKjtnoL0nc4=; b=gzlGoOfYyPNQLmn5/NSdd3s0CN
	h6WA4ELferRCJd0UnvEO32Co+yTXpVozBajewrSOAI4oQ1Duwo/uFZxgiN+uC42fCubmX+HcsYWW+
	dpB8XvqjUZIKdyL/555eHFdoJGpBqok9dVSc+yX51sRSrsGN/htFtjCDLcdQYeOh4PxmoKUStqLtL
	hy9ZcKJrw5wXJw47wsUTYs7Ejf/iO5UyBg0HoZRiGhmsJ4B0iXiHG2XepSwSjEBh4sWJO+IZg70WF
	nlpXqfJxp47EmvGMV8krdZC/GkgU+KUm91ylIVwhFOiqmY8vKNs/6oVvLae9guDzrZV8vxDdVATFN
	OhWrcQhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpq75-0000000HA8i-2p6R;
	Tue, 10 Feb 2026 15:57:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpq72-0000000HA7i-2qLj
	for linux-nvme@lists.infradead.org;
	Tue, 10 Feb 2026 15:57:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1097168CFE; Tue, 10 Feb 2026 16:57:13 +0100 (CET)
Date: Tue, 10 Feb 2026 16:57:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Junnan Zhang <zhangjn_dev@163.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Shouxin Sun <sunshx@chinatelecom.cn>,
	Junnan Zhang <zhangjn11@chinatelecom.cn>,
	Qiliang Yuan <yuanql9@chinatelecom.cn>,
	Zhaolong Zhang <zhangzl68@chinatelecom.cn>,
	Yaxuan Liu <liuyx92@chinatelecom.cn>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: fix potential I/O hang when CQ is full
Message-ID: <20260210155712.GA3653@lst.de>
References: <20260209121020.119853-1-zhangjn_dev@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209121020.119853-1-zhangjn_dev@163.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_075717_849953_82BD8CA7 
X-CRM114-Status: GOOD (  10.75  )
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

We can't update the CQ head before consuming the CQEs, otherwise
the device can reuse them.  And devices must not discard completions
when there is no completion queue entry, nvme does allow SQs and CQs
to be smaller than the number of outstanding commands.

