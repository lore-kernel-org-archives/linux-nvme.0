Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84393CCD185
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Oct 2025 04:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BLQ4xJ76lkTSxi/ZzB2/6uNn4HXJr12Xsv1/TOayS+A=; b=N5Ff1uF45bo6PECJhhkc0aGFfE
	obkDcKtF6hpq1cGjVk9MgZ4p/6J1H31jObde1j2PPykC5UMxPdMMYip5FEjdBtHTw+W5WBca+GrB5
	BujeE5omAvHI0DWJB8yfImTTymLaFauqTdD8BX5EX/0Aqq/b0GSHlk4tXso/YD6YSMDG6Jc+tE2IQ
	asMXBlm5kKozgj3cSHvzs2RssZIszYMFICbkaxP86MfgSC6bU6YYN6KDz+j0u2uIXs89DlzSB/30p
	W2mzujJYJ/ycEIMIZgdGVeOO8XLFJSLP/NZfK7oYVCeNtdTqbjsi3cCVgUyWq4a/9TRI+pNIPMpzY
	E6ZS8Myg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8t0Y-00000000PbR-0610;
	Wed, 15 Oct 2025 04:21:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8t0V-00000000Pay-3GjN
	for linux-nvme@lists.infradead.org;
	Wed, 15 Oct 2025 04:21:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6BB19227A87; Wed, 15 Oct 2025 06:20:53 +0200 (CEST)
Date: Wed, 15 Oct 2025 06:20:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 4/4] nvme-pci: unmap MMIO pages with appropriate
 interface
Message-ID: <20251015042053.GC7073@lst.de>
References: <cover.1760369219.git.leon@kernel.org> <6522567376d50f71425ccc4950552fca48e4f57f.1760369219.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6522567376d50f71425ccc4950552fca48e4f57f.1760369219.git.leon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251014_212059_986732_8BC8C514 
X-CRM114-Status: GOOD (  15.49  )
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

On Mon, Oct 13, 2025 at 06:34:12PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Block layer maps MMIO memory through dma_map_phys() interface
> with help of DMA_ATTR_MMIO attribute. There is a need to unmap
> that memory with the appropriate unmap function, something which
> wasn't possible before adding new REQ attribute to block layer in
> previous patch.

This should go into the same patch that switches to dma_map_phys.
Unless I'm missing something it also misses passing the flag for
the metadata mapping.

Btw, where is all this going?  Are you trying to remove the auto
detection of P2P in the low-level dma mapping routines?  If so that
should probably go into at very least the cover lttter, but probably also
the commit logs.

