Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6C5CF34B6
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Nov 2025 14:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9OsBywMdj4mlSSMK9x3/LEdrmHV24dRXBzue7MeErJU=; b=p4S4IvJT/xs68AcJ8ndeQi3RMD
	rlm1+Hr4yV4mOvxPPZxs5PjWXXOPkT3Lfi7qJdUnso9ZseEtotro0O3oTRGDfBAWmRvxW8M9FvBii
	H5D77B6dZARAO4vfPrp0tnyqjGFZMyvGemN1dQTxOQYy3pwJLIZ3v/e2vNY/2TVQ6mGr9tfxSFJCH
	7j6eg5ic+5frBjjRNO87qgnT2bEnSh4aVhepclPA9zwobgcEJmm2gp9PJ8hTbuRhOIi6oauLT+FaM
	2Tg10EsaRrRBpTeHadagcf/HJqkFh1E3zSIZhCv0ihC4enBV/KL2cEOz+g9h0hFYwgIX6qdYP8RGD
	y0ugmveA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLjQc-00000003Ovr-0p4X;
	Wed, 19 Nov 2025 14:45:02 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLjQZ-00000003Ov5-25WI
	for linux-nvme@lists.infradead.org;
	Wed, 19 Nov 2025 14:45:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D194C42DE5;
	Wed, 19 Nov 2025 14:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B231EC4CEF5;
	Wed, 19 Nov 2025 14:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763563498;
	bh=8VS8aG0Ml+tlomReLo+mvEAE+QAcyleX7yGJ+roLEpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rqjE47m3hZL12U5KCPY0FxdOzOIj1HJu2mx/X4e1bFVuBhoVs4L7m0MpL0neZYWro
	 rglyvgc4ErM/okl218fkg3b8LsGN6Tisze+C3jT4pyzDhh4bVCKKCIWiZYkokSPf4M
	 6NB/wzfD53cqHhfvTOWEs5ZHkINh4xCBR8gy4e7U8ZH+Q+vhvWNoRIGzr7QBRB1WrG
	 a/soA1nq3DT1rZmgZ3IZRyl13CsphqTku2s15SmvudcghWfb3y7GmF6XptxxHZ0WxO
	 YE2poOQgtOSbO/3WuUc8snV+VM5webVLpYInBQZsvddaIfiLINPpI/P+oS0iLu0gCz
	 mxHwJoBqQF6KQ==
Date: Wed, 19 Nov 2025 16:44:52 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2 1/2] nvme-pci: Use size_t for length fields to handle
 larger sizes
Message-ID: <20251119144452.GI18335@unreal>
References: <20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com>
 <20251117-nvme-phys-types-v2-1-c75a60a2c468@nvidia.com>
 <20251118050311.GA21569@lst.de>
 <20251119095516.GA13783@unreal>
 <20251119101048.GA26266@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119101048.GA26266@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251119_064459_556037_6D087BAD 
X-CRM114-Status: GOOD (  14.67  )
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

On Wed, Nov 19, 2025 at 11:10:48AM +0100, Christoph Hellwig wrote:
> On Wed, Nov 19, 2025 at 11:55:16AM +0200, Leon Romanovsky wrote:
> > So what is the resolution? Should I drop this patch or not?
> 
> I think it should be dropped.  I don't think having to use one 96-bit
> structure per 4GB worth of memory should be a deal breaker.

Christoph,

It seems like no size change will before and after my change.
https://lore.kernel.org/linux-nvme/20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com/T/#ma575c050517e91e7630683cf193e39d812338fa4

Thanks

