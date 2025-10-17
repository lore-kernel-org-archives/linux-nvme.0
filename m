Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3E4CCD184
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Oct 2025 06:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MhmKoVrJFgUSIk0D8mmlrjBp+oq9ZPreXDktiaL2hag=; b=VLPtGDbCPdCKVOtJhnSURjdL3H
	zI3336/mxcc6GOHBkVtcj2JDwdjEiZCmFcboLNCbAjb9VmXqfJCHsHEzNDwiypl0OUGOBgb+JoMLN
	HhEHbS8kjRXqjnX2u5XJWDwwtyl3G3IbS/Dqh+mILlDk6QBbZC0zbRPWz1tSngUlIQFCK7ZPKdLRT
	Bpyrr9oM6jzbW9NuQVyu1pfMgdBQvb5SicIpKMK0G8hsg3bXRqN4ijfrbG4iVeWgWeSQsdKoGsHHY
	hffOr69dHyX0yNUFieI07N3F8xSKTqMrcue/LwNL6ViLsIbVba4JaSpRlurawBxCpvQVV9L7GOBax
	kFWe3idw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9dnp-00000006kDm-395d;
	Fri, 17 Oct 2025 06:19:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9dnn-00000006kBf-2qSb
	for linux-nvme@lists.infradead.org;
	Fri, 17 Oct 2025 06:19:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BC2AB227A87; Fri, 17 Oct 2025 08:18:48 +0200 (CEST)
Date: Fri, 17 Oct 2025 08:18:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] blk-mq-dma: migrate to dma_map_phys instead of
 map_page
Message-ID: <20251017061848.GA402@lst.de>
References: <20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com> <20251017-block-with-mmio-v1-1-3f486904db5e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-block-with-mmio-v1-1-3f486904db5e@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251016_231859_854557_4DFF1BDF 
X-CRM114-Status: GOOD (  12.56  )
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

On Fri, Oct 17, 2025 at 08:31:58AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> After introduction of dma_map_phys(), there is no need to convert
> from physical address to struct page in order to map page. So let's
> use it directly.
> 
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

You forgot to pick up my review from last round.


