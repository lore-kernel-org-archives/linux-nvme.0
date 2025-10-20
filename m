Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2197CCD193
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Oct 2025 14:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2VUv2DD/0/LaBhugceZR9gXERjfdcsPzM+G44hOoOhk=; b=Pa9WZBDiNVkd1MpA/CHEAy+v8f
	ZFmj3YgnVVQHn7BmcISebo+8L9+1eMcdt+At/eql+daCssRXJ8UqX57zVKy7HqtI9owUGDNAe2tAu
	8/r4wfr8vv/woswIw+Ro/0j1iErCZZGgYOxIyaJ83UvSg61aYBxThcVZhvqfIFBUlJKtS59RDj1a4
	6hsKafThP9ITI+9lw6xykjTy2D7pnRLyR+RpScmJlW0U95TMnf0vvXzorvyPFW/uLSCOMmnCJZyLU
	i4CE7TMIlA0JxdOnh4A1oZvKCkgykKCNeL4XMzKZa8lGhZ7maAkmCF0ncPtkXg4ASyWNFmwQa6TP+
	eBhy+Ucw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vArGm-0000000E1LV-008l;
	Mon, 20 Oct 2025 14:53:56 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vArGg-0000000E1KD-1bdc
	for linux-nvme@lists.infradead.org;
	Mon, 20 Oct 2025 14:53:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 98712419E6;
	Mon, 20 Oct 2025 14:53:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A889C4CEF9;
	Mon, 20 Oct 2025 14:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760972015;
	bh=iAt8uGGscg6uWZh66jwdRnihglXUOWBkZsoHIrSxxpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=asELskkprdgJtjllqYs0rdCuEmNCkXqf4RBj2CyENr/KnnJJILB41kjDrHdVs7+W6
	 ffnVeXfx/I2d232YlMsDIASdOVv8OY7PhBo2MBieCPhN06dAao+0W8Lc37WK0sPkh6
	 WbegKrPveUSXR1m3Mfy/3xeRSNY+EXtOEXdLGyPSp1EBI+FqxSS8aWowSCzHE+IRi8
	 UxLmeEKWma8nAxmSVZzbzYpzqNZT7KTC9CbIQyVcUDep/EZ+SXxD8CfyZVW4VYmVJo
	 dPusg9uxnjdW4uNJ/UGXYQG4B4uF7vaVJBMpIi5bTB7rYm0KhFMkYE1fIXmYf47SkM
	 mVwmzzY/NxoYA==
Date: Mon, 20 Oct 2025 17:53:30 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] block-dma: properly take MMIO path
Message-ID: <20251020145330.GO6199@unreal>
References: <20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com>
 <20251017-block-with-mmio-v1-3-3f486904db5e@nvidia.com>
 <20251017062519.GC402@lst.de>
 <20251020085231.GM6199@unreal>
 <20251020123027.GA19560@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020123027.GA19560@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_075350_459923_4466B40D 
X-CRM114-Status: GOOD (  15.05  )
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

On Mon, Oct 20, 2025 at 02:30:27PM +0200, Christoph Hellwig wrote:
> On Mon, Oct 20, 2025 at 11:52:31AM +0300, Leon Romanovsky wrote:
> > What about this commit message?
> 
> Much bettwer.  Btw, what is the plan for getting rid of the
> "automatic" p2p handling, which would be the logical conflusion from
> this?

I continued with "automatic" p2p code and think that it is structured
pretty well. Why do you want to remove it?

The code in v2 looks like this:

@@ -184,6 +184,8 @@ static bool blk_dma_map_iter_start(struct request *req, struct device *dma_dev,
                 * P2P transfers through the host bridge are treated the
                 * same as non-P2P transfers below and during unmap.
                 */
+               iter->attrs |= DMA_ATTR_MMIO;
+               fallthrough;
        case PCI_P2PDMA_MAP_NONE:
                break;
        default:

...

@@ -1038,6 +1051,9 @@ static blk_status_t nvme_map_data(struct request *req)
        if (!blk_rq_dma_map_iter_start(req, dev->dev, &iod->dma_state, &iter))
                return iter.status;
 
+       if (iter.attrs & DMA_ATTR_MMIO)
+               iod->flags |= IOD_DATA_MMIO;
+
        if (use_sgl == SGL_FORCED ||
            (use_sgl == SGL_SUPPORTED &&
             (sgl_threshold && nvme_pci_avg_seg_size(req) >= sgl_threshold)))
@@ -1060,6 +1076,9 @@ static blk_status_t nvme_pci_setup_meta_sgls(struct request *req)
                                                &iod->meta_dma_state, &iter))
                return iter.status;
 
+       if (iter.attrs & DMA_ATTR_MMIO)
+               iod->flags |= IOD_META_MMIO;
+
        if (blk_rq_dma_map_coalesce(&iod->meta_dma_state))
                entries = 1;

...

@@ -733,8 +739,11 @@ static void nvme_unmap_metadata(struct request *req)
                return;
        }

+       if (iod->flags & IOD_META_MMIO)
+               attrs |= DMA_ATTR_MMIO;
+
        if (!blk_rq_integrity_dma_unmap(req, dma_dev, &iod->meta_dma_state,
-                                       iod->meta_total_len)) {
+                                       iod->meta_total_len, attrs)) {
                if (nvme_pci_cmd_use_meta_sgl(&iod->cmd))
                        nvme_free_sgls(req, sge, &sge[1], attrs);
                else

The code is here (waiting for kbuild results)  https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/log/?h=block-with-mmio-v2

Thanks

