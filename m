Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C0D6C636D4
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Feb 2023 18:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JQDo9eSogJXBMc9CSfG/vB0RLOaVwYu0XKME5Qid7hM=; b=3q6qhr0em7sMy4/hZ8IGYUhyJr
	fknZczr7DZs4hf5Mior3h01KbMVXJpRpZ1D+7Z+Spcrz97KRJnAQ63bqsCGwdIt5wm/dkoionURpe
	2bSelpnJuMvvIO++uDL6XMOxlbrRw6bKiXjx+bic8IyYJgyxg+i/fbB/FCbtiRHu58lrGvCV8WSfa
	TUNmZL/l4sjKYCQpTzvzD2jX7Lb/v17quIE/7mEts0f1U88x9aGysUmxYMBP2auMqziLprmxbkkIW
	NujL6VAan+A5fgJCm7+kK8psch7cTxBPFTYSsQaSludqoGXlYHBs+Q+3IsGZmnOsGniRchnSL4LKO
	7ScHOZZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSMJ0-006odL-N7; Wed, 15 Feb 2023 18:14:58 +0000
Received: from [2001:4bb8:181:6771:d204:2f73:7b8d:611c] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSMIy-006oc2-9s; Wed, 15 Feb 2023 18:14:56 +0000
Date: Wed, 15 Feb 2023 19:14:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.2
Message-ID: <Y+0hG6t1gTse7yfo@infradead.org>
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

The following changes since commit 38c33ece232019c5b18b4d5ec0254807cac06b7c:

  Merge tag 'nvme-6.2-2023-02-09' of git://git.infradead.org/nvme into block-6.2 (2023-02-09 08:12:06 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.2-2023-02-15

for you to fetch changes up to dc785d69d753a3894c93afc23b91404652382ead:

  nvme-pci: always return an ERR_PTR from nvme_pci_alloc_dev (2023-02-14 06:39:02 +0100)

----------------------------------------------------------------
nvme fixes for Linux 6.2

 - always return an ERR_PTR from nvme_pci_alloc_dev (Irvin Cote)
 - add bogus ID quirk for ADATA SX6000PNP (Daniel Wagner)
 - set the DMA mask earlier (Christoph Hellwig)

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme-pci: set the DMA mask earlier

Daniel Wagner (1):
      nvme-pci: add bogus ID quirk for ADATA SX6000PNP

Irvin Cote (1):
      nvme-pci: always return an ERR_PTR from nvme_pci_alloc_dev

 drivers/nvme/host/pci.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

