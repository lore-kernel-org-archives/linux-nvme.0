Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C180CCD183
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Oct 2025 15:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=u+32r1DFsGguvf2bIcE9lArd2zYYfuPUxBWz8SAq1RU=; b=tLL7BfWxEgCXZ5S4UGoxpWCp10
	4fLDPrJ//NIkliyOo05kMDYuESxLlQ0Mq50O2Kj3Rm5mQvAZIP7yYUnMP1Gxopi87xTCcv1YZ+N7V
	4pUbQFlhZsukOo5tNq978+RcoFLP8WAAtwrM/U5cyviJ/Ax5yubvYsXxEi7wqEFl2LNR0pTAx9BY8
	I1cAvxxHUzoaqwpKQfI0iFa3UynFsgwpwHn+aFJkR2fbtnpCCN3fr8oNAEWN5sD0LGQm0kvUnMLe/
	/wgmUXIajkF2b8oVltwJCAnDqQu9kotY3olz04EqJgXL9p0rG7gcbd71te/VxNoFuOwfgd6O3vcBY
	OdGY3HPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8KZ6-0000000DhUa-04Ho;
	Mon, 13 Oct 2025 15:34:24 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8KZ3-0000000DhTD-12Tt
	for linux-nvme@lists.infradead.org;
	Mon, 13 Oct 2025 15:34:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8E84348D37;
	Mon, 13 Oct 2025 15:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0256FC4CEFE;
	Mon, 13 Oct 2025 15:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760369660;
	bh=PRFLXFpda4njnxhl0lQayxdFizo+kwRd6yiTUvOdd7c=;
	h=From:To:Cc:Subject:Date:From;
	b=NCA3zVJyyGgDjREB++TJQDBF9C48uL2utB84JAMAZ+5526+kP9oBibWvDKO94g2dR
	 Sbif4yn+JXkiuetm40aux2cbf8HsOrNdWF7+MSx5eY5MxszJ7mdldP8iV1K1xHlIMO
	 xrabJuLKcMpOkXJCjiRg7BBXr1MlUf58ugWDzeYK8GoodxPTzF6VbZiShBDUt1GIYI
	 EmNHrhCuVIqHZQzjqCdckhkVNvcHwUpvrF00mUyUtqrDcs+mIGI51pDMo1R118EoQE
	 fiaxyg/Dd831rEvjydqrtUD6l6oSObENVWpBQOmhdD/uKgu3Eb2N22+vPFmVOrGioI
	 oJfNF3FxaLTnw==
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 0/4] Properly take MMIO path
Date: Mon, 13 Oct 2025 18:34:08 +0300
Message-ID: <cover.1760369219.git.leon@kernel.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251013_083421_302559_C27FBE4C 
X-CRM114-Status: UNSURE (   5.64  )
X-CRM114-Notice: Please train this message.
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

This is NVMe and block specific patches from my DMA series [1] which
improved DMA physical API to properly support MMIO memory.

Thanks

[1] https://lore.kernel.org/all/cover.1757423202.git.leonro@nvidia.com/

Leon Romanovsky (4):
  blk-mq-dma: migrate to dma_map_phys instead of map_page
  blk-mq-dma: unify DMA unmap routine
  block-dma: properly take MMIO path
  nvme-pci: unmap MMIO pages with appropriate interface

 block/blk-mq-dma.c            | 52 +++++++++++++++++++++++++++++++++--
 drivers/nvme/host/pci.c       | 18 ++++++++----
 include/linux/bio-integrity.h |  1 +
 include/linux/blk-integrity.h |  3 +-
 include/linux/blk-mq-dma.h    | 35 ++---------------------
 include/linux/blk_types.h     |  2 ++
 6 files changed, 68 insertions(+), 43 deletions(-)

-- 
2.51.0


