Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F266AC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Oct 2022 11:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xuI5WpzLw1rW8zeQaM0Q5WLGLHWTcZ4vvuuKWWp996U=; b=dPtw8ksf++0D/HXGPo4cyRf67w
	zskMK32K5lRyKJPXyMEtM+fXTY4ASS4A4o9050jsvXuKYFSlJwI4sWnPA3hZHXUtE++/m7vPt0KpL
	SurQ8ZX+LntMsiHdVB4dS4n4LYmqLrQjTmudvL1fn3HL53jpfZK5yIICnRVUtLMdfUOOeoA/nq1wZ
	kZeeywNFulz9z5Z4UFjwAExVykHoVQbjiJ7nZ6k67mynz53VBflkEZrqw44AJUCXJLKl1J31cbVyR
	jw4aQneOKMSXDeeViTRj2wdDaeP72/hCbCEBoAQ/CUb287Ieb278WszsOv+cDQm2NqI+7KY0E31wo
	sa734pWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oia99-007qfp-LA; Wed, 12 Oct 2022 11:43:35 +0000
Received: from 089144213149.atnat0022.highway.a1.net ([89.144.213.149] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oia96-007qez-Nj; Wed, 12 Oct 2022 11:43:34 +0000
Date: Wed, 12 Oct 2022 13:43:29 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.1
Message-ID: <Y0aoYSBCx2Wrw74I@infradead.org>
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

The following changes since commit 24a403340d70aad3667b3ee0f9a7aa5c0a5193a0:

  Merge branch 'for-6.1/block' into block-6.1 (2022-10-10 11:26:40 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.1-2022-10-12

for you to fetch changes up to 72e3b8883a36e80ebfa41015c7b6926ce31ace05:

  nvme-multipath: fix possible hang in live ns resize with ANA access (2022-10-12 11:42:58 +0200)

----------------------------------------------------------------
nvme fixes for Linux 6.1

 - add NVME_QUIRK_BOGUS_NID for Lexar NM760 (Abhijit)
 - avoid the deepest sleep state on ZHITAI TiPro5000 SSDs (Xi Ruoyao)
 - fix possible hang caused during ctrl deletion (Sagi Grimberg)
 - fix possible hang in live ns resize with ANA access (Sagi Grimberg)

----------------------------------------------------------------
Abhijit (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for Lexar NM760

Sagi Grimberg (3):
      nvme-rdma: fix possible hang caused during ctrl deletion
      nvme-tcp: fix possible hang caused during ctrl deletion
      nvme-multipath: fix possible hang in live ns resize with ANA access

Xi Ruoyao (1):
      nvme-pci: avoid the deepest sleep state on ZHITAI TiPro5000 SSDs

 drivers/nvme/host/multipath.c | 1 +
 drivers/nvme/host/pci.c       | 4 ++++
 drivers/nvme/host/rdma.c      | 2 +-
 drivers/nvme/host/tcp.c       | 2 +-
 4 files changed, 7 insertions(+), 2 deletions(-)

