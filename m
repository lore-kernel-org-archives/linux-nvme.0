Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE4EC7EE39
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jun 2025 19:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dapwbrzEK2BuBRCpQzUcF5tb+adNWOWnNnzFpVr3YXk=; b=Gwny0JqkVlewD+uvMIWsM79N0Z
	RRV74bx8zWvOoNUJU8RnLxT3tNgYr65VFb5Nglk/0lMbouXUsqNsR3rGAp+j/SvGiWqkJoN0z1BxA
	plq3/b5e08cq2wDpvOFJ3Bco9xIKracQ2ni9uTOE2H2vvSkB9jTqRKr0vpQ9XHm088vID6DPPUMxE
	puPvy1BSBi5aJ5i7m8dXXi/+lrft7CXQ0gvGskIhYkx2AWo9krbSNWL7ezlemxZvubHr8MAvcMawT
	A/XkFXCCid0Uuge1yqtRaYmTXSZ8D2KphBUl6cpEEg0xlndiFOD9Oiagizk3ay7L6xtecfViy3BMD
	NzA+Rq/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTn3P-00000003p9K-0QXQ;
	Mon, 23 Jun 2025 19:42:07 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTjKN-00000003HVq-1jmK
	for linux-nvme@lists.infradead.org;
	Mon, 23 Jun 2025 15:43:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id AFFB0A51F33;
	Mon, 23 Jun 2025 15:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8E1C4CEEA;
	Mon, 23 Jun 2025 15:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750693402;
	bh=VcRWjYMSJw03/dks5fmNXEVRgkYNfRhBtD8HoaYy0Wk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zh2Ue8OomNtBloDplx1kd1zOkpJ09KIl7feACNXNxKEdjIIFp4qb/K2eJrW+u5O4S
	 wvSDh55jisc21Yk8eA02p/2rZeuasIUk6iwxis4sE06dqr6TJoEbBmKwMGffl0H9Ur
	 ld6FusCNzzP5pW9VCjQ547CtlMe+B7NOn+hduEwgTKQWA/lVQKl0VoNdevTqzgei7p
	 mAhC3BR1PdbnW1aoUAZMyNcJamI5sJY0C7T+9wvRucjYbYZEXJ4wyKQwX4j3buZy9X
	 w5ji8fYeNp1ihS8mrk/mImaRwnNqMTBx3/ugTrRfojLEh6FN44bQrYjRViC36T5dx7
	 akO4ZVqqvaE2Q==
Date: Mon, 23 Jun 2025 09:43:20 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH 2/8] block: add scatterlist-less DMA mapping helpers
Message-ID: <aFl2GJskYNdvZDDo@kbusch-mbp>
References: <20250623141259.76767-1-hch@lst.de>
 <20250623141259.76767-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623141259.76767-3-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250623_084323_514740_7382E86E 
X-CRM114-Status: GOOD (  16.28  )
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

On Mon, Jun 23, 2025 at 04:12:24PM +0200, Christoph Hellwig wrote:
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

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

