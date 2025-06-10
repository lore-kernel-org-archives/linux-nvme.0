Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782CAC61DB2
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Jun 2025 05:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WMnK/6ynhLT+c63+86ZArPvsHQRCDzd84muxxrMS1W8=; b=H+iemZdglRRv1tFrw+hg/yNtxZ
	bBs/vp+L0GufsWBWp6c7CqnW1zqT1Vq2ccHTU0kNhbCecyJI9JbQJZTFDfLMOdHyXKKZ26jrkMY1E
	XPcZel4ykdmZQfpoVxWbW44Qxlkp5ITJ5iulWS/VKLspAMX9X+XWud680+PShDS5cUnabinMYgi5y
	izVU5a4SxrQ85sP9qZS3Bhq0KcdS5F38i6LGKfbaX07+i5JryyiEavS31wcObgTHhovjLSwbBjPV4
	bLqpMmLNC8oovxE3UNNTWWTk0RCdkuxgpmdb3zGn3rKmvwOQvMa2uXpRQN1DZxqU2XU5z2sYh7JbP
	wvK2mDbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOrCk-00000005neN-1CkE;
	Tue, 10 Jun 2025 05:07:22 +0000
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOrCf-00000005ndo-0la8;
	Tue, 10 Jun 2025 05:07:17 +0000
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
Subject: new DMA API conversion for nvme-pci
Date: Tue, 10 Jun 2025 07:06:38 +0200
Message-ID: <20250610050713.2046316-1-hch@lst.de>
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
for the data path.  Note that I've dropped the the Tested-by: and
Reviewed-by: tags from the version Leon sent out with the DMA API as
there's been quite extensive changes.

Diffstat:
 block/bio-integrity.c      |    3 
 block/bio.c                |   20 -
 block/blk-mq-dma.c         |  162 +++++++++++
 drivers/nvme/host/pci.c    |  615 +++++++++++++++++++++++++--------------------
 include/linux/blk-mq-dma.h |   63 ++++
 include/linux/blk_types.h  |    2 
 6 files changed, 596 insertions(+), 269 deletions(-)

