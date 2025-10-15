Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24031CCD185
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Oct 2025 04:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=O0OIiShqU2U3hDX+LONtTG0zaB
	cya91LqOr6/p8W2HA7JQg2ex+trm6HehNVlbJWOrWPc27K0ZWxlzNmhSB+NnxEys5GIJ9w6RY2+8i
	CfuePiC0zqmNgONNyWh4lRwwJH3F6fiQ3sEFrGOYrtmgCmsh+M9UNEuCG+bXVnyohQFostpnTIcKL
	EuvXM369Mdd8JbDqbFh0+x7sokhTdkqtBHchDEHC5SWqvXws3j1Pb+bMXN3GarcsmyUA/WHs27NTj
	W3focf3jjI2UhAc3FbMZPOKj+K1PxbiZBh+qe6ttNXtVdy3qT/0+c9tLv++YfrojNmEcEg5dLhxUa
	uXJeZSiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8sw8-00000000P6I-0Ezz;
	Wed, 15 Oct 2025 04:16:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8sw5-00000000P5x-0VzG
	for linux-nvme@lists.infradead.org;
	Wed, 15 Oct 2025 04:16:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 155B2227A87; Wed, 15 Oct 2025 06:16:20 +0200 (CEST)
Date: Wed, 15 Oct 2025 06:16:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/4] blk-mq-dma: migrate to dma_map_phys instead of
 map_page
Message-ID: <20251015041619.GA7073@lst.de>
References: <cover.1760369219.git.leon@kernel.org> <a40705f38a9f3c757f30228b9b848ce0a87cbcdd.1760369219.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a40705f38a9f3c757f30228b9b848ce0a87cbcdd.1760369219.git.leon@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251014_211625_323524_54E6026E 
X-CRM114-Status: UNSURE (   9.98  )
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


