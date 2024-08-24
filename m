Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4564C5472C
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Aug 2024 08:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tPuCwHyIKcY3Z4wwkH2t8Pvr1gWq8xRTEmWqoLqXl88=; b=Mq0mkf3XTLqnqzAIYhWFudVH7I
	HqObQ2ncel1+f3r50fZOVH9ahsj6W9I4SW/eRoH8KVjrgn8t6GVWS/pSI33bzeAYv1ZSM3dNx8bBc
	ZXiIdxejOfe1YJTPbwEPPSo5Np5VzjVwmpqVO6fL7CTnHCwiZhCIXhBb/EO2CXS1zIHTiAt92Enlo
	R7suqXFSrYClVzaXbclborNRT6Z67x2q9ZmDjWH24jUi726aw28Z7fBuaAbELZ+buTvQofetU+rPm
	JP+pAUL3btYL+9NwbbDhiHZRMUSE4GnfyiBUkOopP7hBSulc/JD0VO7ZsBNFIrbuUxr03xkN7pndk
	If2ELLSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shlwi-00000001oZO-3cAj;
	Sat, 24 Aug 2024 08:16:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shlwf-00000001oYd-2Oy6
	for linux-nvme@lists.infradead.org;
	Sat, 24 Aug 2024 08:16:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4F46A227A87; Sat, 24 Aug 2024 10:16:18 +0200 (CEST)
Date: Sat, 24 Aug 2024 10:16:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: mhklinux@outlook.com
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, robin.murphy@arm.com, hch@lst.de,
	m.szyprowski@samsung.com, petr@tesarici.cz, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: Re: [RFC 0/7] Introduce swiotlb throttling
Message-ID: <20240824081618.GB8527@lst.de>
References: <20240822183718.1234-1-mhklinux@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822183718.1234-1-mhklinux@outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240824_011625_845451_C2A558F2 
X-CRM114-Status: GOOD (  19.87  )
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

On Thu, Aug 22, 2024 at 11:37:11AM -0700, mhkelley58@gmail.com wrote:
> Because it's not possible to detect at runtime whether a DMA map call
> is made in a context that can block, the calls in key device drivers
> must be updated with a MAY_BLOCK attribute, if appropriate. When this
> attribute is set and swiotlb memory usage is above a threshold, the
> swiotlb allocation code can serialize swiotlb memory usage to help
> ensure that it is not exhausted.

One thing I've been doing for a while but haven't gotten to due to
my lack of semantic patching skills is that we really want to split
the few flags useful for dma_map* from DMA_ATTR_* which largely
only applies to dma_alloc.

Only DMA_ATTR_WEAK_ORDERING (if we can't just kill it entirely)
and for now DMA_ATTR_NO_WARN is used for both.

DMA_ATTR_SKIP_CPU_SYNC and your new SLEEP/BLOCK attribute is only
useful for mapping, and the rest is for allocation only.

So I'd love to move to a DMA_MAP_* namespace for the mapping flags
before adding more on potentially widely used ones.

With a little grace period we can then also phase out DMA_ATTR_NO_WARN
for allocations, as the gfp_t can control that much better.

> In general, storage device drivers can take advantage of the MAY_BLOCK
> option, while network device drivers cannot. The Linux block layer
> already allows storage requests to block when the BLK_MQ_F_BLOCKING
> flag is present on the request queue.

Note that this also in general involves changes to the block drivers
to set that flag, which is a bit annoying, but I guess there is not
easy way around it without paying the price for the BLK_MQ_F_BLOCKING
overhead everywhere.


