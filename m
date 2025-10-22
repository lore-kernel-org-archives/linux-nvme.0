Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 360E7CCD1AB
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Oct 2025 06:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mQgJ8vwmZ/K25Rw42edFtQM/yOxaOWDOff/htGeVNC8=; b=d7jN+ZMiDsVk3NjZaTx+g9NDqC
	qfmSCbKlqnkhli7JmRC21Db3lrNRCBC42eGzAN0QOZ2NLRHTa6lUf8d8Jx1GsSwMyXyQXDQvmHOlF
	NU36V1zg0Wp/yFzHaoXUtPolKp7Ystsr58MAkxitUNw9izhnau4gFdRBcY03QbhbaCCg44yCJFF2v
	b1ej5I/oGh8fxHQL4AdcEqnNlFScfVTQBkK+NvmdQhS7BHGrl1Wt0fLLLZya769jJnK/4v6OTmPwk
	j7ovfhf5ng5u3oGIn052Zb0s/TBj6NCDKtp9jR7woXfV72Tex3p8Zlb7jMJHRgbQnSSwnRUgvcT5E
	//NENjOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBS79-00000001ccr-3dCo;
	Wed, 22 Oct 2025 06:14:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBS77-00000001ccN-0PE1
	for linux-nvme@lists.infradead.org;
	Wed, 22 Oct 2025 06:14:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 90CF9227A88; Wed, 22 Oct 2025 08:14:18 +0200 (CEST)
Date: Wed, 22 Oct 2025 08:14:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 1/2] nvme-pci: migrate to dma_map_phys instead of
 map_page
Message-ID: <20251022061418.GC4317@lst.de>
References: <20251020-block-with-mmio-v2-0-147e9f93d8d4@nvidia.com> <20251020-block-with-mmio-v2-1-147e9f93d8d4@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020-block-with-mmio-v2-1-147e9f93d8d4@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251021_231425_289475_E89DB8B4 
X-CRM114-Status: GOOD (  11.68  )
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

This actually has block and nvme bits, so the subject line should
say that.

> +	unsigned int attrs = 0;

attrs is always zero here, no need to start passing it for the
map_phys conversion alone.

> +	unsigned int attrs = 0;

Same here.

> +	unsigned int			attrs;

And this is also entirely unused as far as I can tell.


