Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFC2CA0FE7
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Aug 2025 14:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1gAKaymMdJw9QRaQZwEz+4g6I7V87MF2spGYgqYSDNs=; b=W+dSNA5/uC+tzVh+oz+2xP2BEr
	gHsoxrJH5X1aRYrDiY3BhjstOVupyxnyLwJe9CWbTTfxVFgA7o3IZdZ96HyJHeBqJsh/NzkTSnuXP
	sZ+2R+gJD+A1Mao1DrN1SabZdxmNPAVOvHVhYkrdipG9aRSOEwbyeBY9BCPJM3Y1Ez2R12KtguASV
	QezlwRHomDCBGibznzlJGm9cWfXON+TsiAm7HZvxvpbDd305dNrUIV/JduQQTfV0h4Zbi/ObSBIB/
	hgfCGn6qK/ZR6zU1Y+1jPIrKU8U33OV92ZX86JLeV8ImKaMjFFj+sggQM6/BvXCxjIhC5wH5zAy2r
	md2l2HIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqud7-0000000CG6a-26Ff;
	Tue, 26 Aug 2025 14:26:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uquBA-0000000CAST-1McK
	for linux-nvme@lists.infradead.org;
	Tue, 26 Aug 2025 13:57:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4305667373; Tue, 26 Aug 2025 15:57:35 +0200 (CEST)
Date: Tue, 26 Aug 2025 15:57:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Christoph Hellwig <hch@infradead.org>,
	Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	iommu@lists.linux.dev
Subject: Re: [PATCHv3 1/2] block: accumulate segment page gaps per bio
Message-ID: <20250826135734.GA4532@lst.de>
References: <20250821204420.2267923-1-kbusch@meta.com> <20250821204420.2267923-2-kbusch@meta.com> <aKxpSorluMXgOFEI@infradead.org> <aKxu83upEBhf5gT7@kbusch-mbp> <20250826130344.GA32739@lst.de> <aK27AhpcQOWADLO8@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK27AhpcQOWADLO8@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250826_065740_503675_33921906 
X-CRM114-Status: GOOD (  12.83  )
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

On Tue, Aug 26, 2025 at 07:47:46AM -0600, Keith Busch wrote:
> Currently, the virtual boundary is always compared to bv_offset, which
> is a page offset. If the virtual boundary is larger than a page, then we
> need something like "page_to_phys(bv.bv_page) + bv.bv_offset" every
> place we need to check against the virt boundary.

bv_offset is only guaranteed to be a page offset if your use
bio_for_each_segment(_all) or the low-level helpers implementing
it and not bio_for_each_bvec(_all) where it can be much larger
than PAGE_SIZE.

