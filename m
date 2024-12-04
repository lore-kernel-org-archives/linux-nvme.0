Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5E8E7716B
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Dec 2024 08:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mvSFljb18dJzJrl+Mqf+TNDi6z/iS50XWifDL83+VJY=; b=2xeNvtTxfmZ5trabRsJegP/8TE
	8q4vjcy+cxncqYe+JnNMNKjAz5Kztve01ZH+rjP5tJHYm36LGJxocluQcv9gQkM0fKnMIEe94sEti
	y6PmoCLm00RKtanT/HZPiGKKd5mKQ77Qd8gPMTxD7OxyXrqNhWPaMPnELUnnB5K9mG9MhAW6NsNis
	GzgzhKtdH1la3z9sU0rZGFLA+RA1gZiI7CHSKmOKf6/8aFHJ1OILG8ESb7u2gEZC5WYzNpO84zKUJ
	AS9pqF/OK6iAHltF9fN+bRI7bHx4Y9/nAymbE3dufuAy7C5Q9qFQNbTYtmdwDf7/ee6cggADfdf7A
	gujKw9cQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIlAl-0000000BxcN-2L7B;
	Wed, 04 Dec 2024 08:55:51 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIlAi-0000000BxbE-3H5N
	for linux-nvme@lists.infradead.org;
	Wed, 04 Dec 2024 08:55:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id B2118A41BEB;
	Wed,  4 Dec 2024 08:53:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1961C4CED6;
	Wed,  4 Dec 2024 08:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733302546;
	bh=DI2AhM7fs3tybLBTYtd+/NHgZwHB0esLgpVFPKPNYss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fa0AAU/SloQMbJDfDY+iH0vFN9SJCwwU5FwXg4ca5QUPa9fk+pN28KT6sRnxQqj6P
	 Ej2qwbLre7C6Z43sm+/6/7UPezRX08Ca80rWDfpuSCflusxRnCpJ+gl3aXtbD98Kwr
	 lNW1nPLCBX5Nrp7vocuLGw+gX7lemG7UWDdeQUA1zk4qxjaxvsQX4j7mwQkNh6NP5x
	 tLKPhDaMiAooXFyFpzs0fpDwJkItrQ7Hgwu9G5RUslkp38QKT1Eyz25hK9edmCzEf2
	 2t1t1AJ6dKp5z1HqWV5bLdMrViipY0XQGxNJ2l9mlnBeKBboCFh6RdXfCnAG37R5CS
	 sFJc8BVY4euGw==
Date: Wed, 4 Dec 2024 10:55:41 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Subject: Re: [PATCH] nvme-pci: don't use dma_alloc_noncontiguous with 0 merge
 boundary
Message-ID: <20241204085541.GN1245331@unreal>
References: <20241204004240.687875-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204004240.687875-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241204_005548_886528_365B7721 
X-CRM114-Status: GOOD (  14.85  )
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

On Wed, Dec 04, 2024 at 09:42:40AM +0900, Christoph Hellwig wrote:
> Only call into nvme_alloc_host_mem_single which uses
> dma_alloc_noncontiguous when there is non-null dma merge boundary.
> Without this we'll call into dma_alloc_noncontiguous for device using
> dma-direct, which can work fine as long as the preferred size is below the
> MAX_ORDER of the page allocator, but blows up with a warning if it is
> too large.
> 
> Fixes: 63a5c7a4b4c4 ("nvme-pci: use dma_alloc_noncontigous if possible")
> Reported-by: Leon Romanovsky <leon@kernel.org>
> Reported-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Except moundary vs. boundary, everything looks good.

Thanks for the fix.
Reviewed-by: Leon Romanovsky <leon@kernel.org>

