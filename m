Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40FAC71136
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Jun 2025 12:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C/tgUIke+2qNXzzDPOk6ryx3DVYioUGGicH5v3Ang+s=; b=Mk0qe6xYhgfgjan2kU8WKMMjX2
	ZxBhnriNAD5hLZG3doPIYQM4FGMmQNBUOBP0NWHaEdjyb5XpkqJ8X3SK+WukyINDWy/py3J+5trD6
	AtzRWaSN35tm6PLjWy+nQETqRXUOzjDupLNSC0gcPushNgSfd6ZEsA5UnIjugrJrTveYvGsYU2eyN
	iPlYL/UBa2t9+yHZ/iD5eej/YWZfOaikYdVudwR/tjXoN2tpWNQ4MljmwenBqw2tQfyHX59ucD0qL
	APPTAl0pd3uh2dOkvbXFLf+cEfj393R+SRrfZ1FcIhTpsGgcTuLIDj8WDsL2lSch+PQXZ3ICdy2Ex
	5igMqS9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR8wP-00000004Mn3-1kNx;
	Mon, 16 Jun 2025 12:27:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR846-00000004Cxw-00C2
	for linux-nvme@lists.infradead.org;
	Mon, 16 Jun 2025 11:31:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2FC0367373; Mon, 16 Jun 2025 13:31:41 +0200 (CEST)
Date: Mon, 16 Jun 2025 13:31:41 +0200
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
Message-ID: <20250616113141.GA21749@lst.de>
References: <20250610050713.2046316-1-hch@lst.de> <20250610050713.2046316-3-hch@lst.de> <dab07466-a1fe-4fba-b3a8-60da853a48be@kernel.org> <20250616050247.GA860@lst.de> <2105172c-5540-40d0-9573-15001b745648@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2105172c-5540-40d0-9573-15001b745648@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250616_043150_181237_310F05B2 
X-CRM114-Status: GOOD (  15.17  )
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

On Mon, Jun 16, 2025 at 08:43:22AM +0200, Daniel Gomez wrote:
> >> This comment does not match with blk_rq_dma_map_iter_start(). It returns false
> >> and status is BLK_STS_INVAL.
> > 
> > I went over you comment a few times and still don't understand it.
> 
> The way I read the comment is that status is only valid when
> blk_rq_dma_map_iter_* returns false.

Yes.

> But blk_rq_dma_map_iter_start() can return false and an invalid status (in the
> default switch case).

The status field is valid.  Your patch below leaves it uninitialized
instead, which leaves me even more confused than the previous comment.


