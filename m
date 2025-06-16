Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E19C71136
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Jun 2025 05:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jdtdhp527QzLJMClgyJJTBJGf6sAlrCBDyU6oLYeRx8=; b=yXSFgS0oUlxuLwwz4/uFSCZhS6
	tQg7SgA1ADoBy5ZJrxUeiM63VZSjWMOdD7/6k40LhlZFQKN7GNPGtse0YWnimIlXPsyC/OONsQ4zW
	N4sEt28Jp4GOacSDRpSxt/4r0Kb/W3GQpoTujoF/akkbcnN+kALHMbyePlvluqJ2EWyNTxbb2JqLJ
	BVX3sF9piYaKwcK/TlipnTBm+BXN9k614R6ccFoXAJ85Lrx6zKrWGh6veckAPdNq/wTeF22X9TMbz
	BqcwlsL0OAHIz1pv+pJCU+7dHkkO397YrGYlI4I+Ahhuel7hyN2YHZYKrFDeAXx+lt/rpynXaumRO
	k8Y8uU+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR1zo-00000003NsP-45Rr;
	Mon, 16 Jun 2025 05:03:00 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR1zl-00000003Npz-3kes
	for linux-nvme@lists.infradead.org;
	Mon, 16 Jun 2025 05:02:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 07C6568BFE; Mon, 16 Jun 2025 07:02:48 +0200 (CEST)
Date: Mon, 16 Jun 2025 07:02:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/9] block: add scatterlist-less DMA mapping helpers
Message-ID: <20250616050247.GA860@lst.de>
References: <20250610050713.2046316-1-hch@lst.de> <20250610050713.2046316-3-hch@lst.de> <dab07466-a1fe-4fba-b3a8-60da853a48be@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dab07466-a1fe-4fba-b3a8-60da853a48be@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250615_220258_072200_F4E9E398 
X-CRM114-Status: GOOD (  14.13  )
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

On Wed, Jun 11, 2025 at 03:43:07PM +0200, Daniel Gomez wrote:
> > +struct blk_dma_iter {
> > +	/* Output address range for this iteration */
> > +	dma_addr_t			addr;
> > +	u32				len;
> > +
> > +	/* Status code. Only valid when blk_rq_dma_map_iter_* returned false */
> > +	blk_status_t			status;
> 
> This comment does not match with blk_rq_dma_map_iter_start(). It returns false
> and status is BLK_STS_INVAL.

I went over you comment a few times and still don't understand it.

