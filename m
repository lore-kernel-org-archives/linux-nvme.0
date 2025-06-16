Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A6DC71155
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Jun 2025 13:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=byDEvrVb3CmGMVPpVO0XSTOjMi5kuG1Zx/h1NSaseKM=; b=i6PZBYbQ8TSRMdqWrFVq/nx9XO
	IN6x/3Qc7gUqbuJqbna1yhCDyhmOeA2BxZ/DN/mdBxFhoVy+49nMDpzp7BsTELtGdPHW8S979D0+I
	XXokr9J4Wi8s7XvQ+DGSPwQri93MiPK0bPjRIZJ1xM/alfCjefql7KSQ0DKsqIL8ZqslRBwHLlKpm
	qLye3o62IAUGh62PZp7+Hy4KniDFhZZxYdb/lUhoi0NbHOFFY2J+1KrsvJLC6S5+zT0gCtEOPrIBO
	C89EUAxcqT6GhxfqLqb3K65fB6nPYgM35ZqViwjfmIpliK+t+QBS+BVuH/W/yjA2LRZbJ+GJKDcqT
	nxLGAwzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRAGp-00000004bkG-0Ifl;
	Mon, 16 Jun 2025 13:53:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR9AB-00000004P0z-0QvE
	for linux-nvme@lists.infradead.org;
	Mon, 16 Jun 2025 12:42:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1F05567373; Mon, 16 Jun 2025 14:42:06 +0200 (CEST)
Date: Mon, 16 Jun 2025 14:42:05 +0200
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
Message-ID: <20250616124205.GA27570@lst.de>
References: <20250610050713.2046316-1-hch@lst.de> <20250610050713.2046316-3-hch@lst.de> <dab07466-a1fe-4fba-b3a8-60da853a48be@kernel.org> <20250616050247.GA860@lst.de> <2105172c-5540-40d0-9573-15001b745648@kernel.org> <20250616113141.GA21749@lst.de> <4973015e-ecb2-4bd9-ac26-05927fa8fbd4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4973015e-ecb2-4bd9-ac26-05927fa8fbd4@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250616_054211_282282_D80D1D11 
X-CRM114-Status: GOOD (  12.29  )
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

On Mon, Jun 16, 2025 at 02:37:43PM +0200, Daniel Gomez wrote:
> 	
> 2. In the if/switch case default case (line 181-183):
> 	It sets the status to invalid and *iter_start() returns false:
> 	
> 		default:
> 			iter->status = BLK_STS_INVAL;
> 			return false;
> 
> 
> Removing the invalid assignment "makes it" valid (because of the
> initialization)

Huhhh?  How do you make a field access valid by dropping an assignment?


