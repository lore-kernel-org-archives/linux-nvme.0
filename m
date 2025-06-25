Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C57C7115C
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jun 2025 16:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=c29CYBpAPPEOfpJB62td/zLaZYqQJd0Dmy9+pT82Gfs=; b=Wg67PaMpLTDMH21WKeUIPtQfvk
	rR8W9JzivzV6mvvfbFM0cEWIi6JjSX6WsYaP6SYS8qLpMa9Ced9O5Jxq98KS7G7OQ1KYmwV4D3UPs
	NMC63APph2nU6bxYQgIUBmAZDKmyC3xvkTOSrGnTnYRNotVGF+CZnpmPT2XdWQNiAfFwmgT7ZXRKm
	h3F/UodkmsSw5OLMXGfIt24dH/dAfrk5hT34UMtWvlsIZ4zrOUCgvkCQbrNyLu65krQ7Jg8OhscNf
	It7+l3dswESJA/feYbqzz7WvsLr3vWCVBmnPIkbazYY54dnD/Z2xp3J2/+sMRO55/hyPcotkhTGaK
	/7Cep1Rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUT0U-00000009Hhr-3kF0;
	Wed, 25 Jun 2025 16:29:54 +0000
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUOPe-00000008Uxc-3IKi;
	Wed, 25 Jun 2025 11:35:35 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: new DMA API conversion for nvme-pci v3
Date: Wed, 25 Jun 2025 13:34:57 +0200
Message-ID: <20250625113531.522027-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi all,

this series converts the nvme-pci driver to the new IOVA-based DMA API
for the data path.

Chances since v2:
 - fix handling of sgl_threshold=0

Chances since v1:
 - minor cleanups to the block dma mapping helpers
 - fix the metadata SGL supported check for bisectability
 - fix SGL threshold check
 - fix/simplify metadata SGL force checks

Diffstat:
 block/bio-integrity.c      |    3 
 block/bio.c                |   20 -
 block/blk-mq-dma.c         |  161 +++++++++++
 drivers/nvme/host/pci.c    |  615 +++++++++++++++++++++++++--------------------
 include/linux/blk-mq-dma.h |   63 ++++
 include/linux/blk_types.h  |    2 
 6 files changed, 597 insertions(+), 267 deletions(-)

