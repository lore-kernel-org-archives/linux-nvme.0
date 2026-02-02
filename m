Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00487E7DEF2
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Feb 2026 15:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eAAeZSxswRMfhsC3JfSxpON+Ulvh1C5MB31Y7Izy7hg=; b=SRS2E+QOcZFipv4htQje4uPpuR
	jX+D8UTIjQygWsGA6KfoiyODbFilQM/Ejvlf2vTJFnlWwRtvKKWga0izFwDLR5KUVm+O58H/Ae9Yy
	sdPEcE+oSAZaK6M1thcVlp05jQzzDpQn7QTjYGnmz353ZYBXHJXvGYm2DbrBNjYkEoizy0Mi1Uixh
	Fg2FVq6WXGujY9u1NPOk3RlEvMvht9VKK1On/kEujMzlMetszor0ogtZl5weZ+cl8wxIU20JwkbWF
	KNoWp+JAVIEEYE5vx7dq547P5EjNfZd5YdDtqabjUMWS87sdz9Ig9zuAOqyO3n5+cWR/51c1wUuhj
	VTDYnPKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmvlX-00000005BJe-2MaR;
	Mon, 02 Feb 2026 15:23:03 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmvlV-00000005BJ5-1JbP
	for linux-nvme@lists.infradead.org;
	Mon, 02 Feb 2026 15:23:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2AE1D6011E;
	Mon,  2 Feb 2026 15:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AEDC116C6;
	Mon,  2 Feb 2026 15:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770045779;
	bh=u+CLsD0rgOYsL+CWqPMaVWL60KF39XcQLR9wrErM380=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CSbYulO+ptjtMm19DXpcqA42WKIP4RBZMfJb0YHm/C0IgRR555ndrF4+qo89es1wR
	 E3TgiqL3IRzbX8sfT5vm/F5yqT/j9LIgrc4A6kdEymbRyGo6lM5PprWFeaR/ajfBvj
	 atqnKRmUiVtDuOlupvNzLok53uuNvb08HY3gPOYgmXUGFN15sl+MaDLCvUnEpLBGo+
	 fsczM8KNj0igKYm8lg+fT238EdFDx0SBG1V9ZdJ49aJer48r/etTewh5qhuUTTwiGq
	 KbdoexYd8w5x3iIw6HdzCLkvudnM8VKGzbnnH2pB5h0rRxYY24BN3hpnsfR3FLMgD2
	 bL9+WOtyAxBmA==
Date: Mon, 2 Feb 2026 17:22:52 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>,
	kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	nitin.rawat@oss.qualcomm.com,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
Message-ID: <20260202152252.GM34749@unreal>
References: <20260202125738.1194899-1-pradeep.pragallapati@oss.qualcomm.com>
 <20260202143548.GA19313@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202143548.GA19313@lst.de>
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

On Mon, Feb 02, 2026 at 03:35:48PM +0100, Christoph Hellwig wrote:
> On Mon, Feb 02, 2026 at 06:27:38PM +0530, Pradeep P V K wrote:
> > Fix a NULL pointer dereference that occurs in nvme_pci_prp_iter_next()
> > when SWIOTLB bounce buffering becomes active during runtime.
> > 
> > The issue occurs when SWIOTLB activation changes the device's DMA
> > mapping requirements at runtime,
> >
> > creating a mismatch between
> > iod->dma_vecs allocation and access logic.
> > 
> > The problem manifests when:
> > 1. Device initially operates with dma_skip_sync=true
> >    (coherent DMA assumed)
> > 2. First SWIOTLB mapping occurs due to DMA address limitations,
> >    memory encryption, or IOMMU bounce buffering requirements
> > 3. SWIOTLB calls dma_reset_need_sync(), permanently setting
> >    dma_skip_sync=false
> > 4. Subsequent I/Os now have dma_need_unmap()=true, requiring
> >    iod->dma_vecs
> 
> I think this patch just papers over the bug.  

Agree

> If dma_need_unmap can't be trusted before the dma_map_* call, we've not saved
> the unmap information and the unmap won't work properly.
> 
> So we'll need to extend the core code to tell if a mapping
> will set dma_skip_sync=false before doing the mapping.

There are two paths that lead to SWIOTLB in dma_direct_map_phys().  
The first is is_swiotlb_force_bounce(dev), which dma_need_unmap() can  
easily evaluate. The second is more problematic, as it depends on  
dma_addr and size, neither of which is available in dma_need_unmap():

  102                 if (unlikely(!dma_capable(dev, dma_addr, size, true)) ||
  103                     dma_kmalloc_needs_bounce(dev, size, dir)) {
  104                         if (is_swiotlb_active(dev))

What about the following change?

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 37163eb49f9f..1510b93a8791 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -461,6 +461,8 @@ bool dma_need_unmap(struct device *dev)
 {
        if (!dma_map_direct(dev, get_dma_ops(dev)))
                return true;
+       if (is_swiotlb_force_bounce(dev) || is_swiotlb_active(dev))
+               return true;
        if (!dev->dma_skip_sync)
                return true;
        return IS_ENABLED(CONFIG_DMA_API_DEBUG);


