Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56807C6FA83
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Sep 2022 08:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jS4gbaE25b5FwtpAi5acCSAtwOGNDfO2kXInNNv4wXw=; b=lJxXrvarA6nTO4c4zTNl5ZiFUT
	LSIOvMwfRJa+Ws02NGFyBtYZj1pHGhz8poz4x5EK2CNORJ41sHtvn9tOuy7uw9v1fn52gQPzMZ7sU
	qSVl0lgLk+s6ov2kbpa91uNBHb9Pnv+HQGCHe1HZX/pqW3muDXPPUYVCmIq5xGQ1x6k8s9MHW49iV
	VMmShCDS4Nxtk64TfRluEeJWULb8oZW76xJv+GsarG1iEbrZ+26YylPv9PCQEBWpA20Ki5wqEfYgh
	83ursg+/dgii1Eviv8CFRhm+c09kTzSaAORFhE5D0d+DqBqjvE7uV6fJvT0D+Ihr0bNTu6qWbyW/i
	nTn+5rnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXesn-007pCE-2k; Mon, 12 Sep 2022 08:33:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oXeok-007nDt-0Y
	for linux-nvme@lists.infradead.org; Mon, 12 Sep 2022 08:29:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5141568B05; Mon, 12 Sep 2022 10:29:10 +0200 (CEST)
Date: Mon, 12 Sep 2022 10:29:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Serge Semin <Sergey.Semin@baikalelectronics.ru>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Revanth Rajashekar <revanth.rajashekar@intel.com>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Guenter Roeck <linux@roeck-us.net>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme-hwmon: Cache-line-align the NVME SMART
 log-buffer
Message-ID: <20220912082909.GA10666@lst.de>
References: <20220909191916.16013-1-Sergey.Semin@baikalelectronics.ru> <20220909191916.16013-2-Sergey.Semin@baikalelectronics.ru> <20220910053045.GA23052@lst.de> <20220910123542.tzxg2blegw55z5fj@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910123542.tzxg2blegw55z5fj@mobilestation>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220912_012922_344201_0A77E873 
X-CRM114-Status: GOOD (  18.15  )
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

On Sat, Sep 10, 2022 at 03:35:42PM +0300, Serge Semin wrote:
> Well, both approaches will solve the denoted problem. I am just
> wondering why do you think that the kmalloc-ed buffer is more
> preferable?

Because it clearly documents the intent.  Here is one buffer that is
just a data buffer, and here is one with kernel internal structure.
The concept of embedding on-disk / on-the-wire structures into internal
stuctures always seemed rather weird and unexpected to me, as we now
need to ensure that the alignment works right on both sides.  With
the right annotations (as done in this series) this will work, but
it feels a little fragile to me.

> What would be the best solution if we had a qualifier like this:
> #ifdef CONFIG_DMA_NONCOHERENT
> #define ____dma_buffer ____cacheline_aligned
> #else
> #define ____dma_buffer
> #endif
> and used it instead of the direct ____cacheline_aligned utilization.

So independent of my preference for separate allocations, this suggested
additional would still be very useful for the places where we need
to use the alignment for performance or other reasons.  I'd use
something like __dma_alligned or similar, though.

