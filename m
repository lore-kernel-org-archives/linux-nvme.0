Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04410C6FA82
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 17:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=z1ic8oYFVfQUTPidMvNyB/ScY0Gb81KAyOwCNx86r3o=; b=3c0Gn1PjPJ0/V9pTJbf0woZcnj
	NR+Vx2E+Bn4TKgBi5YH0C/q5WZJgNHkmKd1BtbSvgasgqtxrLwVTVULPEGrkfQKV8Pxjs0NVgf6ZG
	HVZ7L9KMQCcNgR77jkCVOWzdZb0IAWDbrxw1H1R0hyU0XMUdemU8xl698gj90Ra6QAgZvXHPn1Zk3
	e9PITIWRfsHvtmIJII1iM8CWnqTM6VFycOaFyfNvucEbDn0K0b958vJy7qXpGmhJpUH+fllTNPgfR
	/xkhx75HnwKTyywkNGnmmXv1UEcCpfFSN0B05xgfnIx6SSf08cR0zVrwBZFz7Lk5fO72Rs5CvCJQA
	gtR9rKLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oagr5-005LSX-1K; Tue, 20 Sep 2022 17:16:19 +0000
Received: from [77.247.85.102] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oagr1-005LR5-8X; Tue, 20 Sep 2022 17:16:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
Subject: consolidate tagset / misc request_queue allocation
Date: Tue, 20 Sep 2022 19:15:58 +0200
Message-Id: <20220920171611.1289361-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
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

this series consolidates the allocation and freeing of the tagsets
and misc (non-I/O) requests queues over the various fabrics drivers.

Eventually PCIe and the apple controller driver should use these
helpers as well, but that will require some additional cleanups of
the request_queue lifetime first.

Diffstat:
 host/core.c   |  100 +++++++++++++++++++++++++++++++++++++++++
 host/fc.c     |  121 +++++++++++--------------------------------------
 host/nvme.h   |   16 +++---
 host/rdma.c   |  141 +++++++++++++++-------------------------------------------
 host/tcp.c    |  118 +++++++++---------------------------------------
 target/loop.c |   91 +++++++++----------------------------
 6 files changed, 220 insertions(+), 367 deletions(-)

