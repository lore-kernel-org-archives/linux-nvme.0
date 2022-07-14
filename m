Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D52C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jul 2022 14:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uD27qdxYN8lWOtvC15ApMDfnGoCi5Cne/k7LhGdN3N8=; b=YMGijuwwfeAuO1juxCOkHXMB47
	qDxXXOOX7l4hke9rlYu6gFGihqoJ6ZW8Cg2SBq8y0d4LqarU/jbgiuFhsE5Se5RpJqhKVlyvg0eOF
	7d0ix7aAXgwVFwFORhC+G0TCvLZsBND2Ym5QDozZyVkDT9Yb4DheZ/ypwi2EA6QReAlG4S0HzJw5F
	ZN99EO6O3yOCUd/gXityiDJa+Ty0+e4hzYeAXn6kvjMSwyYnwLvBSka9XcaVPoNH+n3Ls+fRJvLW9
	agYRDuB4TE/gPCUoXsXEtaZFJt6oilfuNXY1wWQygGZjw8d8gq3MwbbeEmR/m06RNuPQZnjBDD/cf
	q5uI56Ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBzyc-00FGtZ-AU; Thu, 14 Jul 2022 14:38:02 +0000
Received: from ip4d15c27d.dynamic.kabel-deutschland.de ([77.21.194.125] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBzya-00FGrX-9f; Thu, 14 Jul 2022 14:38:00 +0000
Date: Thu, 14 Jul 2022 16:37:58 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.19
Message-ID: <YtAqRsNAUZXA60+V@infradead.org>
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

The following changes since commit 6b0de7d0f3285df849be2b3cc94fc3a0a31987bf:

  Merge tag 'nvme-5.19-2022-07-07' of git://git.infradead.org/nvme into block-5.19 (2022-07-07 17:38:19 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.19-2022-07-14

for you to fetch changes up to 6961b5e02876b3b47f030a1f1ee8fd3e631ac270:

  nvme: fix block device naming collision (2022-07-14 16:35:25 +0200)

----------------------------------------------------------------
nvme fixes for Linux 5.19

 - fix a block device naming collision (Israel Rukshin)
 - fix freeze accounting for PCI error handling (Keith Busch)

----------------------------------------------------------------
Israel Rukshin (1):
      nvme: fix block device naming collision

Keith Busch (1):
      nvme-pci: fix freeze accounting for error handling

 drivers/nvme/host/core.c | 6 +++---
 drivers/nvme/host/pci.c  | 9 +++++++--
 2 files changed, 10 insertions(+), 5 deletions(-)

