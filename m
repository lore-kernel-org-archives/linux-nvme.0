Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F701C87FCA
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Jul 2025 14:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1idUh1jegaXThllqHigBe7SBw8P3SMuWB+tbTiKiD84=; b=ehAGgjZmsx1TLm+CwX3yvip9sp
	3SwxCn20op35EN/L2Es1+L2pSFRt0ksCOdNScReqflLw89MhlGpZe/JtcCwgHQ+ZptZfrW9gi17Om
	4Z9yqjH/d3ZcovSn6/SMJDk4CxsZdzIqK9a0W+VwdfrpF7rTtzW3flsL8m/lntQpGrRPK+V9/vN6S
	YPsvhNUy0nCBFo7//wUnXuLjJ8O6poRdDvsHYsKRBPkOVt4HzNZtlSmVvuKEpK/wXoebakUqlecoA
	TkRaoLZtf/PlI8C0twJHnFsaTaY8o4kuEwqdu6CXm5xFCBoIljC09VCMbpQYOcp1KrCrLqjIF09nZ
	v/HYOxwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhUPh-00000003rSh-1AuX;
	Thu, 31 Jul 2025 14:37:45 +0000
Received: from c-76-102-242-2.hsd1.ca.comcast.net ([76.102.242.2] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhTxD-00000003mgg-1oiG;
	Thu, 31 Jul 2025 14:08:19 +0000
Date: Thu, 31 Jul 2025 07:08:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for Linux 6.17
Message-ID: <aIt40gBo9MuyC9Y2@infradead.org>
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

The following changes since commit 5421681bc3ef13476bd9443379cd69381e8760fa:

  blk-ioc: don't hold queue_lock for ioc_lookup_icq() (2025-07-29 06:26:34 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.17-2025-07-31

for you to fetch changes up to 367c240b0a99c7ada700a44345dd3144a02b6164:

  nvme: fix various comment typos (2025-07-31 06:35:58 -0700)

----------------------------------------------------------------
nvme updates for Linux 6.17

 - add support for getting the FDP featuee in fabrics passthru path
   (Nitesh Shetty)
 - add capability to connect to an administrative controller
   (Kamaljit Singh)
 - fix a leak on sgl setup error (Keith Busch)
 - initialize discovery subsys after debugfs is initialized
   (Mohamed Khalfella)
 - fix various comment typos (Bjorn Helgaas)
 - remove unneeded semicolons (Jiapeng Chong)

----------------------------------------------------------------
Bjorn Helgaas (1):
      nvme: fix various comment typos

Jiapeng Chong (1):
      nvme-auth: remove unneeded semicolon

Kamaljit Singh (1):
      nvme: add capability to connect to an administrative controller

Keith Busch (1):
      nvme-pci: fix leak on sgl setup error

Mohamed Khalfella (1):
      nvmet: initialize discovery subsys after debugfs is initialized

Nitesh Shetty (1):
      nvmet: add support for FDP in fabrics passthru path

 drivers/nvme/host/auth.c       |  4 ++--
 drivers/nvme/host/core.c       | 16 ++++++++++++++++
 drivers/nvme/host/fc.c         |  4 ++--
 drivers/nvme/host/pci.c        |  2 +-
 drivers/nvme/host/tcp.c        |  2 +-
 drivers/nvme/target/core.c     | 12 ++++++------
 drivers/nvme/target/fc.c       |  6 +++---
 drivers/nvme/target/passthru.c |  2 ++
 drivers/nvme/target/rdma.c     |  6 +++---
 9 files changed, 36 insertions(+), 18 deletions(-)

