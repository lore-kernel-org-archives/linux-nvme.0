Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C895CC19F2B
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jul 2022 15:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WQYkpy+Ys/D1auBSZUAVXib7a0WAy5gtMoYU+H97DjU=; b=vRWzhAA+C2p9asDxNs+lGwUgzU
	ay9jF85qL2mtOHSu0Dm+yv4dKbwqOVLpK9G/IPXZe6fOOrzNawZPiFayyX4RvXv4rYA8M2S/wrhrh
	j1Z9Od+tVpAHJPqIvx5rFKquv0J0sYbMnovif1JobJ6hOMy9gqL733aDV5vlYQVE08Io771Lgms3J
	f85JTitKGVvO8rPClxhIH04JglVOFMx82UyTYJKZjphWv/KlxuJHqd7Ga5IYnodiFC8/P/8wG7C1x
	8usA1L4g7trC2CN1h/o5uBshgi6yEqXxcQuMSiulTaa5sH7B1d5gmmu/i7L65mkHJQcAAm77MtLY8
	Iqmml9OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGjMp-00FFhe-J2; Wed, 27 Jul 2022 15:54:35 +0000
Received: from [2607:fb90:18d2:b6be:6d6f:ba8a:ca81:9775] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGjMo-00FFfc-2q; Wed, 27 Jul 2022 15:54:34 +0000
Date: Wed, 27 Jul 2022 11:54:31 -0400
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fix for Linux 5.19
Message-ID: <YuFftyWcAMRP/NC5@infradead.org>
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

The following changes since commit 82e094f7bd988c02df27f8c8d81af8f750660b2a:

  Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-5.19 (2022-07-19 12:42:33 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.19-2022-07-27

for you to fetch changes up to d6c52fa3e955b97f8eb3ac824d2a3e0af147b3ce:

  nvme-pci: Crucial P2 has bogus namespace ids (2022-07-25 07:34:07 +0200)

----------------------------------------------------------------
nvme fix for Linux 5.19

 - yet another duplicate ID quirk (Tobias Gruetzmacher)

----------------------------------------------------------------
Tobias Gruetzmacher (1):
      nvme-pci: Crucial P2 has bogus namespace ids

 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

