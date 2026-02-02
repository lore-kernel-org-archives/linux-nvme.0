Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24669E7DF11
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Feb 2026 17:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QTl0FK2nrvj8FfVvONJEIn737ZFAZHCTDTewMuVT+wA=; b=u3K1uy4JW96zRbLeu7LBbPuXX8
	gVwamBIuvxlWb/UvOgvhFGWyZCJ6Vm9XKVIm8tn9JpeV1tl0hmxY1sdNjKYI+f0vTjJNKAWAK7uIx
	HGFwa7h1Fr/KqNbSF1bKRXq29D7c3V5Dw/p0YBETM+qmmj5sgHViJ/MTgBqtrH5GiUCdtMK+Z0Hmp
	7y11haXvBdYV1mVsCh7fbTmQ2MQaT6xRVQruI4Hl03DQS384+zcf93BwpPm9N3gf+SKuGt5rGuoAd
	857pY/LlYEy+OM+MZ0IxxufzAggLhzMYfyrAtiTkvoIov2LTUS3pAYFdX2Mh+8jY5ytig7UtLz7kR
	qCDZOhhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmxZ2-00000005Lmy-1Vv6;
	Mon, 02 Feb 2026 17:18:16 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmxZ1-00000005Lms-25tZ
	for linux-nvme@lists.infradead.org;
	Mon, 02 Feb 2026 17:18:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9F845600B0;
	Mon,  2 Feb 2026 17:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A003C116C6;
	Mon,  2 Feb 2026 17:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770052694;
	bh=5ypc+EGOhkIew2b/AMpI7KYgHTEpZ4E9pgp6HK8Z4zI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=drzNCPc9jZYc2bKVefwV/w98z5xfh8eUyMeV79r/hr4AC2/YYeW6KfUeS+ZGDI3w0
	 lPaaJIwfNxb1FqLXPliA8nfR35MdHgVJnvkSApk3xKsneF5q6JVBbiOgaNWwBs610N
	 1843qP+UgGjATvRt7HEDWLADWcf3l+ZMMA++cyi++B7/oYQyHdNu+DgNSmQL9FA4EC
	 GPnV8hSvV/LZg0ID32nBOtFeP7JGd5PwUt/F9Clz8pvGPmqZC35hSxfhmeHrJBe1cP
	 ti8ZLqTi2DpEh6wS0b/oIcqIU/bXHkPqnD5V1+PayPCjS4ieEq53MCr1yaQBZk62Am
	 GfC/9KNAAcsXw==
Date: Mon, 2 Feb 2026 10:18:12 -0700
From: Keith Busch <kbusch@kernel.org>
To: Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	nitin.rawat@oss.qualcomm.com
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
Message-ID: <aYDcVDVFTWrBwzw_@kbusch-mbp>
References: <20260202125738.1194899-1-pradeep.pragallapati@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202125738.1194899-1-pradeep.pragallapati@oss.qualcomm.com>
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

On Mon, Feb 02, 2026 at 06:27:38PM +0530, Pradeep P V K wrote:
> @@ -720,6 +720,7 @@ static void nvme_free_prps(struct request *req, unsigned int attrs)
>  		dma_unmap_phys(nvmeq->dev->dev, iod->dma_vecs[i].addr,
>  			       iod->dma_vecs[i].len, rq_dma_dir(req), attrs);
>  	mempool_free(iod->dma_vecs, nvmeq->dev->dmavec_mempool);
> +	iod->dma_vecs = NULL;
>  }
>  
>  static void nvme_free_sgls(struct request *req, struct nvme_sgl_desc *sge,
> @@ -825,7 +826,7 @@ static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
>  		return true;
>  	if (!blk_rq_dma_map_iter_next(req, dma_dev, iter))
>  		return false;
> -	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev)) {
> +	if (iod->dma_vecs && !dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev)) {

So the return of dma_need_unmap() may change after any call to
dma_map_*? Does it only go from false -> true, and never back to false?

Since we didn't allocate the dma_vecs here, doesn't that mean the
completion side is leaking the mapping?

