Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF199C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 15:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1TanhPj1pvcWXIurjMX1HYDdYlrIVvvf4bEhTgkHyPM=; b=cz5XjsIa5zXvzIrJJrOZ4hx7Ko
	ZXkcUmsNlvyvcb/2uZ/6j5QaeF0t4aXCqqTcMC1a3wpogGRaMLYYDgqaIFPMheEvjpV6bsfWUSfKs
	FGv6rhJ16OY27ybDRnmugt7CR9p4Ylr1TIYtT4t7psDktTntSzNtnFvzeUMS7BRJlkYMOVU38VWZD
	1hfR5c55oYEWogBLWf1KCZa/wq1FW8P6cik+Zr6vut5IQJpPPa9MkUtQS9/Y+XfQPXCmVVEzRIqmF
	WjcAJQSQOJbZPmVHdMPoRiM+ZCk8s026KSGoHs/jsBVgFONKUBCGDGAR0PykahlSwkjzzW/GkuTfU
	oRab+g4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odv3Y-003jwa-SH; Thu, 29 Sep 2022 15:02:32 +0000
Received: from [2001:4bb8:180:b903:9be8:d11a:21a0:96eb] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odv3W-003jvq-GD; Thu, 29 Sep 2022 15:02:30 +0000
Date: Thu, 29 Sep 2022 17:02:28 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [GIT PULL] nvme fixes for Linux 6.0
Message-ID: <YzWzhIAX+vtSmo39@infradead.org>
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

The following changes since commit 4c66a326b5ab784cddd72de07ac5b6210e9e1b06:

  Revert "block: freeze the queue earlier in del_gendisk" (2022-09-20 08:15:44 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.0-2022-09-29

for you to fetch changes up to d14c273132aec81a1a8107c9ab4865b89e7910a7:

  nvme-pci: disable Write Zeroes on Phison E3C/E4C (2022-09-27 09:20:30 +0200)

----------------------------------------------------------------
nvme fixes for Linux 6.1

 - fix IOC_PR_CLEAR and IOC_PR_RELEASE ioctls for nvme devices
   (Michael Kelley)
 - disable Write Zeroes on Phison E3C/E4C (Tina Hsu)

----------------------------------------------------------------
Michael Kelley (1):
      nvme: Fix IOC_PR_CLEAR and IOC_PR_RELEASE ioctls for nvme devices

Tina Hsu (1):
      nvme-pci: disable Write Zeroes on Phison E3C/E4C

 drivers/nvme/host/core.c | 6 +++---
 drivers/nvme/host/pci.c  | 4 ++++
 2 files changed, 7 insertions(+), 3 deletions(-)

