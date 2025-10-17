Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95BCCCD195
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Oct 2025 06:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R/8JCrhZoeHd43WNh8myD03AaP8n6N922gj+ormdT3M=; b=1zbeYpY4mjEI8KuJat8pqrmGkX
	nrpR/qVvYaL0t528h7Y+iFrDrJmrz30jYhaqgoWQcZzkvXuojbGaJ+UP9etbxd88+HxucBEQcfi0u
	0/p17/3d106JJ3YpUlLUjWhccnqyzldtzR1i9Mk564SKm68jviCUYGf95v7EV2JJ0n1kKTGmIHjyY
	j6niwO7kEhMQQF+iBu9afhAjno4HBNfbdXQ8tfBCbDHkzA6sPmArAwLN+CwgbN9FzJz42ZqNBFkpD
	BvYUjcfX8g6HXHvRe8rTGtINhh6n3JSM52dkv3VCniGFaNvXRgeoOYufvMnIw1ywo8pBUPilruq9E
	Be78BgkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9dp3-00000006keI-0J7l;
	Fri, 17 Oct 2025 06:20:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9dp1-00000006kck-0M4p
	for linux-nvme@lists.infradead.org;
	Fri, 17 Oct 2025 06:20:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B951C227AAA; Fri, 17 Oct 2025 08:20:09 +0200 (CEST)
Date: Fri, 17 Oct 2025 08:20:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/3] nvme-pci: unmap MMIO pages with appropriate
 interface
Message-ID: <20251017062008.GB402@lst.de>
References: <20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com> <20251017-block-with-mmio-v1-2-3f486904db5e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-block-with-mmio-v1-2-3f486904db5e@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251016_232015_260640_6D9DF161 
X-CRM114-Status: GOOD (  13.78  )
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

On Fri, Oct 17, 2025 at 08:31:59AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Block layer maps MMIO memory through dma_map_phys() interface
> with help of DMA_ATTR_MMIO attribute. There is a need to unmap
> that memory with the appropriate unmap function, something which
> wasn't possible before adding new REQ attribute to block layer in
> previous patch.

DMA_ATTR_MMIO only gets set in the following patch as far as I can
tell.

The more logical way would be to simply convert to dma_unmap_phys
here and then add the flag in one go as suggested last round.


