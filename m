Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2024C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jun 2022 19:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qKA/0EDphzmE7teYjAVKD3Zy6wo8eZpKG69ysKigGm4=; b=N8nFTAbgGapppfEyxetjRMWJj2
	Q9TI4bWmCDDATwXrfnAWmBfIyT3sUdgg5Y29Dz+1PLiofTFihTrjxUSDCARfLnij2VoOMqjJh4urE
	BOKHCqFRrgQcv24/ZwJ4R5Ib3uS3Vfop/vpPiu0vWNLVn3Iiy1pRh1AaoUuLm1Wox1cwD4ei5t2q2
	zpjAJCXUhJ3mWktYkgrEncEizDjeqi9H3mBR3su4+mV6NsPKV5/EFB8LDX8RDucri8hmwjJ3P3kKz
	JV2sPJiz+qHBSIKcPVJ9aou5nfc8ehBPEXJZ9LIJaqYo1nMBCjwLwMMmzrIUT6BVvIFhmt95a2aI3
	EJSDDqfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o706z-001Fi9-3I; Thu, 30 Jun 2022 19:46:01 +0000
Received: from [2001:4bb8:199:3788:3ea8:4fde:60a4:7dbf] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o706w-001FhN-Iv; Thu, 30 Jun 2022 19:45:59 +0000
Date: Thu, 30 Jun 2022 21:45:56 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvmes fixes for Linux 5.19
Message-ID: <Yr39dC2Hf2/LtgXq@infradead.org>
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

The following changes since commit fbb564a557809466c171b95f8d593a0972450ff2:

  lib/sbitmap: Fix invalid loop in __sbitmap_queue_get_batch() (2022-06-25 10:58:55 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.19-2022-06-30

for you to fetch changes up to e1c70d79346356bb1ede3f79436df80917845ab9:

  nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA IM2P33F8ABR1 (2022-06-30 08:24:33 +0200)

----------------------------------------------------------------
nvme fixes for Linux 5.19

 - more quirks (Lamarque Vieira Souza, Pablo Greco)
 - fix a fabrics disconnect regression (Ruozhu Li)
 - fix a nvmet-tcp data_digest calculation regression (Sagi Grimberg)
 - fix nvme-tcp send failure handling (Sagi Grimberg)
 - fix a regression with nvmet-loop and passthrough controllers
   (Alan Adamson)

----------------------------------------------------------------
Alan Adamson (1):
      nvmet: add a clear_ids attribute for passthru targets

Lamarque Vieira Souza (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA IM2P33F8ABR1

Pablo Greco (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA XPG SX6000LNP (AKA SPECTRIX S40G)

Ruozhu Li (1):
      nvme: fix regression when disconnect a recovering ctrl

Sagi Grimberg (2):
      nvmet-tcp: fix regression in data_digest calculation
      nvme-tcp: always fail a request when sending it failed

 drivers/nvme/host/core.c       |  2 ++
 drivers/nvme/host/nvme.h       |  1 +
 drivers/nvme/host/pci.c        |  5 +++-
 drivers/nvme/host/rdma.c       | 12 ++++++---
 drivers/nvme/host/tcp.c        | 13 ++++++----
 drivers/nvme/target/configfs.c | 20 +++++++++++++++
 drivers/nvme/target/core.c     |  6 +++++
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/passthru.c | 55 ++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/tcp.c      | 23 +++---------------
 10 files changed, 109 insertions(+), 29 deletions(-)

