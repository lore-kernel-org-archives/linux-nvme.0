Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722D1C77B7C
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jun 2025 17:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Q097w0ZyqCvrAzlM9OmfT43N2f+DOIgOZ476YQyVkRM=; b=O1dbOm+25hS4VVXeCxA2BbkS0Y
	gsN3lf8CD0YStpBFT8K/uMbb+7t3f85Z6+F09juf+jIZBR1z5T4yKAJGhwN1dMuv0XUyrZ1E8g5BP
	kykhoYXoPRSShG0HJkbkELAaRIbH02crcdL5uldmpWEvKgAycjTgK+FwuKJ+u7pNlkeLIBhpYP8hI
	fDq+/UedUJZGuQgiSOdRQH5m5QmyEjpTkaFhvlz/rBVfNmgq8RYv7Fk6i2/nOlA1bWQjZ79WQh1WV
	N63Fytn3WXGTA/gCuasRbNZiYyQslZJoUc/zWFIlzEUz+IsIftcmpgSR8OOeyinox4KNR/C2Z3CN1
	YMmltH7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTkt6-00000003XjC-3ffq;
	Mon, 23 Jun 2025 17:23:20 +0000
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uThuy-00000002zn3-0oc2;
	Mon, 23 Jun 2025 14:13:04 +0000
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
Subject: new DMA API conversion for nvme-pci v2
Date: Mon, 23 Jun 2025 16:12:22 +0200
Message-ID: <20250623141259.76767-1-hch@lst.de>
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

