Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB34DC46467
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Jan 2023 05:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6ViBnn5rTvABzhDsmOUPIL37W9aUkZVjQn6d+l8lARw=; b=0z8rJFtojPGShMPZJsvr+wkIgA
	ESitCKM8Rmv/Iy/6jH4rWSgs+aRRuW3lOlNvFEEtK8fltqjwJqmWLakCYQ6UpdQCGuIyhDHqgxSPt
	NKrFTKcjNdGlT4ny1TxwpEaQWdG34dH7y869UCvmtLoof1ti05ZN1sw1MoBMT/P3nLt3lpH354b8N
	6KPdkFE4UXJaFtIQ08gUd+UkYEGcmDq89IX8XYFIFrWVagkoy1V/YuUKFdRl1Oa9NXv8vvtP39vHU
	OOAl/f4SNsen+k2utfnSVNN6K9vIHG96M8jUmwDq2hHzXe5z9uxyIBP0G/uUynN6Q7bpwzsSAsiPy
	BzUm9Ctg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIkKf-008Xx5-Tv; Fri, 20 Jan 2023 05:52:57 +0000
Received: from [2001:4bb8:19a:2039:1233:6ec3:7a32:5885] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIkKT-008XpC-5T; Fri, 20 Jan 2023 05:52:45 +0000
Date: Fri, 20 Jan 2023 06:52:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.2
Message-ID: <Y8osKhxLSgeKMrSj@infradead.org>
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

The following changes since commit 7746564793978fe2f43b18a302b22dca0ad3a0e8:

  block: fix hctx checks for batch allocation (2023-01-17 09:56:52 -0700)

are available in the Git repository at:

  ssh://git.infradead.org/var/lib/git/nvme.git tags/nvme-6.2-2023-01-20

for you to fetch changes up to 1c5842085851f786eba24a39ecd02650ad892064:

  nvme-pci: fix timeout request state check (2023-01-19 09:08:01 +0100)

----------------------------------------------------------------
nvme fixes for Linux 6.2

 - fix  controller shutdown regression in nvme-apple (Janne Grunau)
 - fix a polling on timeout regression in nvme-pci (Keith Busch)

----------------------------------------------------------------
Janne Grunau (2):
      nvme-apple: reset controller during shutdown
      nvme-apple: only reset the controller when RTKit is running

Keith Busch (1):
      nvme-pci: fix timeout request state check

 drivers/nvme/host/apple.c | 24 ++++++++++++++++++++----
 drivers/nvme/host/pci.c   |  2 +-
 2 files changed, 21 insertions(+), 5 deletions(-)

