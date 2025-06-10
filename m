Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69198C5B552
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Jun 2025 16:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ay/axsojr5T2Se1LMZe5J2bFyhhlSDF/uLd+Luxh7EU=; b=k9x6UdrHdK8ZsGYgt1FdxOVg6A
	VES1fybtSc2Zsjf/Eq/zA52ZWbYzpF9MmruYIX7l2fCH6U3EkgPV5JsiGiBacL/W4njxctn4xLmMe
	lDeCF9o1H4yzlhQAxzYPWHt+JuEix08qGCM17PzMzEZ8kAMB3LZc+ztPSw8qLJf3rUhlCrkaJteGi
	BgtHQbc1DPgxtxEQ0MknBE57yM+EpV2Od9ciItkr+hx6ScEJM+IVk32HU0C97tbfkFDWTh7XrPdes
	dRApWn57mHKdmy+jZY9GFkFUy5q5TPzXwhs6uraP9/19pZaCDDvWfPYECInIkcK9qAlmlIxto5epa
	/Kj8xTWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP1lU-00000007SR8-3Cye;
	Tue, 10 Jun 2025 16:23:56 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOyS4-00000006qGl-0cU8
	for linux-nvme@lists.infradead.org;
	Tue, 10 Jun 2025 12:51:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D58D74457F;
	Tue, 10 Jun 2025 12:51:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E995C4CEEF;
	Tue, 10 Jun 2025 12:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749559899;
	bh=GrM7bg2VX6XUBKa3sIuRKNEdiNvsK86ggN+WUT/jQZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=spGtxHrDx/PR/l6qp0k5nSElh8ajrOeR4lddLvFV2Ghngz0w/6t53aBK+i4IirQbv
	 WT/52IjwM97jLvD4wPbVbv8pzAq/pa0RpKltLQXFVDzhOQdgV/Tb4mccDdfiLGQWWJ
	 xEmlqwkduEZrJNu1sTzWrWab1ZAVHJhQQyrUl1QJoTMFWjPc0TPfkaNrf/r8HBE8Eh
	 v1VTSDV3cYCQtvaLEk9xirzcArds4pniUOGeMPkMD1uFdI5vDugGsSy1LgI9xfnIre
	 IgpOjN2zqRQjTkz7sAI8uyONhB2M7/NrxTGq5RAzjbSM7FSCmVtd2N4ya9SfGLQRNT
	 6GCoAj1J1Ibbg==
Date: Tue, 10 Jun 2025 15:51:34 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/9] block: add scatterlist-less DMA mapping helpers
Message-ID: <20250610125134.GD10669@unreal>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610050713.2046316-3-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_055140_204659_38120FCA 
X-CRM114-Status: GOOD (  19.15  )
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

On Tue, Jun 10, 2025 at 07:06:40AM +0200, Christoph Hellwig wrote:
> Add a new blk_rq_dma_map / blk_rq_dma_unmap pair that does away with
> the wasteful scatterlist structure.  Instead it uses the mapping iterator
> to either add segments to the IOVA for IOMMU operations, or just maps
> them one by one for the direct mapping.  For the IOMMU case instead of
> a scatterlist with an entry for each segment, only a single [dma_addr,len]
> pair needs to be stored for processing a request, and for the direct
> mapping the per-segment allocation shrinks from
> [page,offset,len,dma_addr,dma_len] to just [dma_addr,len].
> 
> One big difference to the scatterlist API, which could be considered
> downside, is that the IOVA collapsing only works when the driver sets
> a virt_boundary that matches the IOMMU granule.  For NVMe this is done
> already so it works perfectly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-mq-dma.c         | 162 +++++++++++++++++++++++++++++++++++++
>  include/linux/blk-mq-dma.h |  63 +++++++++++++++
>  2 files changed, 225 insertions(+)
>  create mode 100644 include/linux/blk-mq-dma.h
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

