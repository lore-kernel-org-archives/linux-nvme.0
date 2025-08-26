Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D821CA0FF0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Aug 2025 22:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K2Zg3efzzB73h3x5Mnu3OjZ7AiGfDQFRKNxV+q52Sho=; b=I4WF1u2qHA6TWVdtleE4/vHNuO
	BIurDzg/SHfZRJx6qmBG8vB+VPxBVjSfV+iCVmbd9vnjRCFwUX7zMqgV6poTRTAiaCmvbLYSlTH2u
	8uil304CYkftDYUSp3PGlid67u7ChaKJG6Vz/7Pv6ChjQfDDYRuYfcenfa7SzmimpS8Sa8ylhzsYU
	gnmoLzaxOWlZzqYLUS1LKp7NCAYCenoIc0ZTPOST/21rzho7EVWUqhJYOcZ1OHGAqjm8DJg4Uh3y6
	JjRuml4tdCMzvIT7aKhyRWdzr76IQqos7zyMcLzs+LZyo1z4wSwhl0xaPXjKyakNGLA3R5cZLe44J
	V1ePW1AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ur2EC-0000000DGnc-2sO6;
	Tue, 26 Aug 2025 22:33:20 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ur2EB-0000000DGnK-1FqU
	for linux-nvme@lists.infradead.org;
	Tue, 26 Aug 2025 22:33:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5AFB960228;
	Tue, 26 Aug 2025 22:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84940C4CEF1;
	Tue, 26 Aug 2025 22:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756247598;
	bh=enAWv7FM+3cCYyKIq2hsdtFuRu631uhygsKoaTBzjso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mvAZzZJ16Lko9gWeA6XLyGd0vlNbHlTJ+grcokJ3kz7RBiXyBw7uMkBBbcHDOQcoe
	 fOUS9A0kfmH8cp/OebZHMMchUkyWWE2AjJqWkRWGvI89IBtHhAdL/JiUUIqjER+yt4
	 iwZzxCWbdhSY3UkqRtzVWTfFXsebYOu44eezPldyHW0QP5oG5xbzhgjCk8ECy+YV6F
	 tB7yigAWW93QqgPSUG9bFU+C1kxXPzXK8vcGKUPgNOjIEx6DsGTEr2yWSqw3hBE0J8
	 DdT0leJ3Pjo9EPGaB/ftg4PJIwRi1AR2N8VqJ7mxJFeujjgW1O82iDx92Hx55O0fk3
	 iFz7f5gn9CIww==
Date: Tue, 26 Aug 2025 16:33:15 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, iommu@lists.linux.dev
Subject: Re: [PATCHv3 1/2] block: accumulate segment page gaps per bio
Message-ID: <aK42K_-gHrOQsNyv@kbusch-mbp>
References: <20250821204420.2267923-1-kbusch@meta.com>
 <20250821204420.2267923-2-kbusch@meta.com>
 <aKxpSorluMXgOFEI@infradead.org>
 <aKxu83upEBhf5gT7@kbusch-mbp>
 <20250826130344.GA32739@lst.de>
 <aK27AhpcQOWADLO8@kbusch-mbp>
 <20250826135734.GA4532@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826135734.GA4532@lst.de>
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

On Tue, Aug 26, 2025 at 03:57:34PM +0200, Christoph Hellwig wrote:
> On Tue, Aug 26, 2025 at 07:47:46AM -0600, Keith Busch wrote:
> > Currently, the virtual boundary is always compared to bv_offset, which
> > is a page offset. If the virtual boundary is larger than a page, then we
> > need something like "page_to_phys(bv.bv_page) + bv.bv_offset" every
> > place we need to check against the virt boundary.
> 
> bv_offset is only guaranteed to be a page offset if your use
> bio_for_each_segment(_all) or the low-level helpers implementing
> it and not bio_for_each_bvec(_all) where it can be much larger
> than PAGE_SIZE.

Yes, good point. So we'd have a folio offset when it's not a single
page, but I don't think we want to special case large folios for every
virt boundary check. It's looking like replace bvec's "page + offset"
with phys addrs, yeah?!

