Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4133CCD183
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Oct 2025 19:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2lJn8LqcD+xuzvtcuUVXp56C/jQuHSVKqOTYmHeGKWE=; b=UwLSxukg13IZzZehYUecSJICN8
	9FAW9wf0VP1eEfQD2ZgJ9+xNH1YEoVCESR6UCRF2xRXCH961ZD6Z1A2Y6amnc2n1fm8rIxMr9239Q
	nJ5YKxQlWf1nLkRWPNgF1xM06yRUbP0R4WzB0gAjhs9wx8BtAL67+o8D8d+hRcbacH7QyNZaf6vTu
	IFc2jyzDvrQTsplVGsCO1PjUymfdjHVsWNFib8YxXVVSawUhE/TCgdapPYlBf4fsAP6Efdnpo5RSC
	2bm57S+11yfe+d0xd+VgdAydOtWxORg2bx5OhkdcGFLl2IgSE/F2advMBueOQVgFzFSUOdbD4JWYa
	HUGKpZqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8OEv-0000000EHnF-3S7b;
	Mon, 13 Oct 2025 19:29:49 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8OEs-0000000EHmo-011h
	for linux-nvme@lists.infradead.org;
	Mon, 13 Oct 2025 19:29:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A5701437CD;
	Mon, 13 Oct 2025 19:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F311CC4CEE7;
	Mon, 13 Oct 2025 19:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760383785;
	bh=9Ij8SmNLx3ItPq0glCSzcjFttSD8Tgb6RfqIs4yskVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tO6dBNv9pePmCDLa5Db348i+CRT7zA0wUg0RabPn7tFcQLIWX+HBJJbGFp0Tw0j/O
	 i71pRMWz4UueDrI3iHVmOL5TReq/GPcILgXDFYNlMQD47VQmQi6ungDYkwSlEQb/zx
	 Sa8iNYNBw7JdJ/OcEZeMcwIZSDlJpz0OdXNTea3sQmhiZGfkIS0OQIsaPd7oqgDETy
	 lqQFogyDKaAV6nGdmhxp9daEizjceeXub1uw5P7lOABjYHHWAnPrTXGHdlBooBYRtX
	 mfbN1hDHKOg96kwmrzqP0J41MpawSdyOPIScDgs58hDclkE/UOXDrwqa5pknZUkAfb
	 8zDB7UcLszcpA==
Date: Mon, 13 Oct 2025 22:29:40 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@nvidia.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 3/4] block-dma: properly take MMIO path
Message-ID: <20251013192940.GC14552@unreal>
References: <cover.1760369219.git.leon@kernel.org>
 <cf4f6dfee380351e68932d4d114422364097dda5.1760369219.git.leon@kernel.org>
 <aO1MfsuWeteOsBve@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO1MfsuWeteOsBve@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251013_122946_063475_44BA963D 
X-CRM114-Status: GOOD (  14.34  )
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

On Mon, Oct 13, 2025 at 01:01:18PM -0600, Keith Busch wrote:
> On Mon, Oct 13, 2025 at 06:34:11PM +0300, Leon Romanovsky wrote:
> >  static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
> >  		struct blk_dma_iter *iter, struct phys_vec *vec)
> >  {
> > +	unsigned int attrs = 0;
> > +
> > +	if (req->cmd_flags & REQ_MMIO)
> > +		attrs |= DMA_ATTR_MMIO;
> 
> Since data and integrity paylods use these same functions and may point
> to different kinds of memory, I think you'd have to pass the 'attrs'
> from the caller since it knows which flags to check for MMIO dma.

I think that hunk will fix it.

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 38f5c34ca223..8af88ba97c7a 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -88,9 +88,11 @@ static bool blk_dma_map_bus(struct blk_dma_iter *iter, struct phys_vec *vec)
 static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
                struct blk_dma_iter *iter, struct phys_vec *vec)
 {
+       struct bio_integrity_payload *bip = bio_integrity(req->bio);
        unsigned int attrs = 0;

-       if (req->cmd_flags & REQ_MMIO)
+       if ((!bip && req->cmd_flags & REQ_MMIO) ||
+           bio_integrity_flagged(req->bio, BIP_MMIO))
                attrs |= DMA_ATTR_MMIO;

        iter->addr = dma_map_phys(dma_dev, vec->paddr, vec->len,
~

