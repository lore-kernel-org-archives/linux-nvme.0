Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB05DCD1288
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 03:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bc0kHjC+as/QnIs1BoxXlOkaOIpjH72/JJPWebGP8MM=; b=X7IDuV5OnWNEK1Nx/2LNX99BMa
	qePt90TZyl54r7UjsHgIuDbF8qSWoenjxxEDVtfnCjrRUzvq3Zwjmg0fGrHt3bsVSvTJbPmGLbaMw
	bWE2k29wcMtJ8DPKc6fVqTrS3hfxhsFw06xl6dz3wcCvOSh+elYf2Pxd/1lgvKy+DY8WM67arhG6+
	ThrXc4DqyoUKnKDDfJWSWk1Y15ztEhVEQJsNoeiihawiN64u1TDdbPIs3gkZenP3Nz9Qi6YIG997r
	zOykpq85eUnPvmvJXXntbN3jsCiGlj959hbWpVrps2mN5YMqhNoebSZYLXAZkIEDlTcLi1+IGh0QA
	RZBl3/7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrrUm-0000000DoXI-14cd;
	Wed, 03 Apr 2024 03:41:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrrUi-0000000DoWJ-3hIB
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 03:41:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D9D1168BFE; Wed,  3 Apr 2024 05:40:55 +0200 (CEST)
Date: Wed, 3 Apr 2024 05:40:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v2] nvme: split nvme_update_zone_info
Message-ID: <20240403034055.GB21683@lst.de>
References: <20240402144754.751976-1-hch@lst.de> <ZgxjYbm0j-4GgVAr@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgxjYbm0j-4GgVAr@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_204101_086627_9946F35E 
X-CRM114-Status: GOOD (  14.74  )
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

On Tue, Apr 02, 2024 at 01:58:25PM -0600, Keith Busch wrote:
> On Tue, Apr 02, 2024 at 04:47:54PM +0200, Christoph Hellwig wrote:
> > +	lim->chunk_sectors = ns->head->zsze =
> > +		nvme_lba_to_sect(ns->head, zi->zone_size);
> 
> Hey, since chuck_sectors is only 32 bits and zone_size is 64, do we need
> to worry about massive zones breaking this limit? Unlikely as we are to
> see a multi-terabyte zone, it's easy enough to check. We never have
> before though, so I guess we're confident it won't happen?

Reasonable confident.  Adding an overflow check probably would not be a
bad idea.  I can look into a patch for that.

