Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E884CCD199
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Oct 2025 08:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jAbBa9/wqXfqeGiEYCAeQeJe/uYykl86cgw6DMS6uZs=; b=DL8F3SBclBxIbgpTCBz9Gw0F0B
	tOFMDM+0DfZXLCxj86vNzBm1U+TOe8PVfvOHYbMYuOFmxzrWyI/q7+qGxrBjuEbUwdB/RVeL+heUg
	pJZ3oCauEfwGpQBIbX/soa9Z5KS/5GE4TIm/URlWI3O+lbiQvo+8JXMhEtJ0d09DSr+8NVa3VM5Qa
	IYyM/vpS+I4y7YdKirvFXxP3Jw3lTmEcuhBHBSnAqkVIAPSpAAY8fqj3QgTBI4UAGWi2uWLaDbVzk
	t4gjWdmfCoxDh6RVn/txrzGKlHwB7Efj6DqL7cmoK995RXwPpnA2WUUw7Z6pxNdYgmrUBOu3c7YRl
	Rj+NrPcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAlhV-0000000CU77-0bQG;
	Mon, 20 Oct 2025 08:57:09 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAlhU-0000000CU6v-0C77
	for linux-nvme@lists.infradead.org;
	Mon, 20 Oct 2025 08:57:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5728E61CFB;
	Mon, 20 Oct 2025 08:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6364FC4CEF9;
	Mon, 20 Oct 2025 08:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760950613;
	bh=w3aN04Vk00eSSY6/KDz0bmiTPKv0E4MFFtWbbIJG2ZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nGtVZs1NZUD5ltfaM/YJEP8EBJGa3FUsfLXutwYH5E5wwBCLZrEsHbJiIL2xHpIVc
	 5S07RgueFcq57rbhB5AeeyZCnz7jSQz87n/d2S6QTx9SL7qjYSzrC5WVGwiHy75KTA
	 YBPjZhLEQeblnxlZX2xjmgE8oBcvPBKHBaEwTYA8ZOkzGHWbaOf7uHiIrt0+SuLVSR
	 HVCQm0a/2MpByvLvQn0vp2Ao3Mp9G5ua8wqdKNJSoQHfgIIvXlu6MkXH6s62bCZXMp
	 hgPQfVzppPNG4Q3U1n5Cz2RJo8PhBNSg/29tL0WUr5WDb83JHaYuUqJGsNnpwaL/mg
	 Nun/9VsKt1BhA==
Date: Mon, 20 Oct 2025 11:56:48 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] block-dma: properly take MMIO path
Message-ID: <20251020085648.GN6199@unreal>
References: <20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com>
 <20251017-block-with-mmio-v1-3-3f486904db5e@nvidia.com>
 <20251017062519.GC402@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017062519.GC402@lst.de>
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

On Fri, Oct 17, 2025 at 08:25:19AM +0200, Christoph Hellwig wrote:
> On Fri, Oct 17, 2025 at 08:32:00AM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Make sure that CPU is not synced and IOMMU is configured to take
> > MMIO path by providing newly introduced DMA_ATTR_MMIO attribute.

<...>

> > +		if (iter->iter.is_integrity)
> > +			bio_integrity(req->bio)->bip_flags |= BIP_MMIO;
> > +		else
> > +			req->cmd_flags |= REQ_MMIO;
> > +		iter->iter.attrs |= DMA_ATTR_MMIO;
> 
> REQ_MMIO / BIP_MMIO is not block layer state, but driver state resulting
> from the dma mapping.  Reflecting it in block layer data structures
> is not a good idea.  This is really something that just needs to be
> communicated outward and recorded in the driver.  For nvme I suspect
> two new flags in nvme_iod_flags would be the right place, assuming
> we actually need it.  But do we need it?  If REQ_/BIP_P2PDMA is set,
> these are always true.

We have three different flows.
1. Regular one, backed by struct page, e.g. dma_map_page()
2. PCI_P2PDMA_MAP_BUS_ADDR - non-DMA flow
3. PCI_P2PDMA_MAP_THRU_HOST_BRIDGE - DMA without struct page, e.g. dma_map_resource()

There is a need for two bits to represent them.

Thanks

