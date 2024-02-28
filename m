Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BE6C47DD9
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Feb 2024 18:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=aEybhb5DKf8nVItUAdL+3MWNqoRa/GexTube2U7lHnQ=; b=qMBZLxZpQe6NC+5PlPlEjO0WDi
	SVOW+9DjJV/Ub6FzV8RBWVYYt4MemULxakg3IAwHD362iZzBofuy8o/vFW1FkPsL6QuaEWy33Pq62
	RMNGkjjkPrWHPUZ0z52rCgG4ZIcqaKBqgCFn3/IAGFSX2tcvBdy79+gSw1TdXmHv84OTJvLLejE6L
	bGeiq8Xg8KjzsRp1xXdyreukWQfk26TBweBmFfKnoTG9xFfF8RNMoChzWLh8jH6VwkSAYjFZP2V1e
	K3hFy/Uyj4IhxdblKFlEoCVXZ190i1kRkMM1i3vVzoB5Jb4h5YFMysoGYqws7YJyCTpB42e5G1DYe
	beHJg37Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfOPj-0000000ARDJ-1unp;
	Wed, 28 Feb 2024 18:12:19 +0000
Received: from [4.28.11.157] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfOPf-0000000ARC3-1JA1;
	Wed, 28 Feb 2024 18:12:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: convert nvme to atomic queue limits updates
Date: Wed, 28 Feb 2024 10:11:54 -0800
Message-Id: <20240228181215.873854-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi all,

this series converts nvme to the new atomic queue limit updates, and
as part of that refactors a lot of the setup code.  The first two
patches are block layer patches already sent out as part of the md
queue limits conversion and will hopefully get merged into Jens' tree
soon.

Diffstat:
 block/blk-settings.c          |   43 ++++
 drivers/nvme/host/apple.c     |   18 +-
 drivers/nvme/host/core.c      |  378 ++++++++++++++++++++----------------------
 drivers/nvme/host/fc.c        |    8 
 drivers/nvme/host/multipath.c |   13 -
 drivers/nvme/host/nvme.h      |   12 -
 drivers/nvme/host/rdma.c      |   13 -
 drivers/nvme/host/zns.c       |   24 --
 drivers/nvme/target/loop.c    |    5 
 include/linux/blkdev.h        |    3 
 10 files changed, 272 insertions(+), 245 deletions(-)

