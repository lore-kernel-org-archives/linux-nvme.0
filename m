Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A25C43458
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2026 11:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=WIheEqXcI0pqpZrSG7DrlY2Tym
	VQaERAP5/yuxVR+ugErGhzDuJpYHPFL/YMZy4FPEb52zI94KYKg6nQMle8dAY+wX9ReVsylafgb7r
	Cbfkrb9tTd3ErgR9nO9MflErj0Xs0q8SBN39MFQZtUZY9/DRDioJwHpAbac2mM22SutoSD7u3r5Hd
	aVMFEmggaoAE+EvIWlo4TvaH7LRBVszHMz8oHlQeTI2I7jkGdvl7HJlYSc7IwRlPMLt4U2qiwMLpD
	fF78sZCZhpuUlx4bnTVMqwBbM2wCM1Oht7poUZ28tLfumFXltXijdVwyAqdSZFlug1ouNxK+9wLLs
	ROYcKfYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weX2t-0000000GtXF-0yR2;
	Tue, 30 Jun 2026 11:54:31 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weX2s-0000000GtWv-0GZT;
	Tue, 30 Jun 2026 11:54:30 +0000
Date: Tue, 30 Jun 2026 04:54:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 1/2] nvmet-rdma: factor out response resource cleanup
Message-ID: <akOudox5yqAfsdLF@infradead.org>
References: <20260629051529.810925-1-shinichiro.kawasaki@wdc.com>
 <20260629051529.810925-2-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629051529.810925-2-shinichiro.kawasaki@wdc.com>
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


