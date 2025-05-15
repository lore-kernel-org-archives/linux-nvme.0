Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919F2C2D0CD
	for <linux-nvme@archiver.kernel.org>; Thu, 15 May 2025 11:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GMoJk3nIUzRLwu8Ju+e04/dNWPdEo2bfpzS7WTSeD3U=; b=GI9ljcbT5bER7IihcJY5nBhmkb
	SPZ6xxGRHoyW+yvrIMJDYlHGHXHQbe3ruuCwF7SEd7hlYi4jQ9zghAqNUfz4G/znhLh4cRFtDvmTn
	OGPh7m4Ko4bNpVLlxNEWJLRG4FKtqjE5A+AZhF5WP5KdHO1gKoq5D0ivdHNXlgMa5LFb3hGfHCldd
	fdjquN03o/UOaYdpndevqgkh4Ikqd2nFuCoOcfVe1zCwxMZQMbr41xNF0LR7eV9TfnFg1udwKte9b
	gadhaVCP/OcIMWBLGbcqGJxzAQlNtbujEiUe2TVXFryhGH0f1O2EkCL4Cm5iFZN5Ff879rCJttTaZ
	dmnB8anQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFXC6-00000000TMg-2CUq;
	Thu, 15 May 2025 11:56:10 +0000
Received: from 2a02-8389-2341-5b80-81b5-a24e-41ab-85a6.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:81b5:a24e:41ab:85a6] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFXC3-00000000TMR-45rp;
	Thu, 15 May 2025 11:56:08 +0000
Date: Thu, 15 May 2025 13:56:05 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.15
Message-ID: <aCXWVQ0-cbSsQXFk@infradead.org>
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

The following changes since commit 8098514bd5ca98beca6ec725751d82d0d5b492d8:

  block: always allocate integrity buffer when required (2025-05-12 07:14:03 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.15-2025-05-15

for you to fetch changes up to e765bf89f42b5c82132a556b630affeb82b2a21f:

  nvme-pci: add NVME_QUIRK_NO_DEEPEST_PS quirk for SOLIDIGM P44 Pro (2025-05-14 17:16:16 +0200)

----------------------------------------------------------------
nvme fixes for linux 6.15

 - fixes for atomic writes (Alan Adamson)
 - fixes for polled CQs in nvmet-epf (Damien Le Moal)
 - fix for polled CQs in nvme-pci (Keith Busch)
 - fix compile on odd configs that need to be forced to inline
   (Kees Cook)
 - one more quirk (Ilya Guterman)

----------------------------------------------------------------
Alan Adamson (2):
      nvme: multipath: enable BLK_FEAT_ATOMIC_WRITES for multipathing
      nvme: all namespaces in a subsystem must adhere to a common atomic write size

Damien Le Moal (5):
      nvmet: pci-epf: clear completion queue IRQ flag on delete
      nvmet: pci-epf: do not fall back to using INTX if not supported
      nvmet: pci-epf: cleanup nvmet_pci_epf_raise_irq()
      nvmet: pci-epf: improve debug message
      nvmet: pci-epf: remove NVMET_PCI_EPF_Q_IS_SQ

Ilya Guterman (1):
      nvme-pci: add NVME_QUIRK_NO_DEEPEST_PS quirk for SOLIDIGM P44 Pro

Kees Cook (1):
      nvme-pci: make nvme_pci_npages_prp() __always_inline

Keith Busch (1):
      nvme-pci: acquire cq_poll_lock in nvme_poll_irqdisable

 drivers/nvme/host/core.c      | 30 +++++++++++++++++++++++++++---
 drivers/nvme/host/multipath.c |  3 ++-
 drivers/nvme/host/nvme.h      |  3 ++-
 drivers/nvme/host/pci.c       |  6 +++++-
 drivers/nvme/target/pci-epf.c | 39 +++++++++++++++++++++++----------------
 5 files changed, 59 insertions(+), 22 deletions(-)

