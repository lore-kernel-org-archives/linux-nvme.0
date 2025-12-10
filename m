Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2E8D3B9A9
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Dec 2025 05:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sBxE8OmTccIaX5uqTC2BK2RFYr6auOoFIb5dB1ipPDE=; b=dnPS5CbcZeJOkpSruqxge89yDl
	8UQja7Ht1dbd+e0vUMdeisxmVda6KM5MWJTjpXIMa3g0vjVNCYMXHY5fkIwY/RCIOozAEI8iwWD7q
	zlUertOoG02BEcFySsk5cXmiLwsENbCVX2FzpyGvDdbDTHeM1v6d52/YfnlsAw2Er4/tfSfs5XeGl
	urKPEGlyu6q9sA6yU35I4B8UxVrkhwR7rNycO+YcYPrD5cQ/GnRwym6twb0Hj2IrfFpa6medxfStK
	M47WcobjBfA0YrWn2hTZenkelv23B3nBOikrUf8mx19TGCLiQYE5cXmzR5+RQPwCxe5RtBuquAnrz
	nAWyzglQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTCpH-0000000F8XR-0vjV;
	Wed, 10 Dec 2025 05:33:23 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTCpE-0000000F8Wv-0G8m
	for linux-nvme@lists.infradead.org;
	Wed, 10 Dec 2025 05:33:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6B3BA42A0C;
	Wed, 10 Dec 2025 05:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D61C4CEF1;
	Wed, 10 Dec 2025 05:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765344799;
	bh=lbwvwXWzNJQg0D0whYabQqpf4faHZKOzfUVbRO2CbTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qdqCFQqrqVi89XDOyo036+Bn1o40mBQGFD5AKaJFZFEk9KkxJKHw3ytUaxLKN6+u2
	 PmK2tO9JBdxUF2Wu9L5hyRsIJQwzD0cPIGr0XwpFOzItwl5Yh06Sv7RNRXgHPLeTrt
	 q5t6BfHFqnJEfWEn8SWt2lhfIOLIaJcP79XJ9p7n+PWeCuH2RfTrx/iDDZTTo8UYCc
	 ExxjRqURUG7QPuv1IX/RosIKJMEpycUSR/i8wPDI2jov/bNTZBRCcJDni9MsBVwvP1
	 Q9mzzTuKthJPk6tKz/oKRXeFNVR5/Ozco6aS9hbJ4UlVVgTF3vq+++SpzRrth5+fjF
	 INebxkxbqRDBQ==
Date: Wed, 10 Dec 2025 14:33:14 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sebastian Ott <sebott@redhat.com>
Cc: linux-nvme@lists.infradead.org, iommu@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Carlos Maiolino <cem@kernel.org>
Subject: Re: WARNING: drivers/iommu/io-pgtable-arm.c:639
Message-ID: <aTkGGt9unmCS0r4d@kbusch-mbp>
References: <170120f7-dd2c-4d2a-d6fc-ac4c82afefd7@redhat.com>
 <aTj-8-_tHHY7q5C0@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTj-8-_tHHY7q5C0@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251209_213320_147453_0F8CA0FE 
X-CRM114-Status: GOOD (  20.75  )
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

On Wed, Dec 10, 2025 at 02:02:43PM +0900, Keith Busch wrote:
> On Tue, Dec 09, 2025 at 12:43:31PM +0100, Sebastian Ott wrote:
> > got the following warning after a kernel update on Thurstday, leading to a
> > panic and fs corruption. I didn't capture the first warning but I'm pretty
> > sure it was the same. It's reproducible but I didn't bisect since it
> > borked my fs. The only hint I can give is that v6.18 worked. Is this a
> > known issue? Anything I should try?
> 
> Could you check if your nvme device supports SGLs? There are some new
> features in 6.19 that would allow merging IO that wouldn't have happened
> before. You can check from command line:

Actually the SGL support is probably unnecessary for ARM if your iommu
granularity is 64k. That setup could also lead to an uninitialized
"state" and the type of corruption you're observing. But the same patch
below is still the proposed fix for it anyway.
 
> ---
> diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> index e9108ccaf4b06..7bff480d666e2 100644
> --- a/block/blk-mq-dma.c
> +++ b/block/blk-mq-dma.c
> @@ -199,6 +199,7 @@ static bool blk_dma_map_iter_start(struct request *req, struct device *dma_dev,
>  	if (blk_can_dma_map_iova(req, dma_dev) &&
>  	    dma_iova_try_alloc(dma_dev, state, vec.paddr, total_len))
>  		return blk_rq_dma_map_iova(req, dma_dev, state, iter, &vec);
> +	state->__size = 0;
>  	return blk_dma_map_direct(req, dma_dev, iter, &vec);
>  }
> 
> --
> 

