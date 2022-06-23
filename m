Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F231AC43334
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jun 2022 13:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yAJsgZfwIrPKN4iqCGUhyr4AtIjVIzzNDmwO9f0/lT8=; b=qa9xsIhw+WotKmhEiPmCXe6ABT
	5My9hwqIdp2PGUM0KZ7anZNCWDpKmsQ/hmLhefP5y0AuEGNWwQdIOZPYHIXVGYNnLCJwKkAPY8/qa
	1C6ZZHnkZ8PQEEBMuMKodX87N1BxRxU07kPFVIak/OUJnx8PlRrhT4tIxeRV0F/Jr3D2cTLCQ7bSu
	bgo9hArV8jqm8BxQGvyO7icvf7AjR+zz3/4uGP0Nh2pQNsTiLt/98tjOhG/PNdFbe2+I1JT+mGdRj
	ZwvrI/MrrlvebhRuGSKVLFbGiACg4Axu2YtXnsGm2C3XwRGUp3/6eW8XWrwARbBpV/X1WR9M/s+2r
	IjAYXGrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4NIB-00FQsI-NM; Thu, 23 Jun 2022 13:54:43 +0000
Received: from [2001:4bb8:189:7251:9e7:d0ec:8481:b319] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4NI9-00FQs5-JQ; Thu, 23 Jun 2022 13:54:42 +0000
Date: Thu, 23 Jun 2022 15:54:39 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvmes fixes for Linux 5.19
Message-ID: <YrRwn7dWdJcI9DSL@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

The following changes since commit 2645672ffe21f0a1c139bfbc05ad30fd4e4f2583:

  block: pop cached rq before potentially blocking rq_qos_throttle() (2022-06-21 10:59:58 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.19-2022-06-23

for you to fetch changes up to e6487833182a8a0187f0292aca542fc163ccd03e:

  nvme: move the Samsung X5 quirk entry to the core quirks (2022-06-23 15:22:22 +0200)

----------------------------------------------------------------
nvme fixes for Linux 5.19

 - fix the mixed up CRIMS/CRWMS constants (Joel Granados)
 - add another broken identifier quirk (Leo Savernik)
 - fix up a quirk because Samsung reuses PCI IDs over different products
   (me)

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme: move the Samsung X5 quirk entry to the core quirks

Joel Granados (1):
      nvme: fix the CRIMS and CRWMS definitions to match the spec

Leo Savernik (1):
      nvme: add a bogus subsystem NQN quirk for Micron MTFDKBA2T0TFH

 drivers/nvme/host/core.c | 14 ++++++++++++++
 drivers/nvme/host/pci.c  |  6 ++----
 include/linux/nvme.h     |  4 ++--
 3 files changed, 18 insertions(+), 6 deletions(-)

