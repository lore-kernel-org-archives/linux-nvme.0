Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E358C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Nov 2022 10:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SYPASXJ2jdNa1i8h75ceFWByQEOrF1l7/PE3Mvcjeb0=; b=0H7spa2ADPOABw9vy8R4L4H58B
	WsDuXoWBLCJdhOw2cHAoo44cjpwtmgP1SRSTxfXbpEXyAFqPYn7v9bI4ncqG4Xp/0SmT3cLQBRRuG
	REpSGbB5oSXTmWtMFROaClRF5r8EbNzIH4cq70Y0yzeGCxSWP0seTxGeBREGRnklCRYo/8ZUQX4ht
	mabUHEIeh3Lexkg1aAfuB/6kvl0yv0hNApbtX+5c20wRL9GXB+utXjawPUhyqTygSq+opa9zH7UjC
	U8l5FTevUYoF8D3wbkAQpzma9kYZAT+Q6jfDdco+Tpkpd0ASWAQ9FnNGaCted5E14Ot5OqfUCky/X
	enM8ENJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ot4N5-004xT4-Kv; Thu, 10 Nov 2022 10:01:19 +0000
Received: from [89.144.222.196] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ot4N3-004xQs-TQ; Thu, 10 Nov 2022 10:01:18 +0000
Date: Thu, 10 Nov 2022 11:01:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvmes fixes for Linux 6.1
Message-ID: <Y2zL45ll7KIIc0zF@infradead.org>
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

The following changes since commit f829230dd51974c1f4478900ed30bb77ba530b40:

  block: sed-opal: kmalloc the cmd/resp buffers (2022-11-08 07:14:35 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.1-2022-11-10

for you to fetch changes up to e65fdf530f55c5e387db14470a59a399faa29613:

  nvmet: fix a memory leak (2022-11-09 14:29:13 +0100)

----------------------------------------------------------------
nvme fixes for Linux 6.1

 - quiet user passthrough command errors (Keith Busch)
 - fix memory leak in nvmet_subsys_attr_model_store_locked
 - fix a memory leak in nvmet-auth (Sagi Grimberg)

----------------------------------------------------------------
Aleksandr Miloserdov (1):
      nvmet: fix memory leak in nvmet_subsys_attr_model_store_locked

Keith Busch (1):
      nvme: quiet user passthrough command errors

Sagi Grimberg (1):
      nvmet: fix a memory leak

 drivers/nvme/host/core.c       | 3 +--
 drivers/nvme/host/pci.c        | 2 --
 drivers/nvme/target/configfs.c | 8 ++++++--
 3 files changed, 7 insertions(+), 6 deletions(-)

