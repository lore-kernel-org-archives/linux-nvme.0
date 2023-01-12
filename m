Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32899C54EBC
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jan 2023 08:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=e2kI7aQUDYcH/lJiomT62w0Uil99ZHDntE95VjNwqqk=; b=JIel+09ZjdsMwvckpQVQKUs96/
	F/yZODL8/b0z2+YdJmQJqE4lLBDevXGd1xo4T4rLQFyjhzVck6gx1IpHh2ZqhTltv9Yru1DinPZFs
	/PfVCQosWbdyF/3qRlsItVGQYOzoO7cbsURzv1qOpNuBCFrQ/IclbiZ44uE/0iYYGRWFaAuHbypTY
	LPJrHLBYKaWvqNUlxDfRWIpMV/JR0sCWg8mbz5zMv76ikMMH/0skCOyJkRWisYcrFVAFiGe/vfq1q
	myBAdeYAS8Yb33RfqCpn17zUu7iIkDcSJmHSkeAnwNWObAwhPWYzdstSneHDHkYgRY+nj7OnChSFU
	qwBOpNmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFstk-00E5sZ-Ga; Thu, 12 Jan 2023 08:25:20 +0000
Received: from [2001:4bb8:181:656b:c87d:36c9:914c:c2ea] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFsth-00E5sD-HA; Thu, 12 Jan 2023 08:25:17 +0000
Date: Thu, 12 Jan 2023 09:25:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.2
Message-ID: <Y7/D64Qubtqmdv04@infradead.org>
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

The following changes since commit 49e4d04f0486117ac57a97890eb1db6d52bf82b3:

  block: Drop spurious might_sleep() from blk_put_queue() (2023-01-08 20:29:28 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.2-2023-01-12

for you to fetch changes up to c7c0644ead24c59cc5e0f2ff0ade89b21783614a:

  MAINTAINERS: stop nvme matching for nvmem files (2023-01-10 08:16:39 +0100)

----------------------------------------------------------------
nvme fixes for Linux 6.2

 - Identify quirks for Apple controllers (Hector Martin)
 - fix error handling in nvme_pci_enable (Tong Zhang)
 - refuse unprivileged passthrough on partitions (Christoph Hellwig)
 - fix MAINTAINERS to not match nvmem subsystem headers (Russell King)

----------------------------------------------------------------
Christoph Hellwig (3):
      nvme: remove __nvme_ioctl
      nvme: replace the "bool vec" arguments with flags in the ioctl path
      nvme: don't allow unprivileged passthrough on partitions

Hector Martin (2):
      nvme-apple: add NVME_QUIRK_IDENTIFY_CNS quirk to fix regression
      nvme-pci: add NVME_QUIRK_IDENTIFY_CNS quirk to Apple T2 controllers

Russell King (Oracle) (1):
      MAINTAINERS: stop nvme matching for nvmem files

Tong Zhang (1):
      nvme-pci: fix error handling in nvme_pci_enable()

 MAINTAINERS               |   3 +-
 drivers/nvme/host/apple.c |   2 +-
 drivers/nvme/host/ioctl.c | 110 ++++++++++++++++++++++++++--------------------
 drivers/nvme/host/pci.c   |  12 +++--
 4 files changed, 75 insertions(+), 52 deletions(-)

